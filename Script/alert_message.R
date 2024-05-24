# This script sends SMS alerts using Twilio's API if the air quality in Lahore is bad.

# Load necessary library-------------------------------------------------------
#install.packages("twilio") # Uncomment if you need to install the package
library(httr)  # Ensure the httr package is loaded for making HTTP requests


# Define the function to send SMS using Twilio's API---------------------------
send_sms_alert <- function(to, message) {
  account_sid <- Sys.getenv("TWILIO_SID")
  auth_token <- Sys.getenv("TWILIO_TOKEN")
  twilio_phone <- Sys.getenv("TWILIO_PHONE_NUMBER")  # Your Twilio phone number
  
  url <- paste0("https://api.twilio.com/2010-04-01/Accounts/", account_sid, "/Messages.json")
  
  body <- list(
    To = to,
    From = twilio_phone,
    Body = message
  )
  
  response <- POST(
    url,
    authenticate(account_sid, auth_token),
    body = body,
    encode = "form"
  )
  
  if (status_code(response) == 201) {  # HTTP 201 means Created
    print("Message sent successfully!")
  } else {
    print("Failed to send message.")
    print(content(response, "text"))
  }
}

# Function to perform the entire check and alert process-----------------------
perform_air_quality_check <- function() {
  # Fetch air quality data for Lahore
  aqi_data <- fetch_air_quality_data("Lahore")  
  
  if (!is.null(aqi_data) && !is.null(aqi_data$pm25)) {
    quality_info <- check_quality(aqi_data$pm25)
    
    # Construct the message with AQI level and health implications------------------
    message <- sprintf("Alert: The current PM2.5 AQI is %d which is considered '%s'. %s %s",
                       aqi_data$pm25, quality_info$level, quality_info$health_implications, quality_info$cautionary_statement)
    
    # Send the SMS if the air quality is not "Good"--------------------------------
    if (quality_info$level != "Good") {
      send_sms_alert("123456789", message)  # Replace 123456789 with your registered twilio phone number typed
    }
  } else {
    print("Failed to fetch air quality data or PM2.5 data is missing.")
  }
}

# Execute the air quality check and alert process-------------------------------
perform_air_quality_check()
