# Delhi_Air_Quality_Analysis
 Analyzing Delhi's air pollution trends (2020–2023) with data visualization and statistical insights. 🌍📊


## Data Overview
This dataset contains air quality data from Delhi, India, covering pollution levels for key pollutants, including particulate matter (PM2.5 and PM10), nitrogen dioxide (NO2), sulfur dioxide (SO2), carbon dioxide (CO2), ozone (O3), and other atmospheric contaminants. The data was collected from multiple monitoring stations across various locations in Delhi over the period from **November 25, 2020, and January 24, 2023**.

## Project Description
This project analyzes air pollution trends in Delhi using **R**. The focus is on **visualizing pollution trends, identifying seasonal variations, and exploring pollution spikes**. A **heatmap of monthly PM2.5 levels** is generated, and key pollutant patterns are examined.

## Repository Contents

- **📜 [R Script](http://rpubs.com/Djacobs/1290732)** - The codes that i used for data cleaning, visualization, and analysis. 
- **📑 [R Markdown](http://rpubs.com/Djacobs/1290697)** - A structured report documenting the analysis.
- **📊 [Dataset](Delhi_aqi.xlsx)** - The raw air quality data used in this project.

## Key Insights

- **Pollution Peaks in Winter** - PM2.5 levels peak during **November–January**, driven by **stubble burning, firecrackers, and winter smog**.
- **Seasonal Variations** - The **LOESS trend line** shows a recurring **U-shaped pattern**, with lower pollution levels during mid-year (**monsoon/summer**).
- **CO Has Extreme Outliers** - Carbon monoxide shows **unusually high values**, likely due to **vehicular emissions and industrial sources**.
- **Heatmap Shows Clear Trends** - High pollution months are visually evident in **red/orange**, confirming seasonal fluctuations.

## Technologies Used

- **R** (`tidyverse`, `ggplot2`, `lubridate`, `dplyr`)
- **R Markdown** for documentation
