# Analysis of Vehicle Collisions in Maryland 
## INFO 201 "Foundational Skills for Data Science" — Summer 2023

Authors: Jessica Wang, Meha Singal, ChuFeng Wang
Group: AA 4

Link to Shiny App:
**https://msingal.shinyapps.io/final-deliverable-p03-mehasingal/**

# Introduction

<<<<<<< HEAD
Project Overview

Our project centers on investigating the primary factors influencing automobile accidents in Maryland using a comprehensive dataset from the Maryland State Police's Automated Crash Reporting System (ACRS). Our objective is to identify patterns, correlations, and trends that can guide road safety policies and interventions
This data set includes characteristics of accidents reported by callers/police such as date, weather, surface condition, (driver) substance abuse, injury severity, distraction, speed limit, and vehicle model and make; all of which will help us formulate important research questions.
These research questions include:
What factors contribute most to automobile accidents in Maryland, and how do they vary across counties and local roads?"),
 What are the most common types of vehicle collisions among this data?"),
 Are there correlations between vehicle make/model and accident severity, revealing potential vehicle safety concerns?"),
How has substance abuse impacted the number of vehicle collisions, especially in relation to the effects of the COVID-19 pandemic?"),
This dataset was sourced from the Maryland State Police's ACRS and is publicly available for analysis. You can access the dataset at the following link:[Maryland ACRS Dataset](https://catalog.data.gov/dataset/crash-reporting-drivers-data)
The data includes 162,992 observations with 43 features, encompassing various aspects of accidents in Maryland. Some ethical considerations we had to keep in mind while working on this analysis include data accuracy, fairness, and privacy, as the data comes from reporting parties and is preliminary.
Some limitations of this dataset mostly involve the dataset's regional focus, lack of contextual information prior to incidents, and varying severity levels. Possible under reporting, data quality issues, and human errors may also affect our conclusions.
Through this project, we aim to provide insights that can influence road safety measures and contribute to accident prevention in Maryland
=======
testing
>>>>>>> 91e1a19 (Jessica's test)


# Conclusion / Summary Takeaways

Takeaway #1 - Our first takeaway is from the Collision Types visualization. The first thing we notice is that the most common way collisions occur is from the same direction rear end bar. We see that through the years 2015 to 2023, this bar still stays as the most occurred type of collision. However, when taking a deeper look, we discern that over the years, the number of these collisions is decreasing overall. From 2015-2016, there were 14869 same direction rear end collisions recorded, and from 2022-2023, there was a total of 7824, revealing a decrease of approximately 47.36%. We see the biggest decrease after the 2019-2020 period. It fell from 11092 to 8761 in 2020-2021, producing a 21.05% decrease. This was most likely due to the COVID-19 pandemic as people were required to isolate. This observation could also be applied to the other collision types as they have also decreased overall since 2015.

Takeaway #2 - There were a lot of interesting takeaways from the graphs showcasing the percentage of vehicle collisions in relation to different types of substance abuse the driver was involved with. The “All” graph calculating the percentage of the proportion of vehicle crashes displays a very good overview of the trend that was seen across most types, with the biggest dip occurring in 2020 due to the COVID-19 pandemic, but maintaining an overall downward trend in % of crashes involving substance abuse. The substance abuse types with, on average, the highest percentage of collisions across all of the years were “Illegal Drugs Contributed” in 2021, with 20% of crashes confirmed to involve illegal drugs, and “Medication Contributed” with 19.7% in 2017. The substance abuse types that saw the biggest decreases from 2015 to 2022 (not counting 2023 since it hasn’t been a full year) were “Combination Contributed” and “Illegal Drug Contributed”, which both saw an 8-9% drop in percentage of collisions involving that type of abuse. However, both graphs experienced a massive spike  in 2021, then an immediate fall of about 14-17% to their record low numbers in 2022. This could have been due to policy, population, or supply issues, depending on what exact substances were involved. Overall, these graphs should not be considered the end-all-be-all of substance abuse rates in vehicle collisions, but convey consistent enough trends of dropping occurrences after the COVID-19 pandemic to call for further investigation into the impacts of the virus on the driving and substance abuse habits of Americans.

Takeaway #3 -  To answer our third research question, there are notable correlations between the vehicle make and the severity of the injury. From the Vehicle Make and Model visualization, we observed that the two vehicle makes that have the greatest number of car incidents/injuries were either a Honda or a Toyota. To narrow down our scope, in the possible injury graph, we see that Toyotas yield a high of 2873, which is 811.75% higher than the lowest make which is Chevrolet yielding a count of 315. That is a significant difference. In the fatal injury graph, we see that Honda is higher this time with a count of 21 which is 20 greater than both Jeep and Dodge vehicles which both have a count of 1 each. This is pretty evident that there is a correlation as either Hondas or Toyotas, which are also pretty close in count in each graph, are the highest in each injury severity. 

Most Important Insight - The most important insight that we’ve gained is that on average, the overall number of car incidents that are occuring in the state of Maryland is decreasing regardless of vehicle make which is a positive thing. However, we did observe that the COVID-19 pandemic may have played a slight role in this decrease as during the quarantine period, people weren’t allowed to be out and about which could be a factor as to why the number of car crashes decreased the most during those years and continued to stay low. If this continues, the state of Maryland will become more and more safe to drive in than compared to its past years.

Broader Implications - The continuous decrease of car crashes in the state of Maryland positively impacts public safety as this could suggest that the citizens of Maryland make an active effort in road safety and could impact things such as law enforcement and could inform policy decisions. The role of the COVID-19 pandemic could have influenced safer driving behaviors as well, potentially influencing drivers around them to do the same. Overall, the decrease in car crashes will make Maryland safer for current and new residents.


