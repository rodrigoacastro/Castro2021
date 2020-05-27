sentence = "He ate many apples"
process = "ate"
agent = "He"
medium = "many apples"

data = data.frame(sentence, process, agent,medium)
data


require(tidyverse)

data$new_sentence = data$sentence %>% 
			gsub(pattern = data$process,replacement = "PROCESS",) %>%
			gsub(pattern = data$agent,replacement = "AGENT",) %>%
			gsub(pattern = data$medium,replacement = "MEDIUM",)



#data$new_sentence = gsub(data$process,"PROCESS",data$sentence)
#data$new_sentence = gsub(data$agent,"AGENT",data$new_sentence)
#data$new_sentence = gsub(data$medium,"MEDIUM",data$new_sentence)

data

data$sequence = gsub(" ", "_", data$new_sentence)
data$sequence = as.factor(data$sequence)

data

str(data)


#####################################




sentence2 = "she got me yesterday"
process2 = "got"
agent2 = "she"
medium2 = "me"

data = data.frame(sentence2, process2, agent2,medium2)
data


require(tidyverse)

data$new_sentence = data$sentence2 %>% 
			gsub(pattern = data$process2,replacement = "PROCESS",) %>%
			gsub(pattern = data$agent2,replacement = "AGENT",) %>%
			gsub(pattern = data$medium2,replacement = "MEDIUM",)

### REGEX TO DISCARD WORDS IN LOWER CASE

data$sequence = regmatches( data$new_sentence, gregexpr(pattern = "[A-Z]+",data$new_sentence)) %>% 
		unlist %>% paste0(collapse="_")




data$sequence = gsub(" ", "_", data$new_sentence) %>% as.factor


data

str(data)