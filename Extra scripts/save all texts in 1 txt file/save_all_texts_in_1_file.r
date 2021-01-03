library(tidyverse)

# clean memory
rm(list=ls(all=T))

# directory
dir1 = getwd()
dir1 

# files and filenames
filenames = dir(pattern=".txt")
filenames 

text1 = readLines(filenames[[1]],encoding = "UTF-8")
text1

textnames = filenames  %>% gsub(".txt","",.) %>% 
		gsub ("source085_radiacoes-ionizantes","source085",.)
textnames 

#####################
# joining texts

final_file = ""

for (text_no in seq_along(filenames)) {
	if (text_no == 1) {
		final_file = readLines(filenames[[text_no]],
					skipNul=TRUE,encoding = "UTF-8",warn=F)
		# remove empty lines
		final_file = final_file[final_file != ""]
	} else {
		break
	}
}
final_file
#####################



#####

temp_file = ""
#final_file = ""
#text_no = 1
#text_no = 2

for (text_no in seq_along(filenames)) {
	temp_file = readLines(filenames[text_no],
					skipNul=TRUE,encoding = "UTF-8",warn=F)
	# remove empty lines
	temp_file = temp_file[temp_file != ""]

	if (text_no == 1) {
		#final_file = temp_file

		# save text in text file
		sink("all_texts.txt")
		cat(textnames[text_no])
		cat("\n\n")
		cat(temp_file)
		cat("\n\n")
		sink()

		
	} else {
		#break
		#final_file = append(textnames[text_no],final_file)

		# save text in text file
		sink("all_texts.txt",append=TRUE)
		cat(textnames[text_no])
		cat("\n\n")
		cat(temp_file)
		cat("\n\n")
		sink()

	}
}





##
final_file2
?append

file1 = append("test",final_file)
append ("test","\n\n")

?sink
sink("outfile.txt")
cat(textnames[1])
cat("\n\n")
cat(final_file)
cat("\n\n")
sink()
