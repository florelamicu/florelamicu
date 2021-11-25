1. New design/tables

Create table Tweet_User

(
user_id INT PRIMARY KEY,
user_name  Varchar(20),
user_screen_name Varchar(20),
user_location Varchar(40),
user_utc_offset INT,
user_time_zone Varchar(40),
user_followers_count INT,
user_friends_count INT,
user_lang Varchar(10),
user_description Varchar(170),
user_status_count int,
user_created_at timestamp	  
)



CREATE TABLE Tweet_Reply(

	tweet_Reply_id serial   PRIMARY KEY,
	tweet_id BIGINT,
	in_reply_to_screen_name varchar ( 15) NULL, 
	in_reply_to_status_id BIGINT NULL,
	in_reply_to_user_id INT );


	
Create table Tweet_Retweet ( 

	retweet_id serial  Primary KEY,
	retweet_of_tweet_id BIGint  , 
	retweet_count INT,
	tweet_id BIGINT	
	);
	
	
	
CREATE TABLE Tweet_source (

	tweet_id BIGINT  PRIMARY KEY,
	tweet_source VARCHAR ( 200 )  NOT NULL,
	text VARCHAR ( 220) NOT NULL,
	retweet_id BIGINT  REFERENCES Tweet_Retweet, 
	tweet_Reply_id BIGINT  REFERENCES Tweet_Reply,
	user_id	 INT REFERENCES Tweet_User,
	created_at  timestamp
  );
  
 
 
  
  	  
CREATE TABLE Tweet_hashtag (
	hashtagid serial  primary key ,		
    hashtag VARCHAR ( 150)  NULL,
	tweet_id BIGINT,
	CONSTRAINT fk_Tweet_source
      FOREIGN KEY(tweet_id) 
	 REFERENCES Tweet_source(tweet_id)
);




-------------------------------------------------------------

2. Populate the tables

INSERT into Tweet_User
	(
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
	user_status_count ,
	user_created_at 
	)
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
group by 
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
	(
	tweet_id ,
	in_reply_to_screen_name , 
	in_reply_to_status_id ,
	in_reply_to_user_id
	)
	SELECT
	tweet_id ,
	in_reply_to_screen_name , 
	in_reply_to_status_id ,
	in_reply_to_user_id
	FROM public.bad_giant_table 
	where in_reply_to_screen_name is not null
	and in_reply_to_status_id is not null
	and in_reply_to_user_id is not null
	
	
	
	
	
	
	Insert into Tweet_source (
	tweet_id,
	tweet_source,
	text ,
	tweet_Reply_id,
	user_id,
	created_at
	)
	Select 
	Tweet_reply.tweet_id,
	tweet_source,
	text ,
	tweet_Reply_id,
	user_id,
	created_at
	from public.bad_giant_table
	join Tweet_reply
	On Tweet_reply.tweet_id = bad_giant_table.tweet_id
	where bad_giant_table.in_reply_to_screen_name is not null
	and bad_giant_table.in_reply_to_status_id is not null
	and bad_giant_table.in_reply_to_user_id is not null
	
	
	
	
	Insert into Tweet_Retweet ( 
	retweet_of_tweet_id,
	retweet_count,
	tweet_id	
	)
	Select 
	retweet_of_tweet_id,
	retweet_count,
	tweet_id
	FROM public.bad_giant_table
	where retweet_of_tweet_id is not null
		
	
	
	
	Insert into Tweet_source (
	tweet_id,
	tweet_source,
	text ,
	retweet_id,
	user_id,
	created_at
	)
	Select 
	Tweet_Retweet.tweet_id,
	tweet_source,
	text ,
	retweet_id,
	user_id,
	created_at
	from public.bad_giant_table
	join Tweet_Retweet
	On Tweet_Retweet.tweet_id = bad_giant_table.tweet_id
     where bad_giant_table.retweet_of_tweet_id is not null
	 
	 
	 
	 
    Insert into Tweet_hashtag (
    tweet_id,
	hashtag	
	)	
select tweet_id, hashtag1 from public.bad_giant_table where hashtag1 is not null
UNION 
select tweet_id, hashtag2 from public.bad_giant_table where hashtag2 is not null
UNION
select tweet_id, hashtag3 from public.bad_giant_table where hashtag3 is not null
UNION 
select tweet_id, hashtag4 from public.bad_giant_table where hashtag4 is not null
UNION 
select tweet_id, hashtag5 from public.bad_giant_table where hashtag5 is not null
UNION 
select tweet_id, hashtag6 from public.bad_giant_table where hashtag6 is not null



---------------------------------------------------------------------------------------------------------------------
3. Run SQL queries     

                       1. Tweets, users and languages


