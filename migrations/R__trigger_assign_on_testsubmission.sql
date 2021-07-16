-- Trigger function to assign a single learner. It is an exact copy of assignmembership but without any looping of learners
CREATE OR REPLACE FUNCTION tf_assign_learner()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$BODY$
BEGIN
	DECLARE

	sPos varchar(10);
	classroomRow RECORD;


	currChannelId uuid;
	currCourse text;
	currCourseFamily text;
	currSortOrder integer;

	nextChannelId uuid;
	nextCourse text;
	nextCourseFamily text;
	nextSortOrder integer;
	newCollectionId uuid;

	newDataSet_id uuid;


	BEGIN
	/********************************************************
	*) Delete all learnergroup memberships for the user supplied
	*) Loop through all learners in live learners table
	*) Find the highest passed test for the inputted module
	*) Find the course family (or first if no test is passed)
	*) Find the group on Kolibri in the same class the learner is already in,
		with the corresponding course family name
	*) Create a membership in the learnergroup
	*********************************************************/

		sPos := '00';

		/*Delete all existing learnergrooup memberships for the inputted user and repopulate them in Stored proc*/
		DELETE
		FROM ext.kolibriauth_membership
		WHERE collection_id IN
		    (SELECT id
		     FROM ext.kolibriauth_collection
		     WHERE kind IN ('learnergroup'))
		    and user_id = NEW.user_id;


		sPos := '10';

		sPos := '20';

		/*Set all variables to NULL*/

		currCourse := NULL;

		currCourseFamily := NULL;

		currSortOrder := NULL;

		nextCourse := NULL;

		nextCourseFamily := NULL;

		nextSortOrder := NULL;

		sPos := '30';

		/*Get the course, course_family and sort order of the highest test passed for each learner*/
		SELECT course,
		       course_family,
		       sort_order INTO currCourse,
		                       currCourseFamily,
		                       currSortOrder
		FROM get_highest_passed_test(NEW.user_id, NEW.module,'TST');

		sPos := '40';

		 /*If no test has been passed, get the course with the lowest sort order in the module*/
		IF currCourse IS NULL THEN 

			sPos := '50';

			SELECT course_family INTO nextCourseFamily
			FROM course
			WHERE module = NEW.module
			  AND sort_order =
			    (SELECT min(sort_order)
			     FROM course
			     WHERE module = NEW.module);

		ELSE
			/*If a test has been passed, get the next course in the same module*/
			SELECT course_family
			FROM get_next_course(currSortOrder, NEW.module) INTO nextCourseFamily;

			sPos := '60';

		END IF;

		 sPos := '70';

		/*Loop through all of the classrooms the user is currently enrolled in*/
		FOR classroomRow IN
		SELECT *
		FROM get_user_classrooms(NEW.user_id)
		LOOP
		/*Get the dataset_id and collection_id for all the learnergroups in the classroom
		where the name of the group is the same as the name of the course family the learner should be in
		*/
			SELECT id,
			       dataset_id INTO newCollectionId,
			                       newDataSet_id
			FROM ext.kolibriauth_collection
			WHERE name = nextCourseFamily
			  AND kind = 'learnergroup'
			  AND parent_id = classroomRow.id;

			 sPos := '80';

			/*Create a membership for the learner in that learnergroup*/
			INSERT INTO ext.kolibriauth_membership (id, _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
			VALUES (uuid_generate_v4() , TRUE,
			          (SELECT REPLACE (newCollectionId::text,
			                           '-',
			                           '')),
			          (SELECT REPLACE (newDataSet_id::text,
			                           '-',
			                           '')), newCollectionId ,
			                                 newDataSet_id ,
			                                 NEW.user_id);

		END LOOP; /*classroomRow*/

		sPos := '90';


		sPos := '100';
			

		RAISE NOTICE 'Procedure Sucessful' ;

		EXCEPTION WHEN OTHERS THEN

		RAISE NOTICE 'Procedure Failed' ;

		RAISE NOTICE 'Transaction Rolled Back' ;

		RAISE INFO 'Failed after Position= %',
		            sPos;

		RAISE INFO 'SQL STATE= %',
		            SQLSTATE;

		RAISE INFO 'SQL ERRM= %',
		            SQLERRM;

	END;
	RETURN NULL; -- Return nothing because it's an after trigger


END;
$BODY$;

-- Drop the trigger on responses if it already exists
DROP TRIGGER if exists trigger_assign_learner_on_testsubmit ON responses;

-- Create trigger on responses table after every insert on this table
CREATE TRIGGER trigger_assign_learner_on_testsubmit
  AFTER INSERT
  ON responses
  FOR EACH ROW
  EXECUTE PROCEDURE tf_assign_learner();