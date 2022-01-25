# analisiM3.r

| Sources | Sourced by |
| -------- | ---------- |
| tools.r                   | elaboraDati.r |
| loadDataTools.r           |               |
| loadDataToolsProsafe.r    |               |
| matchM3Prosafe.r          |               |

## What happens here
<ul>
<li> Load information from M3 database (centri, anagrafica, letti, antibiotics).
</ul>

## Possible changes
<ul>
<li> Chunk code (code lines 66-77 approximately):

```R
#==========================================#
# load antibiotics administrations from M3 #
#==========================================#

abios<-merge(abios,letti,  by.x='IDCENTRORICOVERO', by.y = 'IDCENTRORICOVEROOriginale', all=F)
abios$IDRICOVERO.y<-NULL
abios$ID.y<-NULL
abios$DATAINIZIO.y<-NULL
abios$centreCode.y<-NULL
abios$DATAFINE.y<-NULL
abios<-renameCol(abios, c("IDRICOVERO.x", "centreCode.x","ID.x", "DATAINIZIO.x", "DATAFINE.x"), c("IDRICOVERO", "centreCode","ID", "DATAINIZIO", "DATAFINE"))
```

The code chunk appears some times in the .r file. What it does is to merge two dataframes by one column and remove the duplicates from the merged dataframe. It's a bit messy because it requires to know the column which are duplicated and to manually insert their name. A bit cleaner version would be something like:

```R
library(stringr)
library(data.table)

clean_merge <- function(df_x, df_y, by_x, by_y){
  merged <- merge(df_x, df_y, by.x=by_x, by.y=by_y)
  merged[grepl('..y', names(merged))] <- NULL
  setnames(merged, old=names(merged), new=str_replace(names(merged), ".x", ""))
}
```

In order to do a clean merge you now just need one code line, and the function name actually gives a hint of what it's happening there. Here are some example code lines to simply check its behaviour using a predefined R dataset. 

```R
mt_split1 <- mtcars[c('mpg','cyl','disp')]
mt_split2 <- mtcars[c('mpg','cyl','drat')]
mt_split1$car_id = 1:nrow(mt_split1)
mt_split2$id_car = 1:nrow(mt_split2)

merged <- clean_merge(mt_split1, mt_split2, 'car_id', 'id_car')
```
<b>Occurencies</b>: lines (52-57, 71-77, 118-123, 178-184) <br><br>

<li> More to come: a lot of functions are sourced from other files and I need to do what they do.

</ul>