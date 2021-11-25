                      1. Tweets, users and languages


a) How many tweets are there in total?

	SELECT 
	COUNT(*) AS total_tweet
	FROM Tweet_source

b) How are these tweets distributed across languages? Write a query that shows,
   for every  language ( user_lang ) the number of tweets in that language.

	SELECT user_lang, 
	COUNT(*) AS total_tweet_Per_Language
	FROM Tweet_user
	GROUP BY 1	
	

c) Compute, for each language, the fraction of total tweets that have that language setting, 
   as well as the fraction of the number of users that have that language setting.
 
        SELECT user_lang,t.user_id , 
        (COUNT(user_lang) * 1.0/ (SELECT COUNT(*) FROM Tweet_source) ) AS Fraction_user_lang,
	(COUNT(t.user_id) * 1.0/ (SELECT COUNT(*) FROM Tweet_source) ) AS Fraction_user
	FROM Tweet_source t INNER JOIN Tweet_user u 
	ON t.user_id = u.user_id
	GROUP BY 1,2


--------------------------------------------------------------------------------------------


			    2. Retweeting habits
									
a) What fraction of the tweets are retweets ?               

        SELECT 
	t.tweet_id,
	(COUNT( rt.tweet_id) * 1.0/ (SELECT COUNT(*) FROM Tweet_source) ) AS Fraction_Tweet
	FROM Tweet_source t 
	INNER JOIN Tweet_Retweet rt
	ON t.retweet_id = rt.retweet_id
	GROUP BY 1
	
	
	
b) Compute the average number of retweets per tweet.   

        SELECT
	t.tweet_id,
	AVG( rt.retweet_count) AS Avg_Retweet
	FROM Tweet_source t 
	INNER JOIN Tweet_Retweet rt
	ON t.retweet_id = rt.retweet_id
	GROUP BY 1



c)  What fraction of the tweets are never retweeted?

        SELECT 
	t.tweet_id,
	(COUNT( t.tweet_id) * 1.0/ (SELECT COUNT(*) FROM Tweet_source) ) AS Fraction_Tweet
	FROM Tweet_source t 
	LEFT JOIN Tweet_Retweet rt
	ON t.retweet_id = rt.retweet_id
	WHERE t.retweet_id is  null
	GROUP BY 1


d) What fraction of the tweets are retweeted fewer times than the average number of retweets  (and  what does this say about the distribution)?

 
        SELECT
        TT.tweet_id, 
        TT.Fraction_Tweet, 
        TT.Avg_Retweet 
        FROM
        (SELECT t.tweet_id,
        (COUNT( rt.tweet_id) * 1.0/ (SELECT COUNT(*) FROM Tweet_source) ) AS Fraction_Tweet,
	AVG( rt.retweet_count) AS Avg_Retweet
	FROM Tweet_source t 
	INNER JOIN Tweet_Retweet rt
	ON t.retweet_id = rt.retweet_id
	GROUP BY 1
	) TT
	WHERE TT.Fraction_Tweet < TT.Avg_Retweet

-----------------------------------------------------------------------------------------------------



                                   3. Hashtags
								   
								   
a) What is the number of distinct hashtags found in these tweets?    

      SELECT DISTINCT hashtag 
      FROM  Tweet_hashtag



b) What are the top ten most popular hashtags, by number of usages?


       SELECT hashtag, 
       COUNT( hashtag ) AS Top_Hashtags
       FROM Tweet_hashtag
       GROUP BY 1
       ORDER BY 2 DESC LIMIT 10 


c) Write a query giving, for each language, the top three most popular hashtags in that language.

      SELECT
      hashtag,user_lang, COUNT( hashtag )
      FROM  Tweet_hashtag
      JOIN tweet_source
      ON  Tweet_hashtag.tweet_id = tweet_source.tweet_id
      JOIN tweet_user
      ON tweet_source.user_id = tweet_user.user_id
      GROUP BY 1,2
      ORDER BY 3 DESC LIMIT 3



--------------------------------------------------------------------------------------------------


                                      4. Replies
									  
a)  How many tweets are neither replies, nor replied to?

         SELECT COUNT(*) AS  count_Noreply
         FROM tweet_source
         WHERE tweet_Reply_id IS NULL


b) If a user user1 replies to another user user2 , what is the probability that they have the same  language setting?

          SELECT  user_lang,
          COUNT(user_lang)*1.0/(SELECT count(tweet_id) FROM tweet_source) AS Prob_UselangSetting
          FROM tweet_source AS  ts
          JOIN tweet_reply AS tu
          ON ts.tweet_Reply_id= tu.tweet_Reply_id
          JOIN tweet_user AS tu1
          ON ts.user_id=tu1.user_id
          GROUP BY 1


c) How does this compare to the probability that two arbitrary users have the same language  setting?
   Throughout, you may create views that support your queries.

           WITH lang_setting AS( 
           SELECT   ts.user_id,
           COUNT(user_lang)*1.0/(SELECT count(tweet_id) FROM tweet_source) AS Prob_UselangSetting
           FROM tweet_source AS  ts
           JOIN tweet_reply AS tu
           ON ts.tweet_Reply_id= tu.tweet_Reply_id
           JOIN tweet_user AS tu1
           ON ts.user_id=tu1.user_id
           AND tu1.user_lang = tu1.user_lang
           GROUP BY 1
           ) 
           SELECT * FROM lang_setting ORDER BY RANDOM() LIMIT 2