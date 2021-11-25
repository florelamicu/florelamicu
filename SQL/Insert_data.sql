
INSERT INTO Tweet_User
	
	(user_id ,
	user_name  ,
	user_screen_name ,
	user_location ,
	user_utc_offset ,
	user_time_zone ,
	user_followers_count ,
	user_friends_count ,
	user_lang ,
	user_description,
	user_status_count ,
	user_created_at)
        SELECT
	user_id ,
	user_name  ,
	user_screen_name ,
	user_location ,
	user_utc_offset ,
	user_time_zone ,
	user_followers_count ,
	user_friends_count ,
	user_lang ,
	user_description,
        CAST (user_status_count AS INTEGER) as user_status_count,
        user_created_at 
        FROM public.bad_giant_table
        GROUP BY
        user_id ,
	user_name  ,
	user_screen_name ,
	user_location ,
	user_utc_offset ,
	user_time_zone ,
	user_followers_count ,
	user_friends_count ,
	user_lang ,
	user_description,
	user_status_count,
	user_created_at
	



INSERT INTO  Tweet_Reply
	
	(tweet_id ,
	in_reply_to_screen_name , 
	in_reply_to_status_id ,
	in_reply_to_user_id)
        SELECT
	tweet_id ,
	in_reply_to_screen_name , 
	in_reply_to_status_id ,
	in_reply_to_user_id
	FROM public.bad_giant_table 
	WHERE in_reply_to_screen_name IS NOT NULL
	AND in_reply_to_status_id IS NOT NULL
	AND in_reply_to_user_id IS NOT NULL
	
	
	
	
	
	
INSERT INTO Tweet_source 

	(tweet_id,
	tweet_source,
	text ,
	tweet_Reply_id,
	user_id,
	created_at)
	SELECT
	Tweet_reply.tweet_id,
	tweet_source,
	text ,
	tweet_Reply_id,
	user_id,
	created_at
	FROM public.bad_giant_table
	JOIN Tweet_reply
	ON Tweet_reply.tweet_id = bad_giant_table.tweet_id
	WHERE bad_giant_table.in_reply_to_screen_name IS NOT NULL
	AND bad_giant_table.in_reply_to_status_id IS NOT NULL
	AND bad_giant_table.in_reply_to_user_id IS NOT NULL
	
	
	
	
INSERT INTO Tweet_Retweet
 
	(retweet_of_tweet_id,
	retweet_count,
	tweet_id)	
	SELECT
        retweet_of_tweet_id,
	retweet_count,
	tweet_id
	FROM public.bad_giant_table
	where retweet_of_tweet_id IS NOT NULL
		
	
	
	
INSERT INTO Tweet_source 

	(tweet_id,
	tweet_source,
	text ,
	retweet_id,
	user_id,
	created_at)
	SELECT 
	Tweet_Retweet.tweet_id,
	tweet_source,
	text ,
	retweet_id,
	user_id,
	created_at
	FROM public.bad_giant_table
	JOIN Tweet_Retweet
	ON Tweet_Retweet.tweet_id = bad_giant_table.tweet_id
        WHERE bad_giant_table.retweet_of_tweet_id IS NOT NULL
	 
	 
	 
	 
INSERT INTO Tweet_hashtag (tweet_id,hashtag)	
    			
SELECT tweet_id, hashtag1 from public.bad_giant_table where hashtag1 IS NOT NULL
UNION 
SELECT tweet_id, hashtag2 from public.bad_giant_table where hashtag2 IS NOT NULL
UNION
SELECT tweet_id, hashtag3 from public.bad_giant_table where hashtag3 IS NOT NULL
UNION 
SELECT tweet_id, hashtag4 from public.bad_giant_table where hashtag4 IS NOT NULL
UNION 
SELECT tweet_id, hashtag5 from public.bad_giant_table where hashtag5 IS NOT NULL
UNION 
SELECT tweet_id, hashtag6 from public.bad_giant_table where hashtag6 IS NOT NULL