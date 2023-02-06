/*Create a view that shows summary stats for each learner in each playlist*/
CREATE VIEW learner_prog_by_playlist AS
SELECT time_prog.user_id,
       ku.username,
       ku.full_name,
       ku.username||' : '||ku.full_name AS username_full_name,
                           time_prog.channel_id,
                           m.name AS playlist,
                           tot_time_spent,
                           tot_complete,
                           n.total_items,
                           round((tot_complete/n.total_items * 100)::decimal,2) AS prog_pct
FROM
  (SELECT user_id,
          channel_id,
          round((sum(time_spent)/3600)::decimal,2) AS tot_time_spent,
          sum(progress) AS tot_complete
   FROM ext.logger_contentsummarylog
   GROUP BY user_id,
            channel_id)time_prog
LEFT JOIN contents_by_channel n ON time_prog.channel_id = n.channel_id
LEFT JOIN ext.content_channelmetadata m ON time_prog.channel_id = m.id
LEFT JOIN ext.kolibriauth_facilityuser ku ON time_prog.user_id = ku.id
INNER JOIN users blu ON time_prog.user_id = blu.user_id;