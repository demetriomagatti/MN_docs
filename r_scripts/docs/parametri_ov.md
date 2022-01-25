# parametri.r

| Soources | Sourced by |
| -------- | ---------- |
|          | elaboraDati.r |

## What happens here
Parameter definition (time period definition, center selection and grouping, ...)

## Possible changes
<ul>
<li> The file has a lot of commented lines with predefined lists of centeres. These commented lines are situated mid-file, ruining readability. <b>Idea</b>: move those lines to the end of the file and make them predefined values for lists of centeres. From

```R
#listacentri <- c( 'IT057', 'IT062', 'IT136', 'IT189', 'IT461', 'IT512', 'IT544') # Stewardship
#listacentri <- c( 'IT056', 'IT057', 'IT132', 'IT296', 'IT604', 'IT649') # Piemonte
```

mid-file to

```R
######################################################################
# Predefined lists

# Stewardship
listacentri_stewardship <- c( 'IT057', 'IT062', 'IT136', 'IT189', 'IT461', 'IT512', 'IT544') 

# Piemonte
listacentri_piemonte <- c( 'IT056', 'IT057', 'IT132', 'IT296', 'IT604', 'IT649') 
```

at the end of the file. This way we reduce the need of comment/uncomment lines multiple times but can still use already-used and ready list. 

<li> Same sort of operation can be done to when defining 

```R
reportFilename <- 'reportAntibiotici'# 'reportAntibiotici' 'reportAntibioticiVecchio', ...
```

I would deem this less necessary since it has a way smaller impact on code readability. 

</ul>