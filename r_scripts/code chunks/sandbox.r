library(data.table)

#' Arguments:
#' @param df_x first dataframe.
#' @param df_y second dataframe.
#' @param by_x first dataframe column to use for the merge operation.
#' @param by_y second dataframe column to use for the merge operation.
#' 
#' Output
#' @return merge of \code{df_x} and \code{df_y}, without duplicate columns.
clean_merge <- function(df_x, df_y, by_x, by_y){
  # is this a comment?
  # and how does it look?
  merged <- merge(df_x,df_y,by.x=by_x,by.y=by_y)
  merged[grepl('..y', names(merged))] <- NULL
  setnames(merged, old = names(merged), new = str_replace(names(merged), ".x", ""))
}

mt_split1 <- mtcars[c('mpg','cyl','disp')]
mt_split2 <- mtcars[c('mpg','cyl','drat')]
mt_split1$car_id = 1:dim(mt_split1)[1]
mt_split2$id_car = 1:dim(mt_split2)[1]

merged <- clean_merge(mt_split1, mt_split2, 'car_id', 'id_car')