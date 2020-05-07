# sampling biology segments

# preparations

getwd()

dir()

rm(list=ls())

# loading libraries

require(pacman)
p_load(openxlsx)

# loading file
wb <- loadWorkbook("SIM-Pt_web_balancingV3.xlsx")

data <- read.xlsx(wb, sheet = "sampling_corpus", skipEmptyRows = FALSE, colNames = TRUE)
data[,c("SEGMENT.NUMBER")] = as.numeric(data[,c("SEGMENT.NUMBER")])
data[,c("LevelA")] = as.factor(data[,c("LevelA")])
data[,c("LevelB")] = as.factor(data[,c("LevelB")])
data[,c("Topic")] = as.factor(data[,c("Topic")])

str(data)

colnames(data)


# filtering

psych = subset(data,Topic=="Physics")
str(psych)

phys = subset(data,Topic=="Psychology")
str(phys)

bio = subset(data,Topic=="Biology")

str(bio)

# sampling

to_sample = bio$SEGMENT.NUMBER

sample_size = 50

set.seed(6)
sample = sample (to_sample,sample_size)

sample = sort(sample)
sample

# preparing file to export

sampled = bio[bio$SEGMENT.NUMBER %in% sample,]
str(sampled)


work_data = rbind(sampled,psych, phys)
work_data = work_data[order(work_data$SEGMENT.NUMBER),]

str(work_data)

# exporting results

write.xlsx(sampled,"sampled_bio_segments.xlsx", sheetName = "sample")
write.xlsx(work_data,"work_data.xlsx", sheetName = "data")


########################
