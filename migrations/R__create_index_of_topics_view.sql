CREATE OR REPLACE VIEW public.index_of_topics AS
SELECT cnodes.title AS topic_name,
       metadata.name AS channel_name,
       topics_count.number_of_items,
       topics_count.topic_id,
       cnodes.channel_id
FROM
  (SELECT parent_id AS topic_id,
          count(id) AS number_of_items
   FROM ext.content_contentnode
   WHERE kind::text = ANY (ARRAY['exercise'::character varying, 'video'::character varying]::text[])
   GROUP BY parent_id) topics_count
LEFT JOIN ext.content_contentnode cnodes ON topics_count.topic_id = cnodes.id
LEFT JOIN ext.content_channelmetadata metadata ON cnodes.channel_id = metadata.id;