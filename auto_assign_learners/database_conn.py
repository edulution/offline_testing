from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy.orm import sessionmaker, mapper, aliased, clear_mappers
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.engine.url import URL, make_url
from classes import TestResult, Course, ChannelMeta


def connect_to_db(user, password, host, port, name):
    """
    Create a SQLAlchemy connection to a postgresql database
        Args:
          user (string): Database user
          password (string): Database Password
          host (string): Database host
          port (integer): Database port
          name (string): Database name

        Returns:
          sqlalchemy.Engine: a connection object to the database and its DBAPI
    """
    # Create a database url object with a postgresql driver
    database_url = URL(
        drivername='postgresql',
        username=user,
        password=password,
        host=host,
        port=port,
        database=name)

    # Create the engine
    engine = create_engine(make_url(database_url))

    # Connect the engine - lazy connection that doesnt do anything until data requested
    try:
        engine.connect()
        # Get the metadata of the engine(used when mapping classes to tables)
        metadata = MetaData(engine)

    except (Exception, SQLAlchemyError) as e:
        print ("Error while connecting to the database", e)

    return engine, metadata


def create_dbsession(engine):
    """
    Create a session object bound to a database engine. Enables us to use sqlalchemy ORM
        Args:
          engine (sqlalchemy.Engine): a database connection object
        Returns:
          Session: a session object to interact with the database
    """
    # Create the session for any time we need to have a conversation with the database
    try:
        Session = sessionmaker(bind=engine)
    except (Exception,SQLAlchemyError) as e:
        print ("Error while creating session object", e)
  
  # Create instance of the Session object
    session = Session()

    return session


def get_highest_passed_test(isession, iuser_id, imodule):
  """ 
  Get the higest test a user has passed
    Args:
      isession (Session): A SQLAlchemy database session
      iuser_id (String): The user_id of the user (or uuid as string)
      imodule (String): The module of the test (e.g numeracy, literacy)

    Returns:
      A TestResult object of the highest test passed by the user in the module
  """

  # Query vresponsescore for tests that the user has passed
  # Filter out tests where sort order is null (currently only zm_gr7_tests)
  # Order by sort order in descending order (higest sort order at the top)
  # Fetch the top row
  tests_passed_query = isession.query(TestResult) \
  .filter_by(
    user_id = iuser_id,
    passed = True,
    module = imodule) \
  .filter(TestResult.sort_order.isnot(None)) \
  .order_by(TestResult.sort_order.desc()) \
  .limit(1)
  
  # If the query returns nothing, return None
  if tests_passed_query.first() == None:
    return None
  else:
    # If the query has output rows, get only one and return the TestResult object
    return tests_passed_query.one()


def get_next_course(isession, itestresult, imodule='numeracy'):
  """
  Get the next course a user should do based on their testresult
    Args:
      isession (Session): A SQLAlchemy database session
      itestresult (TestResult): A TestResult object

    Returns:
      A Course object of the next course recommended to the user
  """

  # If the learner has never writeen a test,
  # get the lowest course in the module
  if itestresult == None:
    lowest_course_query = isession.query(Course) \
      .filter_by(
        module = imodule) \
      .order_by(Course.sort_order) \
      .limit(1)
    return lowest_course_query.one()

  # If the testresult has no sort order, return None
  if itestresult.sort_order == None:
    return None

  # Initialize query to get the current course corresponding to the test
  current_course_query = isession.query(Course) \
    .filter_by(
      course = itestresult.course,
      sort_order = itestresult.sort_order,
      module = itestresult.module) \
    .order_by(Course.sort_order) \
    .limit(1)

  # If the test was not passed, return the current course
  if not itestresult.passed:
    return current_course_query.one()

  else:
    # If the test was passed
    # Get the course with the next sort order in the same module as the test that was passed
    next_course_query = isession.query(Course) \
      .filter(Course.sort_order > itestresult.sort_order) \
      .filter_by(module = itestresult.module) \
      .order_by(Course.sort_order) \
      .limit(1)

      # If next course query returns any rows
      # it means that the user has already passed the test with the highest sort order available for that module
      # Return the same course that matches the one that was passed
    if next_course_query.first() == None:
      return current_course_query.one()

      # If the next course query returns rows, return the next course object
    else:
      return next_course_query.one()


def has_written_test_in_course(isession, iuser_id, icourse):
  """
  Find out whether or not a user has written a test in a specified course
    Args:
      isession (Session): A SQLAlchemy database session
      iuser_id (String): user_id (or uuid) of the user in question
      icourse (Course): A Course object

    Returns:
      Boolean : True if the user has written a test in the course, False if not
  """
  test_exists_query = isession.query(TestResult) \
    .filter_by(
      user_id = iuser_id,
      course = icourse.course,
      sort_order = icourse.sort_order,
      module = icourse.module) \
    .first()

  # Return Boolean of whether the query has a result or not
  return bool(test_exists_query)