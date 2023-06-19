
# Data Cleansing with SQL (on BigQuery)

This repository contains SQL code for data cleansing on a dataset using BigQuery. The code aims to clean the dataset before utilising it for the Authors Executive Dashboard on Microsoft Power BI. (https://happy-cheque-975.notion.site/Allie-s-Portfolio-f47523a9e71c4f3997ab260746d9c8ee)

## Objective

The objective is to clean the Audible dataset to create an executive dashboard for book authors. The dashboard provides an overview of their overall sales, sales trend, top 5 bestselling books, and distributions in different countries in one place. However, the dataset requires cleansing as the `Audio_Runtime` field, representing duration, is in a non-numeric format (e.g., xx hours and XX minutes). This format hinders data analysis. Therefore, I will demonstrate a simple yet effective method to address this issue.

## Tech Stack

The tech stack used for this project includes:

1. Google Cloud Platform (Cloud Storage, BigQuery) for storing, cleaning, and preparing the Audible dataset before visualization.
2. Microsoft Power BI, which connects with the Google BigQuery connector to visualize the data in real-time (imports at intervals).


## Code Explanation

The provided SQL code performs the following operations:

1. First, a common table expression (CTE) called `runtime_calc` is created. It calculates the converted audio runtime for each book. Since the `Audio_Runtime` field is in string format, the CTE extracts the hours and minutes and converts them to a numeric value representing the total runtime in hours. 

    The challenge/annoyance lies in handling different representations of hours and minutes (e.g., 5 hours, 5 hours and 5 minutes, 1 hour, 5 minutes, and 1 minute). Additionally, the CTE handles edge cases where the `Audio_Runtime` field has values such as 'Not Yet Known' or 'Less than 1 minute' by converting them to `NULL` and `0` respectively, instead of treating them as string values.

2. Next, the `audible_data` table is joined with the `runtime_calc` CTE to retrieve the necessary fields for further analysis.

3. The data is then cleansed by removing unwanted characters and converting the `Rating` field to a float value.

4. The cleaned dataset includes fields such as `timestamp`, `country`, `user_id`, `Book_ID`, `Book_Title`, `Book_Subtitle`, `Book_Author`, `Book_Narrator`, `Audio_Runtime`, `converted_audio_runtime`, `Audiobook_Type`, `Categories`, `Total_No__of_Ratings`, `Price`, and `THBPrice`.



# Key Takeaways

1. It would have been better if I had thought more thoroughly about how and why I needed the runtime data. In the end, I realized that the duration of the audiobook might not be particularly useful in giving the author an overview of what's happening with their books on the Audible platform. This experience was crucial for me to constantly remind myself, even before starting any work, to consider what I am doing, why I am doing it, who my audience is, and what kind of dashboard they expect to see.
2. Nonetheless, I also learned how to start cleaning data when receiving very messy data. I explored the data through simple SQL `DISTINCT` queries and repeatedly checked if my code was finally usable.

# Future improvement

- I should have a better approach to exploring data, especially when it comes in the `String` datatype. It can be a bit challenging to identify patterns using SQL alone. I might consider using Python to generate a word cloud or any other quick and easy visualization to observe the data patterns more effectively.



