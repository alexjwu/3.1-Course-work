library(readxl)
titanic3 <- read_excel("titanic3.xls")

library(dplyr)
library(tidyr)

df <- titanic3 %>% mutate(embarked = ifelse(is.na(embarked), "S", embarked))

df <- df %>% mutate(age = ifelse(is.na(age), mean(df$age, na.rm = TRUE), age))

df <- df %>% mutate(boat = ifelse(is.na(boat), "None", boat))

df <- df %>% mutate(has_cabin_number = ifelse(is.na(cabin), 0, 1))

write.table(df, file="titanic_clean.csv",sep=",",row.names=F)
