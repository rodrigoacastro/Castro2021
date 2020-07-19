# sampling biology segments

# preparations

getwd()

dir()

rm(list=ls())

# loading libraries

require(pacman)
p_load(openxlsx)
p_load(zip)

# loading file
wb <- loadWorkbook("SIM-Pt_web_balancingV4.xlsx")

data <- read.xlsx(wb, sheet = "sampling_corpus", skipEmptyRows = FALSE, colNames = TRUE)
data[,c("SEGMENT.NUMBER")] = as.numeric(data[,c("SEGMENT.NUMBER")])
data[,c("LevelA")] = as.factor(data[,c("LevelA")])
data[,c("LevelB")] = as.factor(data[,c("LevelB")])
data[,c("Topic")] = as.factor(data[,c("Topic")])

str(data)

# removes unnecessary columns
data = data[,1:8]

str(data)

colnames(data)

# topic count

table(data$Topic)


# filtering

physics = subset(data,Topic=="Physics")
str(physics)

psych = subset(data,Topic=="Psychology")
str(psych)

bio = subset(data,Topic=="Biology")
str(bio)

# sampling biology

to_sample = bio$SEGMENT.NUMBER

sample_size = 50

set.seed(6)
sample = sample (to_sample,sample_size)

sample = sort(sample)
sample

# sampling biology

to_sample2 = psych$SEGMENT.NUMBER

sample_size = 50

set.seed(6)
sample2 = sample (to_sample2,sample_size)

sample2 = sort(sample2)
sample2

# preparing file to export

sampled_bio = bio[bio$SEGMENT.NUMBER %in% sample,]
str(sampled_bio)

sampled_psych = psych[psych$SEGMENT.NUMBER %in% sample2,]
str(sampled_psych)


work_data = rbind(sampled_bio,sampled_psych, physics)
work_data = work_data[order(work_data$SEGMENT.NUMBER),]

str(work_data)

# exporting results

write.xlsx(sampled_bio,"sampled_bio_segments.xlsx", sheetName = "sample")
write.xlsx(sampled_psych,"sampled_psych_segments.xlsx", sheetName = "sample")
write.xlsx(work_data,"work_data.xlsx", sheetName = "data")


########################
