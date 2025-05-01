# Load required libraries
library(readxl)
library(data.table)
library(dplyr)
library(openxlsx)

# Set working directory
setwd("~/Documents/combing car data")

# Import files
tommy <- read_excel("Car Data Collection .xlsx", skip = 1)  # skipping header row
ahbid <- read_excel("cars_count.xlsx")
tanner <- read_excel("Counting_Cars.xlsx", skip = 1)
nick <- read_excel("counting_cars_final.xlsx", skip = 1)
nisrine <- read_excel("Data_Counting_Cars.xlsx", skip = 1)
nbasil <- read_excel("speed_counting_cars.xlsx")

# Clean Tommy's data
tommy <- tommy %>%
  rename(
    Time = `Unnamed: 1`,
    Speed = `Unnamed: 2`,
    Temperature = `Unnamed: 3`,
    Type = `Unnamed: 6`,
    Name = `Unnamed: 7`
  ) %>%
  select(Time, Speed, Temperature, Type, Name) %>%
  mutate(source = "Tommy")

# Clean Ahbid's data
ahbid <- ahbid %>%
  rename(
    Speed = Final_Speed,
    Type = Body_Style
  ) %>%
  mutate(
    Time = NA,
    Temperature = NA,
    Name = NA,
    source = "Ahbid"
  ) %>%
  select(Time, Speed, Temperature, Type, Name, source)

# Clean Tanner's data
tanner <- tanner %>%
  rename(
    Time = `Unnamed: 1`,
    Speed = `Unnamed: 2`,
    Temperature = `Unnamed: 3`,
    Type = `Unnamed: 6`,
    Name = `Unnamed: 7`
  ) %>%
  select(Time, Speed, Temperature, Type, Name) %>%
  mutate(source = "Tanner")

# Clean Nick's data
nick <- nick %>%
  rename(
    Time = `Unnamed: 1`,
    Speed = `Unnamed: 2`,
    Temperature = `Unnamed: 3`,
    Type = `Unnamed: 4`,
    Name = `Unnamed: 5`
  ) %>%
  select(Time, Speed, Temperature, Type, Name) %>%
  mutate(source = "Nick")

# Clean Nisrine's data
nisrine <- nisrine %>%
  rename(
    Time = `Unnamed: 1`,
    Speed = `Unnamed: 2`,
    Temperature = `Unnamed: 3`,
    Type = `Unnamed: 4`
  ) %>%
  mutate(Name = NA, source = "Nisrine") %>%
  select(Time, Speed, Temperature, Type, Name, source)

# Clean NBasil's data
nbasil <- nbasil %>%
  rename(
    Type = vehicle_type,
    Speed = final_speed,
    Temperature = `weather `,
    Name = recorder
  ) %>%
  mutate(Time = NA, source = "NBasil") %>%
  select(Time, Speed, Temperature, Type, Name, source)

# Combine all cleaned datasets
combined_data <- bind_rows(tommy, ahbid, tanner, nick, nisrine, nbasil)

# Save combined data
write.xlsx(combined_data, "combinedDataOutput.xlsx")

# view preview
head(combined_data)
