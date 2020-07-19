## works for matching ids


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





















#################################
#############

str(data_short)

# data_source = data_short
# data_source_col = "SOURCE.A" #or SOURCE.B
# sourceID = sources$source_id
# sourceURL = sources$URL
# target_column = "sourceAid" or sourceBid
rm(index1,index2)

index1 = 4; index2 = 1



#############
fill_sourceid = function (data_source = data_short, data_source_col, sourceID,sourceURL, target_column) {
  
  for (index1 in seq_along(1:nrow(data_source))) { # loop through data 1-150
    for (index2 in sourceID) { # loop through sources 1-185
      if (data_source[,data_source_col][index1] %in% sourceURL) { # if match found, fill the id from source into column
        data_source[,target_column][index1] = sourceID [sourceURL %in% data_source[,data_source_col][index1]] 
      }  else { # in case of error
        data_source[,target_column][index1] = 0
      } # end of else
      
    } # end of for 2
    return(data_source)
  }# end of for 1  
}
#############
fill_sourceid (data_short,"SOURCE.A", sources$source_id, sources$URL, "sourceAid")
debug(fill_sourceid)