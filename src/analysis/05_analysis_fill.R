library(data.table)

#args = commandArgs(trailingOnly=TRUE)

# samplesize = as.numeric(args[1]) #1000 #nrow(playlist_match)
samplesize = 1000

df <- fread(paste0("gen/data-preparation/temp/pl_all_combinations_", samplesize, ".csv"), header = TRUE)
data <- fread("gen/data-preparation/input/data.csv", header = TRUE)


# Add F(j,k) = 0 ---------------------------------------------------------------

vars=setdiff(colnames(df), c('j_num','k_num'))
for (var in vars) df[is.na(get(var)), (var):=0]

characteristics = c('owner', 'pop_above_median')

playlists = unique(data[, c('pl_id',characteristics),with=F],by=c('pl_id'))

playlist_match <- fread(paste0('gen/data-preparation/temp/playlist_match_', samplesize, ".csv"))
setkey(playlist_match,playlist_id)
setkey(playlists, pl_id)

playlist_match[playlists, ':=' (owner=i.owner, pop_above_median=i.pop_above_median)]

# merge to all combinations of playlists
setkey(playlist_match, pl_id_numeric)
setkey(df, j_num)

df[playlist_match, ':=' (j_owner=i.owner, j_pop_above_median=i.pop_above_median)]


setkey(df, k_num)

df[playlist_match, ':=' (k_owner=i.owner, k_pop_above_median=i.pop_above_median)]

num_playlists = length(unique(c(unique(df$j_num), unique(df$k_num))))

fwrite(df, paste0('gen/analysis/temp/analysis_input_', samplesize, '.csv'), row.names=FALSE)

