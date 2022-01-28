# queryTools.r

Source file for definition of functions and objects to deal with data download from PostgreSQL database. 

### load_db

```R
load_db <- function(query, dbname=NULL, conffile=DEFCONFFILE, connectionParameters=NULL, maxRetry=8000, wait=5){
    ...
}
```
Function that actually does the download. Replaces <i>getQuery()</i> from the original version. 

<b>Arguments</b>:
<ul>
<li> <b>query</b> [character]: sql-like query string;
<li> <b>dbname</b> [character]: database name; default: NULL;
<li> <b>conffile</b> [character]: path to configuration file to be sourced; contains connection infos (username, pwd, port, ...); default: DEFCONFFILE;
<li> <b>connectionParameters</b> []: allows to use custom connection parameters; default: NULL;
<li> <b>maxRetry</b> [numeric]: maximum number of iterations to attempt in case of connection error;
<li> <b>wait</b> [numeric]: wait time after a failed connection attempt (milliseconds?).
</ul>

<b>Returns</b>:
<ul>
<li> data.frame contanining dowloaded data
</ul>

### customize_query

```R
customize_query <- function(query, centers_list=NULL, conditions_list=NULL){
```

Replaces <i>addConditionToQuery</i> from the original version. 
<b>Arguments</b>:
<ul>
<li> <b>query</b> [character]: sql-like query string;
<li> <b>centers_list</b> [character]: list of the centers to be kept; default: NULL;;
<li> <b>condition_list</b> [character]: extra conditions; default: NULL..
</ul>

<b>Returns</b>:
<ul>
<li> custom query string with added conditions. 
</ul>

<b>Example</b> for `condition_list` format:
```R
class(condition_list)
```
> `character`

```R
condition_list
```
> `[1] "LOWER(\"PRINCIPIOATTIVO\") SIMILAR TO '%(glucosio|destrosio)%'"` <br>
> `[2] "LOWER(\"PRINCIPIOATTIVO\") SIMILAR TO '%(glucosio|destrosio)%'"`

### db_loader
Reference class. Common basis to define objects to download and store downloaded data. If you need a refresh on Reference classes and class inheritance, have a look at the related subsection in the Examples section. 

<b>Attributes</b>:
<ul>
<li> <b>data</b> [data.frame]: data.frame to store downloaded data;
<li> <b>query</b> [character]: sql-like query string;
<li> <b>dbname</b> [character]: database name; default: "";
<li> <b>conffile</b> [character]: path to configuration file to be sourced; contains connection infos (username, pwd, port, ...); default: DEFCONFFILE;
<li> <b>connectionParameters</b> []: allows to use custom connection parameters; default: "";
<li> <b>maxRetry</b> [numeric]: maximum number of iterations to attempt in case of connection error;
<li> <b>wait</b> [numeric]: wait time after a failed connection attempt (milliseconds).
<li> <b>remove_duplicates</b> [logical]: actually unused for now - remove?;
<li> <b>centres_list</b> [character]: list of centers of interest; default: "".
</ul>

<b>Methods</b>
<ul>
<li> <b>initialize_default_values</b>: set default values for connection parameters and attributes;
<li> <b>load</b> calls <i>load_db</i> function; downloaded dataframe saved into the <i>data</i> attribute.
</ul>

The reference class is a base-class to define derived classes for each different connection and download from a database. A complete derivation process is shown in the loadObjects.r section for the registry class  .
