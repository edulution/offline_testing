/*Get the total number of content items in each channel*/
CREATE VIEW contents_by_channel AS
SELECT channel_id,
       count(channel_id) AS total_items,
       kind
FROM ext.content_contentnode
WHERE kind NOT IN ('topic',
                   'channel')
GROUP BY channel_id,
         kind;