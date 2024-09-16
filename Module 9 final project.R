#installing required libraries
library(ggplot2)
library(tidyverse)

#loading the data
url <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/nhanes.csv"
nhanes_data <- read.csv(url, header = TRUE, sep = ",")

#show first few rows
head(nhanes_data)
names(nhanes_data)

#Checking the NA values in the dataset
sum(is.na(nhanes_data))

#checking the NA values in each columns
na_count <- colSums(is.na(nhanes_data))

#Visualising the count of NA values per column
barplot(na_count, 
        main = "Count of NA Values in Each Column",
        #xlab = "Columns",
        ylab = "NA Count",
        ylim = c(0, max(na_count) * 1.1),
        names.arg = names(na_count),
        las = 2,
        col = "blue")

# deleting all NA
#nhanes_cleaned <- na.omit(nhanes_data)

#Replacing NA with 0
nhanes_replaced <- nhanes_data
nhanes_replaced[is.na(nhanes_replaced)] <- 0

# verifying the NA counts After being replaced
sum(is.na(nhanes_replaced))

#Adding Weight in pounds (Weight * 2.2) as a new variable
nhanes_replaced$Weight_pounds <- nhanes_replaced$Weight * 2.2

# Plotting histograms for4 different variables in a 2 * 2 grid
par(mfrow=c(2,2))

hist(nhanes_replaced$BMI, main="BMI Distribution", xlab="BMI")
hist(nhanes_replaced$Weight, main="Weight Distribution", xlab="Weight")
hist(nhanes_replaced$Weight_pounds, main="Weight (in Pounds) Distribution", 
     xlab="Weight in Pounds")
hist(nhanes_replaced$Age, main="Age Distribution", xlab="Age")

# summarising the data to get the mean 60-second pulse rate for all participants
summary(nhanes_replaced$Pulse)
#mean(nhanes_replaced$Pulse == 60)


# the range of values for diastolic blood pressure in all participants
min(nhanes_replaced$BPDia)
max(nhanes_replaced$BPDia)

# checking the variance and standard deviation of the income column
var(nhanes_replaced$Income)
sd(nhanes_replaced$Income)

# Scatter plot with points colored by gender
ggplot(nhanes_replaced, aes(x = Weight, y = Height, color = Gender)) +
  geom_point(size = 3) +
  labs(title = "Relationship between Weight and Height",
       x = "Weight", y = "Height",
       color = "Gender") +
  theme_minimal()

# Scatter plot with points colored by diabetes
ggplot(nhanes_replaced, aes(x = Weight, y = Height, color = Diabetes)) +
  geom_point(size = 3) +
  labs(title = "Relationship between Weight and Height by diabates status",
       x = "Weight", y = "Height",
       color = "Diabetes") +
  theme_minimal()

# Scatter plot with points colored by smoking status
ggplot(nhanes_replaced, aes(x = Weight, y = Height, color = SmokingStatus)) +
  geom_point(size = 3) +
  labs(title = "Relationship between Weight and Height by smoking status",
       x = "Weight", y = "Height",
       color = "Smoking status") +
  theme_minimal()

#Independent samples t-test for age and gender
t.test(Age ~ Gender, data = nhanes_data)

#Independent samples t-test for BMI,166 and Diabetes,64
t.test(BMI ~ Diabetes, data = nhanes_data)

#Independent samples t-test for Alcohol Year,2016 and Relationship Status,1415
t.test(AlcoholYear ~ RelationshipStatus, data = nhanes_data)