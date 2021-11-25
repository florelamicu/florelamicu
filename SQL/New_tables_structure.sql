CREATE TABLE Tweet_User

     (user_id INT PRIMARY KEY,
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
     user_created_at timestamp);	  



CREATE TABLE Tweet_Reply

        (tweet_Reply_id serial   PRIMARY KEY,
	tweet_id BIGINT,
	in_reply_to_screen_name varchar ( 15) NULL, 
	in_reply_to_status_id BIGINT NULL,
	in_reply_to_user_id INT);


	
CREATE TABLE Tweet_Retweet 

        (retweet_id serial  Primary KEY,
	retweet_of_tweet_id BIGint  , 
	retweet_count INT,
	tweet_id BIGINT);
	
	
	
	
CREATE TABLE Tweet_source 

	(tweet_id BIGINT  PRIMARY KEY,
	tweet_source VARCHAR ( 200 )  NOT NULL,
	text VARCHAR ( 220) NOT NULL,
	retweet_id BIGINT  REFERENCES Tweet_Retweet, 
	tweet_Reply_id BIGINT  REFERENCES Tweet_Reply,
	user_id	 INT REFERENCES Tweet_User,
	created_at  timestamp);

  
 
  	  
CREATE TABLE Tweet_hashtag 

	(hashtagid serial PRIMARY KEY ,		
        hashtag VARCHAR ( 150)  NULL,
	tweet_id BIGINT,
	CONSTRAINT fk_Tweet_source
        FOREIGN KEY(tweet_id) 
	REFERENCES Tweet_source(tweet_id));

