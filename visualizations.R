# Load required libraries
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

if (!requireNamespace("GGally", quietly = TRUE)) {
  install.packages("GGally")
}

if (!requireNamespace("wordcloud", quietly = TRUE)) {
  install.packages("wordcloud")
}

# Load the libraries
library(ggplot2)
library(GGally)
library(wordcloud)

# Load the dataset
data <- read.csv("C:/Users/heman/Projects/youtube_api/combined_channel.csv")


# 1. Boxplot for View Counts by Day of the Week
ggplot(data, aes(x = pushblishDayName, y = viewCount)) +
  geom_boxplot() +
  labs(title = "Boxplot of View Counts by Day of the Week")

# 2. Time Series Plot for View Counts Over Time
ggplot(data, aes(x = as.Date(publishedAt), y = viewCount)) +
  geom_line() +
  labs(title = "Time Series of View Counts Over Time", x = "Published Date")

# 3. Scatter Plot Matrix for Multiple Metrics
ggpairs(data[, c("viewCount", "likeCount", "commentCount", "durationSecs")])

# 4. Bar Chart for Video Definition
ggplot(data, aes(x = definition, fill = definition)) +
  geom_bar() +
  labs(title = "Distribution of Video Definitions")

# 5. Faceted Scatter Plot for Like vs. View Counts by Channel
ggplot(data, aes(x = viewCount, y = likeCount)) +
  geom_point() +
  facet_wrap(~ channelTitle) +
  labs(title = "Scatter Plot of Like vs. View Counts by Channel")

# 6. Word Cloud for Tags
wordcloud(words = data$tags, min.freq = 10, scale=c(3,0.5))

# 7. Bar Chart for Tags Count
ggplot(data, aes(x = tagsCount)) +
  geom_bar() +
  labs(title = "Distribution of Tags Count")

file.exists("combined_channel.csv")

  # Convert 'publishedAt' column to a Date type
  data$publishedAt <- as.Date(data$publishedAt)
  
  # Aesthetic improvements to the line chart
  ggplot(data, aes(x = publishedAt, y = viewCount, color = channelTitle)) +
    geom_line(size = 1.5) +  # Adjust the size parameter for thickness
    labs(title = "View Counts Over Time by Channel",
         x = "Published Date",
         y = "View Count",
         color = "Channel") +
    scale_y_continuous(labels = scales::comma) +  # Format y-axis without scientific notation
    theme_minimal() +  # Use a minimal theme
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels
    theme(legend.position="top")  # Move legend to the top