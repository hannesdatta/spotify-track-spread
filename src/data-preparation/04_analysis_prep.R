library("data.table")
library("dplyr")
library("tidyr")

# args = commandArgs(trailingOnly=TRUE)

# samplesize = as.numeric(args[1]) #1000 #nrow(playlist_match)

samplesize = 1000
print(samplesize)

#quit()
#Load csv

df <- fread("gen/data-preparation/input/data_influence.csv", header = TRUE,
            colClasses=c("k"="character", "j"="character",
                         "N_jk"="integer", "N_j"="integer", "N_k"="integer",
                         "P_jk"="numeric", "R_jk"="numeric", "F_jk"="numeric"))

playlist_match = data.table(playlist_id=unique(c(unique(df$k), unique(df$j))))
playlist_match[, pl_id_numeric:=.I]
setkey(df,k)
setkey(playlist_match, playlist_id)
df[playlist_match, k_num:=i.pl_id_numeric]
setkey(df,j)
df[playlist_match, j_num:=i.pl_id_numeric]

fwrite(playlist_match, paste0('gen/data-preparation/temp/playlist_match_',samplesize, ".csv"), row.names=F)

# Create sample of df and add all playlist combinations ------------------------

set.seed(1984)
pl_sample <- sample(playlist_match$pl_id_numeric, samplesize)

# Sample of df
df2 <- df[df$k_num %in% pl_sample & df$j_num %in% pl_sample, ]
df2[, k:=NULL]
df2[, j:=NULL]

pl_sample_combinations=rbindlist(sapply(pl_sample, function(x) return(data.frame(x, pl_sample)), simplify=F))

colnames(pl_sample_combinations) <- c("j_num", "k_num")

df3=merge(pl_sample_combinations, df2, by=c('j_num','k_num'),all.x=T)

#Save as csv

fwrite(df3, paste0("gen/data-preparation/temp/pl_all_combinations_", samplesize, ".csv"), row.names=FALSE)
