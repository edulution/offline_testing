-- PROCEDURE: public.spassignmembership()

-- DROP PROCEDURE public.spassignmembership();

CREATE OR REPLACE PROCEDURE public.spassignmembership(
	i_module character varying
	)
LANGUAGE 'plpgsql'

AS $BODY$
DECLARE
sPos varchar(10);
learnerRow RECORD;


zarchive_breakoffdate timestamp := now() - INTERVAL '90 DAYS';

currChannelId uuid;
nextChannelId uuid;
newCollectionId uuid;
newDataSet_id uuid;

nextCourse text;
nextCourseFamily text;
nextSortOrder integer;

currCourse text;
currCourseFamily text;
currSortOrder integer;

classroomRow RECORD;

playListID varchar(50);

sDataSet varchar(100);

BEGIN
/********************************************************
*) Delete all learnergroup membership
*) Loop through all learners in live learners table
*) Find the highest passed test for the inputted module
*) Find the course family (or first if no test is passed)
*) Find the group on Kolibri in the same class the learner is already in,
	with the corresponding course family name
*) Create a membership in the learnergroup
*********************************************************/

sPos := '00';
	/*** Delete all existing memberships and repopulate them in Stored proc **/
	DELETE FROM ext.kolibriauth_membership 
	WHERE collection_id IN (SELECT id FROM  ext.kolibriauth_collection WHERE kind IN ('learnergroup'));

sPos := '00';
/****
Loop through all learners that have logged in the last NN days
*****/
FOR learnerRow IN SELECT user_id FROM live_learners
where user_id not in
(select user_id from ext.kolibriauth_role
where kind in ('coach','admin'))
LOOP
	sPos := '10';

		sPos := '100';

			currCourse := Null;
			currCourseFamily := Null;
			currSortOrder := Null;
			
			nextCourse := Null;
			nextCourseFamily := Null;
			nextSortOrder := Null;


		sPos := '105';

			SELECT course, course_family, sort_order
			INTO  currCourse, currCourseFamily, currSortOrder

			from
				get_highest_passed_test(learnerRow.user_id, i_module);

			sPos := '110';
			/****** No test has been passed. Set them up at first channel **/
			IF currCourse IS NULL THEN

					sPos := '200';
					SELECT course_family 
					INTO nextCourseFamily
					FROM  course
					WHERE module = i_module
					AND  sort_order = (SELECT min(sort_order) FROM course WHERE module = i_module);
			ELSE

					select course_family from get_next_course(currSortOrder, i_module)
					into nextCourseFamily;
			END IF;

			sPos := '410';

			FOR classroomRow IN SELECT * FROM get_user_classrooms(learnerRow.user_id)
			LOOP
				SELECT 	id, dataset_id
				INTO 	newCollectionId, newDataSet_id
				FROM  	ext.kolibriauth_collection
				where   name = nextCourseFamily
				and kind = 'learnergroup'
				and parent_id = classroomRow.id;

				sPos := '420';

				/***** Insert into membership ***/
				INSERT INTO ext.kolibriauth_membership  (
					id, _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
				VALUES
					(uuid_generate_v4()	, true, (SELECT REPLACE (newCollectionId::text, '-', '')), (SELECT REPLACE (newDataSet_id::text, '-', '')), 
					newCollectionId  ,  newDataSet_id ,	learnerRow.user_id);
			END LOOP;

			sPos := '430';

			END IF;*/
END Loop;   /*learnerRow*/

sPos := '2000';
	

RAISE NOTICE  'Procedure Sucessful' ;

EXCEPTION WHEN OTHERS THEN
	ROLLBACK;
	RAISE NOTICE  'Procedure Failed' ;
	RAISE NOTICE  'Transaction Rolled Back' ;
	RAISE INFO 'Failed after Position= %',sPos;
	RAISE INFO 'SQL STATE= %', sqlstate;
	RAISE INFO 'SQL ERRM= %', SQLERRM;

END;

$BODY$;