a) How many tweets are there in total?

	Select 
	count(*) as total_tweet
	from Tweet_source;

b) How are these tweets distributed across languages? Write a query that shows,
 for every  language ( user_lang ) the number of tweets in that language.

	Select 
	user_lang, 
	count(*) as total_tweet_Per_Language
	 from Tweet_user
	group by 1;
	
	


c) compute, for each language, the fraction of total tweets that have that language setting, as well as the fraction of the number of users that have that language setting.
 
Select 
	user_lang,t.user_id , (count(user_lang) * 1.0/ (select count(*) from Tweet_source) ) as Fraction_user_lang,
	 (count(t.user_id) * 1.0/ (select count(*) from Tweet_source) ) as Fraction_user
	 from Tweet_source t inner join Tweet_user u 
	 on t.user_id = u.user_id
	group by 1,2; 


---------------------------------------------




						2. Retweeting habits
									
a) What fraction of the tweets are retweets ?               

Select 
	t.tweet_id,
	(count( rt.tweet_id) * 1.0/ (select count(*) from Tweet_source) ) as Fraction_Tweet
	 from Tweet_source t 
	inner join Tweet_Retweet rt
	 on t.retweet_id = rt.retweet_id
	group by 1
	
	
	
b) Compute the average number of retweets per tweet.   


Select 
	t.tweet_id,
	avg( rt.retweet_count) as Avg_Retweet
	 from Tweet_source t 
	inner join Tweet_Retweet rt
	 on t.retweet_id = rt.retweet_id
	group by 1



c)  What fraction of the tweets are never retweeted?

Select 
	t.tweet_id,
	(count( t.tweet_id) * 1.0/ (select count(*) from Tweet_source) ) as Fraction_Tweet
	 from Tweet_source t 
	left  join Tweet_Retweet rt
	 on t.retweet_id = rt.retweet_id
	 where t.retweet_id is  null
	group by 1


d) What fraction of the tweets are retweeted fewer times than the average number of retweets  (and  what does this say about the distribution)?

 

select TT.tweet_id, 
TT.Fraction_Tweet, 
TT.Avg_Retweet from 
(
Select 
	t.tweet_id,
	(count( rt.tweet_id) * 1.0/ (select count(*) from Tweet_source) ) as Fraction_Tweet,
	avg( rt.retweet_count) as Avg_Retweet
	 from Tweet_source t 
	inner join Tweet_Retweet rt
	 on t.retweet_id = rt.retweet_id
	group by 1
	) TT
	where TT.Fraction_Tweet < TT.Avg_Retweet

-----------------------------------------------------------------------------------------------------





                                   3. Hashtags
								   
								   
a) What is the number of distinct hashtags found in these tweets?    ( In correct )


Select distinct hashtag 
from  Tweet_hashtag



b) What are the top ten most popular hashtags, by number of usages?


Select hashtag, 
count( hashtag ) as Top_Hashtags
from  Tweet_hashtag
group by 1
order by 2 desc limit 10 


c) Write a query giving, for each language, the top three most popular hashtags in that language.

Select hashtag,user_lang, count( hashtag )
from  Tweet_hashtag
join tweet_source
on  Tweet_hashtag.tweet_id = tweet_source.tweet_id
join tweet_user
on tweet_source.user_id = tweet_user.user_id
group by 1,2
order by 3 desc limit 3



--------------------------------------------------------------------------------------------------



                                      4. Replies
									  
a)  How many tweets are neither replies, nor replied to?

select count(*) as  count_Noreply
from tweet_source
where tweet_Reply_id is null



b) If a user user1 replies to another user user2 , what is the probability that they have the same  language setting?



Select   user_lang,
COUNT(user_lang)*1.0/(SELECT count(tweet_id) FROM tweet_source) as Prob_UselangSetting
from tweet_source as  ts
JOIN tweet_reply as tu
on ts.tweet_Reply_id= tu.tweet_Reply_id
join tweet_user as tu1
on ts.user_id=tu1.user_id
group by 1


c) How does this compare to the probability that two arbitrary users have the same language  setting?
Throughout, you may create views that support your queries.

WITH lang_setting AS( 
Select   ts.user_id,
COUNT(user_lang)*1.0/(SELECT count(tweet_id) FROM tweet_source) as Prob_UselangSetting
from tweet_source as  ts
JOIN tweet_reply as tu
on ts.tweet_Reply_id= tu.tweet_Reply_id
join tweet_user as tu1
on ts.user_id=tu1.user_id
AND tu1.user_lang = tu1.user_lang
group by 1
) 
Select * from lang_setting ORDER BY RANDOM() LIMIT 2