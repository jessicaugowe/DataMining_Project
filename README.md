# BreatheSafe: Dynamic Air Quality Surveillance with Automated Alerts

## Overview
BreatheSafe is a real-time air quality monitoring system designed to enhance public health awareness in Lahore, Pakistan. The project leverages data from the WAQI API to provide timely health advice via SMS alerts when air quality is poor, focusing primarily on PM2.5 levels. The goal is to improve public health outcomes by enabling inhabitants to take necessary precautions.

## Features
- **Real-Time Data Retrieval**: Fetches air quality data from the WAQI API.

- **Health Alerts**: Sends SMS alerts to users when air quality reaches unsafe levels using the Twilio API.

- **Health Advice**: Provides tailored health advice based on PM2.5 AQI levels.

- **Data Visualization**: Plots air quality trends over a ten-day period.

## Folder Structure
- **Data**: contains fetch_data.R script used to fetch air quality data from WAQI API.

- **Script**: contains process_data.R and send_alert.R scripts used to process data and send SMS alerts when the air quality is bad using Twilio API.

- **Figure**: contains plot_data.R script used to visualize air quality data.

- **Output**: contains report.Rmd and report.html for the project report.
 
## Setup

1. **Clone the repository**

2. **Install R Packages**

       install.packages(c("httr", "jsonlite", "ggplot2", "scales", "twilio"))
 
3. **Set up environment variables**

 Create a .Renviron' file in your project directory with the following content:
 
      AQI_API_KEY = your_aqi_api_key_here
 
      TWILIO_SID = your_twilio_sid_here
 
      TWILIO_TOKEN = your_twilio_auth_token_here
 
      TWILIO_PHONE_NUMBER = your_twilio_phone_number_here
 
3. **Running the Scripts**

 Run the scripts in the following order:
 
    fetch_data.R -> process_data.R -> alert_message.R -> plot_data.R
    
 **Contributing**
 
We welcome contributions! Feel free to submit pull requests or open issues. Additionally, please review the limitations and considerations highlighted in the report.