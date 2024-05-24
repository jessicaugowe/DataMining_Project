# This script processes the PM2.5 AQI data to assess air quality and provide relevant health advice.

# Function to assess air quality based on PM2.5 AQI and provide relevant health advice
check_quality <- function(pm25_aqi) {
  if (pm25_aqi <= 50) {
    return(list(
      level = "Good",
      health_implications = "Air quality is considered satisfactory, and air pollution poses little or no risk.",
      cautionary_statement = "None"
    ))
    
  } else if (pm25_aqi <= 100) {
    return(list(
      level = "Moderate",
      health_implications = "Air quality is acceptable; however, there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.",
      cautionary_statement = "Active children, adults and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion."
    ))
    
  } else if (pm25_aqi <= 150) {
    return(list(
      level = "Unhealthy for Sensitive Groups",
      health_implications = "Members of sensitive groups may experience health effects. The general public is not likely to be affected.",
      cautionary_statement = "Children, adults and people with respiratory disease, such as asthma, should avoid prolonged outdoor exertion; everyone else, especially children, should limit prolonged outdoor exertion."
    ))
    
  } else if (pm25_aqi <= 200) {
    return(list(
      level = "Unhealthy",
      health_implications = "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.",
      cautionary_statement = "Children, adults and people with respiratory disease, such as asthma, should avoid prolonged outdoor exertion; everyone else, especially children, should limit prolonged outdoor exertion."
    ))
    
  } else if (pm25_aqi <= 300) {
    return(list(
      level = "Very Unhealthy",
      health_implications = "Health alert: everyone may experience more serious health effects.",
      cautionary_statement = "Everyone should avoid all outdoor exertion."
    ))
    
  } else {
    return(list(
      level = "Hazardous",
      health_implications = "Health warnings of emergency conditions. The entire population is more likely to be affected.",
      cautionary_statement = "Everyone should avoid all outdoor exertion."
    ))
  }
}


#  Usage with fetched PM2.5 AQI data-------------------------------------------
if (!is.null(air_quality_data) && !is.null(air_quality_data$pm25)) {
  # Assess air quality and provide health advice based on the PM2.5 AQI data
  quality_result <- check_quality(air_quality_data$pm25)
  
  # Print the air quality level and relevant health advice
  print(paste("Air quality level:", quality_result$level))
  print(paste("Health implications:", quality_result$health_implications))
  print(paste("Cautionary statement:", quality_result$cautionary_statement))
} else {
  # Handle case where PM2.5 AQI data is not available
  print("No PM2.5 AQI data available to check quality.")
}
