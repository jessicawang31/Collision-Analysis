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


server <- function(input, output) {
  
  # Summary Table Code
  
  max_route_crash <- data %>% 
    group_by(Road.Name, Vehicle.Continuing.Dir) %>%
    summarise(report_num = n()) %>%
    arrange(desc(report_num)) %>%
    head(1)
  
  max_weather_crash <- data %>% 
    group_by(Weather, Surface.Condition) %>%
    summarise(report_num = n()) %>%
    arrange(desc(report_num)) %>%
    head(1)
  
  max_model_crash <- data %>% 
    filter(Injury.Severity == "FATAL INJURY") %>%
    group_by(Vehicle.Model, Vehicle.Make) %>%
    summarise(report_num = n()) %>%
    arrange(desc(report_num)) %>%
    head(1)
  
  max_collision_crash <- data %>% 
    filter(Light == "DAYLIGHT") %>%
    group_by(Collision.Type) %>%
    summarise(report_num = n()) %>%
    arrange(desc(report_num)) %>%
    head(1)
  
  max_dmg_crash <- data %>% 
    filter(Vehicle.Damage.Extent == "DESTROYED") %>%
    group_by(Vehicle.Body.Type) %>%
    summarise(report_num = n()) %>%
    arrange(desc(report_num)) %>%
    head(1)
  
  # Summary Table code
  summary_table_data <- data.frame(
    Question = c("Road Route", "Weather and Road Surface", "Vehicle Model and Make",
                 "Most Often Collisions during Daylight", "Vehicle Body Type with Most Damage"),
    Most_Common_Characteristics = c(
      paste(max_route_crash$Road.Name, " - ", max_route_crash$Vehicle.Continuing.Dir),
      paste(max_weather_crash$Weather, " - ", max_weather_crash$Surface.Condition),
      paste(max_model_crash$Vehicle.Model, " - ", max_model_crash$Vehicle.Make),
      max_collision_crash$Collision.Type,
      max_dmg_crash$Vehicle.Body.Type
    )
  )

  output$summary_table <- renderTable({
    summary_table_data
  })
  
  # Jessica's graph code
  
  filtered_data <- reactive({
    data %>%
      filter(Year >= input$yearRange[1], Year <= input$yearRange[2])
  })
  
  output$collision_bargraph <- renderPlotly({
    
    filtered_crashes <- filtered_data()
    
    collision_occurance <- table(filtered_crashes$Collision.Type)
    collision_occurance_df <- as.data.frame(collision_occurance)
    colnames(collision_occurance_df) <- c("Collision Type", "Count")
  
    selected_num_top <- input$numTop
  
    if (selected_num_top == "All") {
      sorted_collision_occurance_df <- collision_occurance_df
      plot_title <- "All Collision Types"
    } else {
      # Sorting collision types
      sorted_collision_occurance_df <- collision_occurance_df %>%
        arrange(desc(Count)) %>%
        head(as.numeric(selected_num_top))
      plot_title <- paste("Top", selected_num_top, "Occurrences of Collision Types")
    }
    
    # Creates the bar graph
    collision_graph <- ggplot(sorted_collision_occurance_df, aes(x = reorder(`Collision Type`, Count), y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = plot_title, x = "Collision Type", y = "Count")
    
    ggplotly(collision_graph)
  })
  
  
  # Meha's graph code
    
  # Substance abuse types of interest
  substance_types <- c("All", "ALCOHOL PRESENT", "ALCOHOL CONTRIBUTED",
                       "ILLEGAL DRUG CONTRIBUTED", "ILLEGAL DRUG PRESENT",
                       "COMBINATION CONTRIBUTED", "MEDICATION CONTRIBUTED",
                       "COMBINED SUBSTANCE PRESENT")
  
  output$substance_plot <- renderPlotly({
    
    data$Crash.Date.Time <- as.POSIXct(data$Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")
    
    selected_substance <- input$substance
    
    if (selected_substance == "All") {
      substance_data <- data %>%
        mutate(Year = format(Crash.Date.Time, "%Y")) %>%
        group_by(Year) %>%
        summarise(Count = n()) %>%
        mutate(Percentage = (Count / sum(Count)) * 100)
      
      graph_title <- "Percentage of Collisions for All Substance Types Over Time"
    } else {
      substance_data <- data %>%
        filter(Driver.Substance.Abuse == selected_substance) %>%
        mutate(Year = format(Crash.Date.Time, "%Y")) %>%
        group_by(Year) %>%
        summarise(Count = n()) %>%
        mutate(Percentage = (Count / sum(Count)) * 100)
      
      graph_title <- paste("Percentage of Collisions for", selected_substance, "Over Time")
    }
    
    # Creates the line graph
    substance_graph <- ggplot(substance_data, aes(x = Year, y = Percentage)) +
      geom_point(color = "blue") +
      geom_segment(aes(xend = lead(Year), yend = lead(Percentage)),
                   color = "blue", linewidth = 1) +
      labs(title = graph_title,
           x = "Year",
           y = "Percentage (%)") +
      theme_minimal()
    
    ggplotly(substance_graph)
  })
  
  # selectInput widget that allows user to choose which substance type to display
  output$substance_selector <- renderUI({
    selectInput("substance", "Select Substance Type:", choices = substance_types)
  })

  # Chufeng's graph code 
  
  output$injury_plot <- renderPlotly({
    
    top_makes <- data %>%
      count(Vehicle.Make) %>%
      arrange(desc(n)) %>%
      head(10) %>%
      pull(Vehicle.Make)
    
    filtered_data <- data %>%
      filter(Vehicle.Make %in% top_makes)
    
    selected_severity <- input$severity_choice

    summary_data <- filtered_data %>%
      group_by(Vehicle.Make, Injury.Severity) %>%
      summarise(Count = n()) %>%
      ungroup() %>% 
      filter(Injury.Severity == selected_severity)
    
    summary_data$Injury.Severity <- as.factor(summary_data$Injury.Severity)
    
    vehicle_injury_scatterplot <- ggplot(summary_data, aes(x = Vehicle.Make, y = Count, color = Injury.Severity)) +
      geom_point() +
      labs(title = "Relationship between Vehicle Make and Injury Severity",
           x = "Top 10 Vehicle Make",
           y = "Count") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(vehicle_injury_scatterplot)
  })
  
  
  # selectInput widget for choosing Injury Severity
  output$severity_input <- renderUI({
    severity_choices <- unique(data$Injury.Severity)
    selectInput("severity_choice", "Select Injury Severity", severity_choices)
  })
  
}
