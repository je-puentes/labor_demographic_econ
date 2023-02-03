############################################################################
#                       Problem Set Labor and Demographics
#
############################################################################

# Packages
library(tidyverse) # Package for everything
library(haven)     # Package for reading dta files 
library(ggthemes)  # Package for themes
library(lubridate) # Converts to date format
library(KSPM)      # Package to calculate kernel regression



# Importing data ----------------------------------------------------------

# Important note: we are dealing with a database that has already been 
# cleaned. We will convert the file in a Rdata format so that we can 
# load faster the data.

# Only use this option if you dont't have acess to the Rdata format
# data_ps <- read_dta(file = "data_PS1.dta")

# Convert to Rdata the data_ps
# saveRDS(data_ps, file = "data_ps1.rds")

# Load data
data_ps1 <- readRDS(file =  "data_ps1.rds")

# Creates real values of wages
data_ps1 <- data_ps1 %>%
  mutate(real_hhincome = (hhincome*100) / Price_Index)

# Question 1 --------------------------------------------------------------

# For women women aged 15-65

# yearly mean wages
year_mean_wage <- data_ps1 %>%
  filter(age %in% 15:65, sex == 2, incwage >=0 ) %>%
  group_by(year) %>%
  summarise(mean_wage = mean(incwage, na.rm = T)) 

# Plot mean_wage
ggplot(year_mean_wage, aes(x = year
                           , y = mean_wage ))+
  geom_line(color = "#967BB6")+
  geom_point(color = "#7B1FA2")+
  theme_few()+
  labs(title = "Yearly mean wage", 
       subtitle = "Women aged 15-65",
       x = "Year",
       y = "Mean wage")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") +
  scale_y_continuous(n.breaks = 10)
  scale_x_continuous(n.breaks = 2019-2005)

# mean hours worked (unconditional and conditional)
  mean_hour_unconditional <- data_ps1 %>%
    filter(age %in% 15:65, sex == 2, empstat == 1) %>%
    group_by(year) %>%
    summarise(mean_wage = mean(incwage, na.rm = T)) 

#mean employment rates of
  
  
  

# Question 2 --------------------------------------------------------------

# Utility function
# U(c, P; e) = c + x'a*(1-P) + b(1-P)c + e(1-P)
# c: consumption
# Participation index (=1 if works)
# x: vector of covariates
# r threshold value
  
  
# wage equation:
# w(z,eta) = z'y + M(Pr(P =1| y,z,x )) + u
  
  
# Subseting for married women between 25-55
  m_women_25_55 <- data_ps1 %>%
    filter(age %in% 25:55, marst %in% c(1,2))


# Step 1: Non-parametric estimation of Pr(P = 1 | y,z,x) ------------------
# a)  Non-parametrically estimate Pr(P = 1|y, z, x) using a kernel regression 
  # where z includes completed education and age and x includes a constant, 
  # age and current number of children
  
  
 pr_1 <- kspm(response = "empstat", 
       linear = ~ age + nchild,
       kernel = ~Kernel(~ educ + age,
                        kernel.function = "gaussian"), 
       data = m_women_25_55)

