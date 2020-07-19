#########################################################
# Script to track, count URL bases (no subpages)

# preparations

getwd()

ls()

dir()

rm(list=ls())

require(pacman)
p_load(readr)

# importing data
# web_sources.xlsx

sources = read_csv("web_sources.csv")
str(sources)

# finding regex patterns

# regex

regex ="[a-zA-Z.:/01-9]*(\\-fi)?(\\.com(\\.br)?|\\.net|\\.org|\\.br|\\.de|\\.pt|\\.au)(:8686)?"
string = sources$source

#View(string)

################################################
# function to find regex patterns

find_pattern = function (string, pattern) { 
  regmatches (string, gregexpr(pattern, string))
}
################################################

# running regex search in a loop

websites = rep(NA,182)

for (i in seq_along(string)) {
  websites[i] = find_pattern (string[i],regex)
}

str(websites)

# organizing data

websites = unlist(websites)

counts = table(websites)
counts

# sorted data

sorted_counts = sort(counts,decreasing=TRUE)
sorted_counts

# unique data

unique_result = unique(websites)
unique_result
colnames(unique_result) = NULL



# exporting updated table

#updated_web_sources.txt

write.csv(as.data.frame(unique_result),"uniqueResults.txt",quote = FALSE,
                col.names = FALSE,row.names = FALSE)

write.csv2(sorted_counts,"sortedCounts.txt",quote = FALSE,
          col.names = TRUE,row.names = FALSE)


#########################################################
