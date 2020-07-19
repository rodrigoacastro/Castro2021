# tracking sources of each segment in work corpus

# sampling biology segments

# preparations

getwd()

dir()

rm(list=ls())

# loading libraries

require(pacman)
p_load(openxlsx)

# loading files

# complete file
wb <- loadWorkbook("SIM-Pt_web_balancingV3.xlsx")

# data

data <- read.xlsx(wb, sheet = "work_corpus", skipEmptyRows = FALSE, colNames = TRUE)
data[,c("SEGMENT.NUMBER")] = as.numeric(data[,c("SEGMENT.NUMBER")])
data[,c("LevelA")] = as.factor(data[,c("LevelA")])
data[,c("LevelB")] = as.factor(data[,c("LevelB")])
data[,c("Topic")] = as.factor(data[,c("Topic")])

str(data)

colnames(data)

# sources


sources <- read.xlsx(wb, sheet = "sources", skipEmptyRows = FALSE, colNames = TRUE)
colnames(sources) = c("source_id","URL")
sources$URL = factor(sources$URL)
str(sources)

# tracking sources

# shortening data to work with

data_short = data[,c("SEGMENT.NUMBER","SOURCE.A","SOURCE.B")]
str(data_short)

data_short$sourceAid = as.numeric(NA)
data_short$sourceBid = as.numeric(NA)

str(data_short)


# loop to match ids

############## # fill sourceAid
for (index1 in seq_along(1:nrow(data_short))) { # loop through data 1-150
  for (index2 in seq_along(1:nrow(sources))) { # loop through sources 1-185
      if (data_short$SOURCE.A[index1] %in% sources$URL) { # if match found, fill the id from source
        data_short$sourceAid[index1] = sources$source_id [sources$URL %in% data_short$SOURCE.A[index1]] 
      }  else {
        data_short$sourceAid[index1] = 00
      }
    
  }
}  

str(data_short$sourceAid)
#############

############## # fill sourceBid
for (index1 in seq_along(1:nrow(data_short))) { # loop through data 1-150
  for (index2 in seq_along(1:nrow(sources))) { # loop through sources 1-185
    if (data_short$SOURCE.B[index1] %in% sources$URL) { # if match found, fill the id from source
      data_short$sourceBid[index1] = sources$source_id [sources$URL %in% data_short$SOURCE.B[index1]] 
    }  else {
      data_short$sourceBid[index1] = 00
    }
    
  }
}  

str(data_short$sourceBid)


################################


# organize data to export

str(data_short)

str(data_short$sourceAid)
str(data_short$sourceBid)

str(data)

data_plus_sources = data.frame(data,sourceAid=data_short$sourceAid, sourceBid=data_short$sourceBid)
str (data_plus_sources)

# export data

write.xlsx(data_plus_sources,"data_plus_sources.xlsx")

####################################################################
