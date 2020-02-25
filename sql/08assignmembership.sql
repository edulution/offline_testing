-- PROCEDURE: public.spassignmembership()

-- DROP PROCEDURE public.spassignmembership();

CREATE OR REPLACE PROCEDURE public.spassignmembership(
	)
LANGUAGE 'plpgsql'

AS $BODY$
DECLARE
sPos varchar(10);
learnerRow RECORD;
moduleRow record;

zarchive_breakoffdate timestamp := now() - INTERVAL '90 DAYS';

currSortOrder integer;

currChannelId uuid;
nextChannelId uuid;
newCollectionId uuid;
newDataSet_id uuid;

playListID varchar(50);

sDataSet varchar(100);

BEGIN
/********************************************************
*) Delete all learners in membership with learnergroup or classroom
*) First step is to loop through all learners that have logged in within the last 90 days
*) For each learner loop through all modules.
*) Find the passed test with highest sort order
*) Find the next test (or first if no test is passed)
*) Find that channel
*) Find the first content with that channel. 
	Assuming that all memberships are added incrementaly --> so min(length) will find the first one
*) Insert to membership. 
****** Step 2
*) Loop through all learners
*) Assign learners to either all available 'learnergroups' or Zarchive
*) Assign all live learners to class "On Program"

*********************************************************/

sPos := '00';
	/*** Delete all existing memberships and repopulate them in Stored proc **/
	DELETE FROM ext.kolibriauth_membership 
	WHERE collection_id IN (SELECT id FROM  ext.kolibriauth_collection WHERE kind IN ('learnergroup',  'classroom'));

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

	INSERT INTO ext.kolibriauth_membership(
				"id", _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
			(SELECT uuid_generate_v4()	, true, (SELECT REPLACE (id::text, '-', '')), (SELECT REPLACE (DataSet_id::text, '-', '')),  id ,  DataSet_id , learnerRow.user_id
			FROM ext.kolibriauth_collection
			WHERE kind = 'classroom'
			AND upper(name)  IN ('LIVE LEARNERS'));
			sPos := '2020';


	/*** Loop through all modules, once per learner */
	FOR moduleRow IN 	SELECT  distinct module 
						FROM course 
						WHERE channel_id IS NOT NULL
	LOOP

	sPos := '100';
	/****
	Find the last passed test
	using distinct in case test written more than once.
	****/
		nextChannelId := Null;
	sPos := '105';
		SELECT distinct channel_id, sort_order
		INTO  nextChannelId, currSortOrder
		FROM  vresponsescore r
		WHERE passed IS TRUE
		AND user_id = learnerRow.user_id
		AND module = moduleRow.module
		AND sort_order = 
		(SELECT max(sort_order) from vresponsescore resp
		WHERE resp.user_id = r.user_id
		AND   resp.module = r.module
		AND 	passed IS TRUE);

		sPos := '110';
		/****** No test has been passed. Set them up at first channel **/
		IF nextChannelId IS NULL THEN
				/** Get the first channel ID ***/
				sPos := '200';
				SELECT channel_id 
				INTO nextChannelId
				FROM  course
				WHERE module = moduleRow.module
				AND  sort_order = (SELECT min(sort_order) FROM course WHERE module = moduleRow.module );
		ELSE
				/* A Test has been past, get the next channel after this test ***/
				/** Get the next channel ID ***/
				sPos := '300';
				SELECT channel_id 
				INTO nextChannelId
				FROM  course
				WHERE module = moduleRow.module
				AND  sort_order = (SELECT min(sort_order) FROM course 
								   WHERE module = moduleRow.module
									AND sort_order > currSortOrder);
		END IF;

		IF nextChannelId IS NOT NULL THEN
				/**** Now a channel has been found. Then get the play list *****/

				sPos := '400';		
				/*** Get the PlayList as text, without uuid. 
					Add % so it can be used for LIKE statment ****/
				SELECT 	'%' || replace(id::text,'-','') ||'%'
				INTO	playListID
				FROM  	ext.content_channelmetadata		
				WHERE	id = nextChannelId;

				sPos := '410';
				/**** Get the collection ID & dataset id *****/
				/**** As we assume that all subscriptions add previous to the subscription playlists. We want the 
					  first (min(length)) as we assume this is the first in line ******/
				SELECT 	id, dataset_id
				INTO 	newCollectionId, newDataSet_id
				FROM  	ext.kolibriauth_collection
				where   subscriptions LIKE playListID
				and kind = 'learnergroup'
				-- TODO : use channel name instead of length of channel subscriptions to select the next channel id
				AND  length (subscriptions) = (SELECT min( length (subscriptions) )FROM  ext.kolibriauth_collection
				where    subscriptions LIKE  playListID
				and kind = 'learnergroup' );

				sPos := '420';

				/***** Insert into membership ***/
				INSERT INTO ext.kolibriauth_membership  (
					id, _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
				VALUES
					(uuid_generate_v4()	, true, (SELECT REPLACE (newCollectionId::text, '-', '')), (SELECT REPLACE (newDataSet_id::text, '-', '')), 
					newCollectionId  ,  newDataSet_id ,	learnerRow.user_id);

				sPos := '430';

		END IF;

	END LOOP;  /*moduleRow*/	
END Loop;   /*learnerRow*/

/*************************************************************************
Now, do classroom assignments. Either 
**************************************************************************/
sPos := '1000';
/***
Loop through all learners
***/
FOR learnerRow IN SELECT id as user_id, last_login FROM ext.kolibriauth_facilityuser 
where id not in
(select user_id from ext.kolibriauth_role
where kind in ('coach','admin'))
LOOP
	sPos := '1020';
	IF learnerRow.last_login <  zarchive_breakoffdate THEN
	/**** If login was more than NN days ago it should be added to zarchieve  ****/
	sPos := '1030';	
		/***** Insert into membership ***/
		INSERT INTO ext.kolibriauth_membership(
			id, _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
		(SELECT uuid_generate_v4()	, true, (SELECT REPLACE (id::text, '-', '')), (SELECT REPLACE (DataSet_id::text, '-', '')),  id ,  DataSet_id , learnerRow.user_id
		FROM ext.kolibriauth_collection
		WHERE kind = 'classroom'
		AND upper(name) like 'ZARCHIVE');
		
		sPos := '1040';		
	 ELSE
	 	/**** If learner is active --> assign all classrooms that are not zarchive ******/
		sPos := '1050';
		INSERT INTO ext.kolibriauth_membership(
			"id", _morango_dirty_bit, _morango_source_id, _morango_partition, collection_id, dataset_id, user_id)
		(SELECT uuid_generate_v4()	, true, (SELECT REPLACE (id::text, '-', '')), (SELECT REPLACE (DataSet_id::text, '-', '')),  id ,  DataSet_id , learnerRow.user_id
		FROM ext.kolibriauth_collection
		WHERE kind = 'classroom'
		AND upper(name) NOT IN ('ZARCHIVE','LIVE LEARNERS'));
		
		sPos := '1060';		
	END IF;
	sPos := '1070';
END LOOP;
sPos := '1080';

/******
Assign classes to "Live Learners"
******/ 
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
