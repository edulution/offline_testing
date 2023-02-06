from kolibri.core.auth.models import (
    FacilityUser,
    Facility,
    Classroom,
    LearnerGroup,
    Membership,
    Role,
    Collection,
)


def get_all_users():
    """Function to get all of the users on the device that are not admins or coaches
    Args:
        None
    Returns:
        A django rawquery object of FacilityUsers
    """
    # use raw SQL to get all the users that are not admin/coach
    all_users_query = """"select * from kolibriauth_facilityuser
        where id not in
        (select user_id from kolibriauth_role where kind in ('admin','coach'))"""
    all_users = FacilityUser.objects.raw(all_users_query)

    # return the list
    return all_users


def is_admin(user):
    """Tells us whether a user is an admin or coach
    Args:
        user (FacilityUser): A reference to the FacilityUser object to interrogate
    Returns:
        Boolean: True if the user is an admin or coach. False if not
    """
    # Get a list of all of the role objects of kind admin or coach
    admin_roles = Role.objects.filter(kind__in=["admin", "coach"])

    # Get the user_ids associated with the roles
    admin_role_ids = [role.user_id for role in admin_roles]

    # check if the user passed in appears in the list above
    # return the boolean result
    return user.id in admin_role_ids


def get_user_info(username, facility):
    # Get a reference to the user that has logged in
    user_logged_in = FacilityUser.objects.get(username=username, facility_id=facility)

    # Get a reference to the facility the user belongs to
    facility_for_user = Facility.objects.get(id=facility)

    print(
        "User logged in is: {}. Is admin/coach?: {}".format(
            user_logged_in, is_admin(user_logged_in)
        )
    )

    if is_admin(user_logged_in):
        return None
    else:
        print("user is not admin")
        return user_logged_in, facility_for_user


def enroll_into_class(user, classroom):
    """
    Enroll a user into a specified classroom in a facility.
    The Classroom object already has a reference to the Facility it belongs to
    Classroom is the next level of organization below Facility
    A FacilityUser can be enrolled into multiple Classrooms in the same Facility
        Args:
            user (FacilityUser): The FacilityUser to be enrolled
            classroom (Classroom): The Classroom to enroll into
        Returns:
            None
    """

    membership_exists = Membership.objects.filter(
        user=user, collection=classroom
    ).exists()
    # Check if a Membership for the FacilityUser already exists in the Classroom
    if membership_exists:
        print(
            "Membership for user: {} in classroom {} already exists".format(
                user.username, classroom.name
            )
        )

    # If no membership already exists, create it
    else:
        print("No memberships found for user")
        Membership.objects.create(user=user, collection=classroom)
        print(
            "Creating Membership for user: {} in classroom {}".format(
                user.username, classroom.name
            )
        )


def enroll_into_group(user, learnergroup):
    """
    Enroll a user into a specified LearnerGroup in a facility.
    LearnerGroup is the next level of organization below Classroom
    A FacilityUser can be enrolled into multiple LearnerGroups in the same Classrooms
        Args:
            user (FacilityUser): The FacilityUser to be enrolled
            learnergroup (LearnerGroup): The LearnerGroup to enroll into
        Returns:
            None
    """

    # Check if a Membership for the FacilityUser already exists in the Classroom
    if Membership.objects.filter(user=user, collection=learnergroup).exists():
        print(
            "Membership for user: {} in learnergroup {} already exists".format(
                user.username, learnergroup.name
            )
        )

    # If no membership already exists, create it
    else:
        print("No memberships found for user")
        Membership.objects.create(user=user, collection=learnergroup)
        print(
            "Creating Membership for user: {} in learnergroup {}".format(
                user.username, learnergroup.name
            )
        )


def remove_all_memberships(user):
    """
    Remove all of a user's Memberships in Classrooms and LearnerGroups
        Args:
            user (FacilityUser): The user to strip of all memberships
        Returns:
            None
    """
    if Membership.objects.filter(user=user).exists():
        # Get a count of how many Memberships the user has
        membership_count = Membership.objects.filter(user=user).count()

        # Print out the count
        print(
            "Found {} Membership(s) for user: {}".format(
                membership_count, user.username
            )
        )
        # Delete all of the Memberships
        Membership.objects.filter(user=user).delete()
        print("Deleting all Memberships for user: {}".format(user))

    else:
        print("No Memberships found for user")


def get_group_with_keyword(keyword, classroom):
    """
    Get a set of groups which contain the specified keyword
    and are children of the Classroom object supplied
        Args:
            keyword (String): Expected name of LearnerGroup
            classroom (Classroom): Parent Classroom of the LearnerGroup
        Returns:
            A list of LearnerGroup objects which have name containing the keyword
    """
    if LearnerGroup.objects.filter(name=keyword).exists():
        groups = LearnerGroup.objects.filter(name=keyword)
        return groups
    else:
        raise ValueError(
            "Unable to find group with name containing {} in classroom {}".format(
                keyword, classroom.name
            )
        )


def auth_hieracrhy_check(facility, user, classroom, learnergroup):
    """
    Check that Facility, FacilityUser, Classroom and LearnerGroup are all in agreement
    i.e
        User belongs to Facility
        Classroom belongs to Facility
        LearnerGroup belongs to Classroom

        Args:
            facility (Facility)
            user (FacilityUser)
            classroom (Classroom)
            learnergroup (LearnerGroup)

        Returns:
            Boolean: True if all agree. False if not
    """

    # Create an empty dictionary object
    sanity_check = {}

    # Check facility and user agree
    sanity_check["Facility and User"] = facility.id == user.facility_id
    # Chek Facility and Classroom agree
    sanity_check["Facility and Classroom"] = facility.id == classroom.parent_id
    # Check Classroom and LearnerGroup
    sanity_check["Classroom and LearnerGroup"] = classroom.id == learnergroup.parent_id

    # Get keys from sanity check if value is False
    not_agreeing = [k for k, v in sanity_check.items() if not v]

    # Any False values are found
    if not_agreeing:
        # Print out the keys not agreeing and return False
        print("{} not agreeing".format(", ".join(not_agreeing)))
        return False
    else:
        print("Auth hieracrhy check passed")
        # Return True
        return True
