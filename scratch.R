# Scratch file for working with the files in data. I load (also known as
# "attach") the three libraries that are most useful, I think, for this sort of
# work. One of my roles is to point out which packages are useful. Including the
# package name (or "tidyverse" or "dplyr") when googling will often lead to
# better results than a straight google.

library(tidyverse)
library(stringr)
library(fs)

# 1. Read data/ex_926_I.csv into a tibble and provide a summary.

x_926 <- read_csv("data/ex_926_I.csv")
summary(x_926)

# 2. Create a vector with all the file names in data/.

file_names <- dir_ls("data/")

# Note the class of file_names

class(file_names)

# It is not simply a character vector. It is a class, created by the fs()
# package, which is built on a character vector but includes other stuff, staff
# that will be very handy when we use map_dfr() later.

# 3. Create a vector with just the file names that have an "A" in them.

file_name_A <- str_subset(file_names, pattern = "A")

# Check the class:

class(file_name_A)

# It is simply character. And that is OK! str_* functions are designed to get
# rid of some cruft and just leave the core data. Most of the time, this is what
# you want, but no always. Compare:

file_name_choice <- dir_ls("data/", regexp = "A")

class(file_name_choice)

# It is still class "fs_path"   "character". The same information, but organized
# somewhat differently.

# 4. Read in all the files into one big tibble. Check out ?map_dfr . . .
# Background reading here:
# https://r4ds.had.co.nz/iteration.html#the-map-functions

x <- map_dfr(file_names, read_csv)

# 5. Read in everything and also add a new variable, source, which records the
# file name from which the data came.

x <- map_dfr(file_names, read_csv, .id = "source")

# This works because file_names is fs_path/character, which means it has the "name" attribute. Compare:

names(file_name_A)
names(file_name_choice)

# .id uses the names of the vector. No names (as in file_name_A) mean that it
# just uses an index: 1, 2, 3 and so on.

# 6. Find the 4 files with the largest number of observations.

x %>% 
  group_by(source) %>% 
  count() %>% 
  arrange(desc(n))

# 7. Write a function which takes a character string like "A" and then reads in
# all the files which have "A" in the name.

read_my_character <- function(x){
  
  
  
}


# 8. Create a Shiny App which displays the histogram of b, allowing the user to
# subset the display for specific values of c.

