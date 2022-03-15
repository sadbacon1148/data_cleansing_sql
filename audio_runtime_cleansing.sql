with runtime_calc as 
( select distinct Book_ID, Audio_Runtime 
--hr
  ,  IFNULL(CAST(CASE WHEN NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute') like '%hr and%' 
          THEN REGEXP_EXTRACT(NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute'), r"(\d+) hr")END as numeric),0) -- as hr
  + IFNULL(CAST(REGEXP_EXTRACT(NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute'), r"(\d+) hrs") as numeric),0) --as hrs
-- min
+  (IFNULL(CAST(CASE WHEN NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute') like '% min' 
          THEN REGEXP_EXTRACT(NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute'), r"(\d+) min") end as numeric),0) -- as min
  +  IFNULL(CAST(REGEXP_EXTRACT(NULLIF(NULLIF(Audio_Runtime,'Not Yet Known'),'Less than 1 minute'), r"(\d+) mins") as numeric),0))/60 as converted_audio_runtime
 
  FROM `r2de2-workshop.test.audible_data` 
)

select t.timestamp, t.country, t.user_id, t.Book_ID, Book_Title, Book_Subtitle, Book_Author, Book_Narrator, t.Audio_Runtime
, r.converted_audio_runtime, Audiobook_Type, Categories, Total_No__of_Ratings, Price, t.THBPrice 
, CAST(NULLIF(REPLACE(Rating,'out of 5 stars',''),'Not rated yet') as FLOAT64) as clean_rating
FROM `r2de2-workshop.test.audible_data` t
left join runtime_calc r
on t.Book_ID = r.Book_ID 