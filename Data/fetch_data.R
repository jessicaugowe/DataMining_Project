# This script fetches the latest air quality data for Lahore from the AQICN API.

# Load necessary libraries----------------------------------------------------
library(httr)
library(jsonlite)

# Function to fetch latest air quality data from AQICN API for Lahore---------
fetch_air_quality_data <- function(city = "Lahore") {
  # Define the base URL for the API
  base_url <- "http://api.waqi.info/feed/"
  
  # Set up the parameters for the API request, including the API key
  params <- list(
    token = Sys.getenv("AQI_API_KEY"),  # API key stored as an environment variable
    city = city
  )
  # Make the GET request to the API --------------------------------------------- 
  response <- GET(url = paste0(base_url, city), query = params)
  response_content <- content(response, "text")
  
  # Debugging: Print status code and raw response content------------------------
  print(paste("HTTP Status Code:", status_code(response)))  
  print(response_content)  
  
  # Parse JSON response only if the HTTP status is OK (200)----------------------
  if (status_code(response) == 200) {
    data <- fromJSON(response_content)
    iaqi <- data$data$iaqi  # Simplified path to the air quality index data
    
    # Prepare a simple list to store the results with NA as default for missing data
    results <- list(
      pm25 = if(!is.null(iaqi$pm25)) iaqi$pm25$v else NA
    )
    
    return(results)
  } else {
    # Handle error: Print a warning message and return NULL
    warning("Failed to fetch data: HTTP Status Code - ", status_code(response))
    return(NULL)
  }
}

# Fetch air quality data for Lahore and print results---------------------------
air_quality_data <- fetch_air_quality_data()
print(air_quality_data)

