# loadOBjects.r

### registry

Derived class; mother class: <b>db_loader</b> (see queryTools section). With respect to the mother class, the registry class has three more attributes and one more method to deal with data filtering upon certain criteria.

<b>Attributes:</b> 
<ul>
<li> <b>start_date</b> [character]: start date to consider in data filtering;
<li> <b>end_date</b> [character]: end date to consider in data filtering;
<li> <b>discharged_only</b> [bool]: boolean flag that allows to consider only patients dismisses from the ICU.
</ul>

<b>Methods</b>
<ul>
<li> <b>filter</b>: applies datetime and discharged_only filter to data; returns filtered data.
</ul>

```R
fields = list(start_date='character',
              end_date='character',
              discharged_only='logical')

methods = list(filter=function(){
                data <<- data[!=is.na(data$DATAORAINGTI) & !=is.na(as.Date(reg$DATAORAINGTI))]
                if(nchar(start_date)!=0){
                    data <<- data[as.Date(data$DATAORAINGTI) >= startDate]
                }
                if(nchar(end_date)!=0){
                    data <<- data[as.Date(data$DATAORAINGTI) <= endDate]
                }
                if(discharged_only){
                    data <<- data[!is.na(data$DATAORAUSCTI)]
                }
            })

setRefClass("registry", 
            fields=fields,
            methods=methods,
            contains("db_loader"))
```

### beds

### antibiotics