import kolibri  # noqa: F401
import django

django.setup()

import sys  # noqa: E402
import os  # noqa: E402

from sqlalchemy import create_engine, MetaData, Table  # noqa: E402
from sqlalchemy.orm import sessionmaker, mapper, aliased, clear_mappers  # noqa: E402
from sqlalchemy.exc import SQLAlchemyError  # noqa: E402
from sqlalchemy.engine.url import URL, make_url  # noqa: E402
from classes import TestResult, Course, ChannelMeta  # noqa: E402

from kolibri.core.auth.models import Collection  # noqa: E402

# Import functions from assignment helpers and database connection scripts
from assignment_helpers import (
    get_all_users,
    is_admin,
    get_user_info,
    enroll_into_class,
    get_group_with_keyword,
    auth_hieracrhy_check,
    remove_all_memberships,
    enroll_into_group,
)  # noqa: E402

from database_conn import (
    connect_to_db,
    create_dbsession,
    get_highest_passed_test,
    get_next_course,
    has_written_test_in_course,
)  # noqa: E402

# Create global vars for database config from env vars
dbname = os.environ["BASELINE_DATABASE_NAME"]
dbpassword = os.environ["BASELINE_DATABASE_PASSWORD"]
dbuser = os.environ["BASELINE_DATABASE_USER"]
dbhost = os.environ["BASELINE_DATABASE_HOST"]
dbport = os.environ["BASELINE_DATABASE_PORT"]


# initialize the engine, metadata and session
engine, metadata = connect_to_db(dbuser, dbpassword, dbhost, dbport, dbname)
session = create_dbsession(engine)

# Map the vresponsescore table to the TestResult class
testresult = Table("vresponsescore", metadata, autoload=True)
# user_id is not really a primary key, but allows us to filter testresults
# TODO: Add unique id column to responses table and propagate to vresponsescore view
mapper(TestResult, testresult, primary_key=testresult.c.user_id)

# Map the course table to the Course class
course = Table("vresponsescore", metadata, autoload=True)
mapper(Course, course, primary_key=[course.c.course, course.c.module])

# Map the channelmetdata table in ext schema to the ChannelMeta class
channelmeta = Table("content_channelmetadata", metadata, autoload=True, schema="ext")
mapper(ChannelMeta, channelmeta, primary_key=channelmeta.c.id)


def assign_learner(
    username, facility_id, active_class="Live Learners", module="numeracy"
):
    """
    Main assign learner function
    Enrolls a user into the live learners class in their facility
    and the appropriate group according to the highest baseline test they have passed

        Args:
            username (String): username of the user
            facility_id (String): facility_id the user belongs to
            active_class (String): Keyword in of class in which to assign learners logged in.
                Default is Live Learners
            module (String): The module to be considered for this user e.g numeracy,literacy

        Returns:
            None
    """

    # Get FacilityUser and Facility objects from the user details supplied
    user, facility = get_user_info(username, facility_id)

    # If the user is not an admin/coach, user object will be True
    if user:
        print("user_id: {}".format(user.id))

        highest_test_passed = get_highest_passed_test(session, user.id, module)
        if highest_test_passed is None:
            print(
                """Learner has either never passed a test or written a test.
                Attempting to assign to first course in module"""
            )
        else:
            print("Higest test passed: {}".format(highest_test_passed.test))

        next_course = get_next_course(session, highest_test_passed)

        print("Next course: {}".format(next_course.course))

        # Get a list of all classrooms in the facility that contain the active class keyword
        live_learners_classes = Collection.objects.filter(
            name__contains=active_class, parent_id=facility.id
        )

        group_name = str(
            session.query(ChannelMeta).filter_by(id=next_course.channel_id).one().name
        )

        print("Suggested group: {}".format(group_name))

        for class_obj in list(live_learners_classes):
            suggested_groups = get_group_with_keyword(group_name, class_obj)

            for group in suggested_groups:
                if auth_hieracrhy_check(facility, user, class_obj, group):
                    remove_all_memberships(user)
                    enroll_into_class(user, class_obj)
                    enroll_into_group(user, group)

                else:
                    raise ValueError(
                        "Unable to assign learner. Kindly check the errors above"
                    )

            # # Separate assignment for Grade 7
            # gr7_course = session.query(Course).filter_by(course = 'zm_gr7_revision').limit(1).one()
            # has_written_gr7_test = has_written_test_in_course(session, user.id, gr7_course)
            # if has_written_gr7_test:
            #   print("Has written gr7 test: {}".format(has_written_gr7_test))
            #   assign_specific_course(user, gr7_course, class_obj, facility)


def assign_specific_course(user, course, classroom, facility):
    """
    Assign a learner to a specific course
    Uses the course name from the course object
    Enrolls the learner into the group in the classroom containing the course name
        Args:
            user (FacilityUser): The user to enroll
            course (Course): The course to lookup the suggested group
            classroom (Classroom): The classroom that the group belongs to

        Returns:
            None
    """
    group_name = str(
        session.query(ChannelMeta).filter_by(id=course.channel_id).one().name
    )

    suggested_groups = get_group_with_keyword(group_name, classroom)

    for group in suggested_groups:
        if auth_hieracrhy_check(facility, user, classroom, group):
            enroll_into_group(user, group)
        else:
            raise ValueError(
                "Unable to assign learner by specifc course. Kindly check the errors above"
            )


if __name__ == "__main__":
    # Run assign learner for the learner passed in and numeracy module
    assign_learner(sys.argv[1], sys.argv[2])
