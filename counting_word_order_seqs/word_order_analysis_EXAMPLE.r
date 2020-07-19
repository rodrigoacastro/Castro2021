sentence = "He ate many apples"
process = "ate"
agent = "He"
medium = "many apples"

data = data.frame(sentence, process, agent,medium)
data

data$new_sentence = gsub(data$process,"PROCESS",data$sentence)
data$new_sentence = gsub(data$agent,"AGENT",data$new_sentence)
data$new_sentence = gsub(data$medium,"MEDIUM",data$new_sentence)

data

data$sequence = gsub(" ", "_", data$new_sentence)
data$sequence = as.factor(data$sequence)

data

str(data)