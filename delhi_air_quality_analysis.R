
# ---- 1. Load Required Libraries ----
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)

# ---- 2. Load and Inspect Data ----
data_aqi <- read_excel(file.choose())

str(data_aqi)
head(data_aqi)

# ---- 3. Convert Date Column ----
data_aqi <- data_aqi %>%
  mutate(date = as.Date(date, format = "%d-%m-%y"))

# ---- 4. Check for Missing Values ----
colSums(is.na(data_aqi))

# ---- 5. Detect Outliers ----
data_aqi %>%
  summarise(across(where(is.numeric), ~ sum(abs(scale(.)) > 3, na.rm = TRUE)))

# Identify specific outlier cases
data_aqi %>%
  filter(abs(scale(pm2_5)) > 3 | abs(scale(pm10)) > 3 | abs(scale(o3)) > 3) %>%
  arrange(desc(pm2_5))

# ---- 6. Boxplot for Pollutant Distribution ----
data_aqi %>%
  pivot_longer(cols = -date, names_to = "pollutant", values_to = "value") %>%
  ggplot(aes(x = pollutant, y = value)) +
  geom_boxplot(outlier.color = "red") +
  theme_minimal() +
  labs(title = "Boxplot of Pollutants with Outliers Highlighted")

# ---- 7. Log-Scaled Boxplot for Better Visualization ----
data_aqi_long <- data_aqi %>%
  pivot_longer(cols = -date, names_to = "Pollutant", values_to = "Value")

ggplot(data_aqi_long, aes(x = Pollutant, y = Value)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2) +
  scale_y_log10() +  
  theme_minimal() +
  labs(title = "Boxplot of Pollutants (Log-Scaled)", y = "Log-Scaled Value", x = "Pollutant") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ---- 8. PM2.5 Trend Over Time ----
data_aqi %>%
  ggplot(aes(x = date, y = pm2_5)) +
  geom_line(color = "red") +
  geom_smooth(method = "loess", color = "blue") +
  geom_vline(xintercept = as.Date(c("2021-11-01", "2022-01-01", "2022-11-01", "2023-01-01")), 
             linetype = "dashed", color = "black") +
  labs(title = "Delhi PM2.5 Trend Over Time with Key Pollution Peaks", 
       x = "Date", y = "PM2.5 Levels") +
  theme_minimal()

# ---- 9. Monthly PM2.5 Levels as Heatmap ----
data_aqi %>%
  mutate(month = lubridate::floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(pm2_5_avg = mean(pm2_5, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = pm2_5_avg, fill = pm2_5_avg)) +
  geom_tile(width = 20, height = 6) +
  scale_fill_gradient(low = "green", high = "red") +
  labs(title = "Monthly PM2.5 Levels in Delhi", x = "Month", y = "Average PM2.5") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# ---- 10. Top 10 PM2.5 Pollution Days ----
df_top10 <- data_aqi %>%
  group_by(date) %>%
  summarise(pm2_5 = max(pm2_5)) %>%
  arrange(desc(pm2_5)) %>%
  head(10)

ggplot(df_top10, aes(x = reorder(date, pm2_5), y = pm2_5, fill = pm2_5)) +
  geom_col(color = "black") +  
  scale_fill_gradient(low = "yellow", high = "red") + 
  labs(title = "Top 10 PM2.5 Pollution Days in Delhi", 
       x = "Date", y = "PM2.5 Level") + 
  geom_text(aes(label = round(pm2_5, 2)), vjust = -0.5, size = 5, fontface = "bold") +  
  theme_minimal() +  
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    legend.position = ("right")
  )
