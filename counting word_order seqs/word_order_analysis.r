# verifying word order patterns

# preliminary

rm(list=ls())

getwd()

# saves directory
current_dir = getwd()
results_dir = file.path(current_dir,"Results")

# creates folder if it doesn't exist
if (!dir.exists("Results")) {dir.create("Results")}

list.files()

# loading libraries

library(pacman)
p_load(tidyverse)
p_load(readr)
p_load(stringr)

# Read csv

data = read.csv2("exported_FULL_participant_roles.csv",stringsAsFactors=FALSE) %>% as_tibble
data

str(data)

colnames(data)

lapply(data,class) %>% unlist

#Encoding(data) = "latin1"
#View(data)

data$sequence = as.character(NA)

# process data


View (data)


# hot columns to verify presence of items in other columns

data$Agent_presence = ifelse(data$Agent != "", 1, 0)
data$Process_presence = ifelse(data$Process != "", 1, 0)
data$Medium_presence = ifelse(data$Medium != "", 1, 0)
data$Range_presence = ifelse(data$Range != "", 1, 0)
data$Beneficiary_presence = ifelse(data$Beneficiary != "", 1, 0)


# subsets related to categories

category_presence = data[,c("Agent_presence", "Process_presence", "Medium_presence",
                            "Range_presence", "Beneficiary_presence")]
category_presence

# boolean dataframe - TRUE (1) or FALSE (0)
category_presence_bool <- category_presence == 1
category_presence_bool

#part_categories = data[,c("Agent", "Process", "Medium", "Range", "Beneficiary")]
#part_categories

# list of categories to fill sequence
category_list = c("Agent", "Process", "Medium", "Range", "Beneficiary")

data

#############################################################
# loop to fill sequence

# to debug
#row = 1
#column = 5



# for each line of data
for ( row in seq_along(1:nrow(data))) {
  
  # initiates temporary vector
  temp_string = rep(NA,5)
  
  # for each hot column
  for( column in seq_along(1:ncol(category_presence)) ) {
    
    # checks if value exists and assigns category
    if (category_presence[row,column] == 1) {
      temp_string[column] = category_list[column]
    }
    
  }
  
  # removes NAs from temporary vector and produces sequence
  temp_string = temp_string [!is.na(unlist(temp_string))] %>% paste0(collapse="_")
  

  # fills sequence column
  data [row, "sequence"] = temp_string
  
  
  # delete temp variable in the end
  if (row == nrow(data)) {
    
    # deletes temporary vector
    rm(temp_string)
    
  }
  
  
  
}




#############################################################

# split set

setA = subset(data, Text..Segment_set == "SetA")
setB = subset(data, Text..Segment_set == "SetB")


 # empty value will vanish after finishing classification
 
 sequence_counts = data$sequence %>% table %>% sort (decreasing = TRUE) %>% 
						as.data.frame
 sequence_counts


# Absolute frequency

# Set A

sequence_counts_setA = setA$sequence %>% table %>% sort (decreasing = TRUE) %>% 
						as.data.frame

sequence_counts_setA

# Set B

sequence_counts_setB = setB$sequence %>% table %>% sort (decreasing = TRUE) %>% 
						as.data.frame
 
sequence_counts_setB


# Relative frequency

# Set A

sequence_prop_setA = setA$sequence %>% table  %>% prop.table %>% 
			 sort (decreasing = TRUE) %>% as.data.frame 
						
sequence_prop_setA$Freq = round(100 * sequence_prop_setA$Freq,2)

sequence_prop_setA

# Set B

sequence_prop_setB = setB$sequence %>% table %>% prop.table %>% sort (decreasing = TRUE) %>% 
						as.data.frame
 
sequence_prop_setB$Freq = round(100 * sequence_prop_setB$Freq,2)

sequence_prop_setB

# summarizing

sequence_rates_setA = data.frame (sequence_counts_setA, Prop = sequence_prop_setA$Freq)
sequence_rates_setB = data.frame (sequence_counts_setB, Prop = sequence_prop_setB$Freq)

# fix colnames
colnames(sequence_rates_setA)[1] = "sequence"
colnames(sequence_rates_setB)[1] = "sequence"

# store results in a folder

# goes to result dir
setwd(results_dir)

 ##### export results
 
 write_csv2(data,"updated_data_with_sequence.csv")
 write_csv2(sequence_counts,"sequence_counts.csv")

# counts and proportions of sequences
 write_csv2(sequence_rates_setA,"sequence_rates_setA.csv")
 write_csv2(sequence_rates_setB,"sequence_rates_setB.csv")

 # return to current dir
setwd(current_dir)
 
 ###################################################################