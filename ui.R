library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)
library(rsconnect)
library(shinythemes)

data <- read.csv("maryland_crash_report.csv")

data <- data %>%
  mutate(Year = year(as.POSIXct(Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")))

ui <- fluidPage(
  
  # CSS Style 1
  theme = shinytheme("cosmo"),
  
  h1("Analysis of Vehicle Collisions in Maryland"),
  
  navbarPage(,,,l
    title = "INFO 201 Final Project",
    id = "navtabs",
    
    # Introduction tab
    tabPanel("Introduction",
             h1("Project Overview"),
             h3("Team Members: Jessica Wang, Meha Singal, ChuFeng Wang"),
             p("Our project centers on investigating the primary factors influencing automobile accidents in Maryland using a comprehensive dataset from the Maryland State Police's Automated Crash Reporting System (ACRS). Our objective is to identify patterns, correlations, and trends that can guide road safety policies and interventions."),
             p("This data set includes characteristics of accidents reported by callers/police such as date, weather, surface condition, (driver) substance abuse, injury severity, distraction, speed limit, and vehicle model and make; all of which will help us formulate important research questions."),
             p("These research questions include:"),
             strong("- What factors contribute most to automobile accidents in Maryland, and how do they vary across counties and local roads?"),
             p(""),
             strong("- What are the most common types of vehicle collisions among this data?"),
             p(""),
             strong("- Are there correlations between vehicle make/model and accident severity, revealing potential vehicle safety concerns?"),
             p(""),
             strong("- How has substance abuse impacted the number of vehicle collisions, especially in relation to the effects of the COVID-19 pandemic?"),
             p(""),
             p("This dataset was sourced from the Maryland State Police's ACRS and is publicly available for analysis. You can access the dataset at the following link:"),
             a(href = "https://catalog.data.gov/dataset/crash-reporting-drivers-data", "Maryland ACRS Dataset"),
             p(""),
             p("The data includes 162,992 observations with 43 features, encompassing various aspects of accidents in Maryland."),
             p("Some ethical considerations we had to keep in mind while working on this analysis include data accuracy, fairness, and privacy, as the data comes from reporting parties and is preliminary."),
             p("Some limitations of this dataset mostly involve the dataset's regional focus, lack of contextual information prior to incidents, and varying severity levels. Possible underreporting, data quality issues, and human errors may also affect our conclusions."),
             p("Through this project, we aim to provide insights that can influence road safety measures and contribute to accident prevention in Maryland."),
             
             mainPanel(
               img("",
                   src = "https://www.tripsavvy.com/thmb/k1MnbagvDg_9U-Thn47jRggkQm4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/maryland-highway-map--vector--158186927-cbc36a3b1fd542e9b91da40d573f9232.jpg", 
                   height = "350px", width = "600px", # CSS Style 2
                   style= "position:absolute; left:0px; margin-top: 20px;"),
             )
    ),
    
    # Summary tab
    tabPanel("Summary Information",
             h1("Most Common Characteristics Relating to Vehicle Collisions"),
             h2("Summary Table"),
             p("The 5 values that we calculated were aimed towards the conditions 
               and factors that may attribute to car collisions the most. 
               The first value was finding which road routes in the Montgomery County 
               had the most collisions and the vehicle direction it was going for the 
               safety of people which was Georgia Ave heading North. The next was
               finding which weather and surface road conditions that go in-hand people
               should avoid taking for the most collisions was clear and dry. Our third find was finding out which car
               models people should avoid with the most reported number of fatal injury
               collisions was Toyota Camrys. Our fourth finding was 
               which collisions are most often during the day when most people drive which was
               same direction rear ends. And lastly, if the circumstances were to
               come to a collusion, the vehicle body we found to receive the most damage
               were passenger cars. In conclusion, the 5 values we found can
               be valuable information for people to become aware of and make safe decisions."),
             tableOutput("summary_table")
    ),
             
    
    # Collision Types tab
    tabPanel("Collision Types",
             h1("Vehicle Collision Types from 2015-2023"),
             
             # Sidebar with sliding range and top N selection widgets
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearRange",
                             "Select Years:",
                             min = min(data$Year),
                             max = max(data$Year),
                             value = c(2015, 2020),
                             step = 1),
                 selectInput("numTop", "Top N Collision Types:", choices = c("All", 5, 10, 15), selected = "All"),
                 p("Adjust the range of years and select the number of top collision types you want to see in the graph. The bar graph displays the number of times each type of collision occurs over time in the state of Maryland. The dataset records this data from 2015 to the present. The most frequent collision type is the same direction rear-end collision, which continues to be the top collision type in Maryland. Moreover, the overall number of collisions per year has been increasing. As citizens of Maryland, it's crucial to drive cautiously to ensure safety and work towards decreasing the number of collisions.")
               ),
               mainPanel(
                 plotlyOutput("collision_bargraph")
               )
             )
    ),
    
    # Substance Abuse tab
    tabPanel("Substance Abuse",
             h1("Percentage of Collisions for Specific Substance Abuse Types Over Time"),
             
              #Sidebar with a select input widget
             sidebarLayout(
              sidebarPanel(
                 uiOutput("substance_selector"),
                 p("Change the dynamic line graph above to understand the changing trends in collision incidents attributed to different substance abuse types over time. Each substance type is represented by a colored line, with dots representing average percentage of crashes for that year. The x-axis indicates years, while the y-axis displays the percentage of collisions. To focus on a specific substance type, use the dropdown widget below the graph. Select 'All' to view an overall percentage trend involving all substance types. The graph updates instantly based on your selection, offering valuable insights into collision patterns in Maryland."),
               ),
               # Main panel with the interactive plot
               mainPanel(
                 plotlyOutput("substance_plot"),
               )
             )
    ),
    
    # Vehicle Make and Model tab
    tabPanel("Vehicle Make and Model",
             sidebarLayout(
               sidebarPanel(
                 uiOutput("severity_input"),
                 p("This scatter plot illustrates the relationship between vehicle make and the severity of injuries in Maryland. Use the dropdown to select the severity of injury, and the graph will display the data accordingly, showing the frequency of collisions for each model with the selected severity. Regardless of severity, the graph reveals that the most collisions involve Honda and Toyota vehicles. A pattern is evident: the most severe injuries are associated with Honda vehicles, while lower levels of severity are associated with Toyota vehicles. It is important for Maryland residents to exercise caution when operating Honda or Toyota vehicles in order to mitigate the risk of sustaining injuries in car crashes."),
               ),
               mainPanel(
                 plotlyOutput("injury_plot")
               )
             )
    ),
    
    # Conclusion
    tabPanel("Conclusion",
             h1("Project Conclusions"),
             
             h3("Takeaway #1"),
             p("Our first takeaway is from the Collision Types visualization. The most common collision type observed is the 'Same Direction Rear End'. Over the years 2015 to 2023, this collision type remained the most frequent. Digging deeper, we see an overall decrease in the number of these collisions. From 2015-2016, there were 14,869 same direction rear end collisions recorded, and from 2022-2023, a total of 7,824, revealing a decrease of approximately 47.36%. The most significant decrease occurred after the 2019-2020 period, falling from 11,092 to 8,761 in 2020-2021, a 21.05% decrease. This was likely influenced by the COVID-19 pandemic and can be applied to other collision types as well."),
             
             h3("Takeaway #2"),
             p("There were a lot of interesting takeaways from the graphs showcasing the percentage of vehicle collisions in relation to different types of substance abuse the driver was involved with. The “All” graph calculating the percentage of the proportion of vehicle crashes displays a very good overview of the trend that was seen across most types, with the biggest dip occurring in 2020 due to the COVID-19 pandemic, but maintaining an overall downward trend in % of crashes involving substance abuse. The substance abuse types with, on average, the highest percentage of collisions across all of the years were “Illegal Drugs Contributed” in 2021, with 20% of crashes confirmed to involve illegal drugs, and “Medication Contributed” with 19.7% in 2017. The substance abuse types that saw the biggest decreases from 2015 to 2022 (not counting 2023 since it hasn’t been a full year) were “Combination Contributed” and “Illegal Drug Contributed”, which both saw an 8-9% drop in percentage of collisions involving that type of abuse. However, both graphs experienced a massive spike  in 2021, then an immediate fall of about 14-17% to their record low numbers in 2022. This could have been due to policy, population, or supply issues, depending on what exact substances were involved. Overall, these graphs should not be considered the end-all-be-all of substance abuse rates in vehicle collisions, but convey consistent enough trends of dropping occurrences after the COVID-19 pandemic to call for further investigation into the impacts of the virus on the driving and substance abuse habits on Americans."),
             
             h3("Takeaway #3"),
             p("To answer our third research question, there are notable correlations between the vehicle make and the severity of the injury. From the Vehicle Make and Model visualization, we observed that the two vehicle makes with the highest number of car incidents/injuries were Honda and Toyota. In the possible injury graph, Toyotas yield a high of 2,873, 811.75% higher than Chevrolet, the lowest make with a count of 315. In the fatal injury graph, Honda is higher with a count of 21, 20 more than Jeep and Dodge vehicles, both at a count of 1. There is a clear correlation where Hondas or Toyotas, being close in count, are highest in each injury severity."),
             
             h3("Most Important Insight"),
             p("The most crucial insight is that, on average, the overall number of car incidents in Maryland is decreasing regardless of vehicle make. This suggests active road safety efforts by Maryland citizens. The COVID-19 pandemic may have contributed to this decrease as quarantine limited travel, resulting in lower crash numbers, especially during those years."),
             
             h3("Broader Implications"),
             p("The continuous decrease in car crashes in Maryland positively impacts public safety. It suggests active efforts in road safety, influencing law enforcement and policy decisions. The role of the COVID-19 pandemic may have encouraged safer driving behaviors, making Maryland safer for residents."),
             
             mainPanel(
               p(""),
               # CSS Style 3
               img(src = "https://www.txdot.gov/safety/traffic-safety-campaigns/be-safe-drive-smart/_jcr_content/root/responsivegrid_1551407878/columncontrol/col2/image.coreimg.png/1659993554246/be-safe-drive-smart.png",
                   height = "350px", width = "600px")
             )
    )
    
)
)
