# Load ggplot2
# This script generates a line graph of daily PM2.5 Air Quality Index (AQI) levels for Lahore using ggplot2.

# Load necessary libraries----------------------------------------------------
library(ggplot2)
library(scales)  # for the rescale function

# Generate today's date-------------------------------------------------------
today_date <- Sys.Date()

# Sample Data: Generate 10 days of random AQI values between 0 and 300---------
air_quality_data <- data.frame(
  Date = seq(as.Date(today_date), by="day", length.out=10),
  AQI = runif(10, min=0, max=300)  # Random AQI values between 0 and 300
)

# Ensure air_quality_data has no missing dates or fill them if necessary--------
air_quality_data <- na.omit(air_quality_data)  # Remove rows with NA values
if (nrow(air_quality_data) < 10) {
  warning("Data is missing for some dates")
}

# Create line graph of AQI levels----------------------------------------------
ggplot(air_quality_data, aes(x=Date, y=AQI)) +
  geom_line(color="black", linewidth=1) +  # Single color for the line
  geom_point(aes(color=AQI), size=3) +  # Points colored based on AQI values
  scale_color_gradientn(colors=c("green", "yellow", "orange", "red", "purple", "brown"),
                        values=rescale(c(0, 50, 100, 150, 200, 300)),
                        guide=guide_colourbar(title="PM2.5 Air Quality Index Levels", title.position = "top", title.hjust = 0.5)) +
  labs(title="Daily PM2.5 Air Quality Index Levels of Lahore",
       subtitle="Line shows trend, dots indicate AQI level",
       x="Date",
       y="AQI") +
  theme_minimal() +
  theme(plot.title = element_text(size=14, face="bold"),
        plot.subtitle = element_text(size=12),
        legend.position="bottom",
        axis.text = element_text(size=12),
        axis.title = element_text(size=12))
