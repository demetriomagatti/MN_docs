library(doBy)

mt_full <- mtcars
mt_full_head <- head(mt_full)
mt_full_head$motif <- c('brum','brum','None','vrooom','None','vrooom')

mt_full_head <- orderBy(~vs+am+gear, mt_full_head)

mt_full_head_none <- mt_full_head[mt_full_head$motif %in% 'None',]
