# Examples

### Reference class definition

A class is a useful tool to be used when dealing with identical or similar objects. In the specific code to which this documentation is referring to, classes come in hand when dealing to database connection and data download and storage. Such operation is done to different databases, but the "operating" structure is always the same. It's ok if this is not particularly clear now, but I hope it will be after the examples. <br>

A simple reference class is defined the following way.

```R
fields=list(first_attribute='numeric',
            second_attribute='character',
            third_attribute='logical')

methods=list(print_numeric=function(){
                print(first_attribute)
                },
             conditional_double=function(){
                if(third_attribute){
                    first_attribute <<- first_attribute*2
                    }
                })

setRefClass("reference_class", fields=fields, methods=methods)

example_instance <- new("reference_class")
```

`fields` is a list containing the so-called class attributes. Attributes are variables that belong to the class itself. <br>

`methods` is a list containing the so-called class methodes, i.e. functions belonging to the class. <br>
 
`setRefClass("reference_class")` creates the abstract-class. No object with the class structure is created yet: R just knows what the class structure is and what kind of operations it can perform. <br>

`example_instance <- new("reference_class")` is where a reference_class-type object is created. 

At this point, we have created an object that can store three different variables of three different types. No variable has been stored yet (executing `example_instance$first_attribute` will return nothing), but their type is already fixed. An attempt to assign a different type of variable, e.g. `example_instance$first_attribute <- 'text'`, will return an error. Everything will be fine is the assigned value is the same of the expected one: 
```R
example_instance$second_attribute <- 'text'
example_instance$second_attribute
```
> `'text'`

Methods are basically just functions. Two things require attentions: first, class attributes don't need to ba passed as arguments for the function to be able to use them; second,
operations that are meant to change one class attribute's value require the operation result to be assigned via the "double arrow" symbol, as shown in the conditional_double method.

```R
example_instance$first_argument <- 12.1
example_instance$print_numeric()
``` 

> `12.1`

```R
example_instance$third_argument <- TRUE
example_instance$conditional_double()
example_instance$print_numeric()
```
> `24.2`

### Class inheritance

A reference class can be used as a model to define new classes. Say that we need, for example, a second character variable to be stored. Insteaf of writing a new class from scratch, we can <i>derive</i> one from the already existing one and add an attribute. The definition is similar to the one shown before, with the addition of a `contains` argument that tells R to use <i>reference class</i> as a basis.

```R
setRefClass("ref_derived",
            fields=list(fourth_attribute='character'),
            methods=list(fourth_to_num=function(){
                            fourth_attribute <<- as.numeric(fourth_attribute)
                            }
                        ),
            contains="reference_class")
```

The derived class inherits all attributes and arguments from the "mother" class, and has new ones of her own. Let's define an object of this derived class. In the previous example, we defined an "empty" instance. Attributes can also be speficied when first defining the instance, i.e.

```R
derived_instance <- new("ref_derived",
                        first_attribute=10.6,
                        second_attribute='text',
                        third_attribute=TRUE,
                        fourth_attribute='2')
```
<br>
`conditional_double` and `print_numeric` methods are not explicitly written during the class definition, but they are inherited from the "mother" class. 

```R
derived_instance$conditional_double()
derived_instance$print_numeric()
```

> `21.2`

And of course, the derived class has access to its own methods:

```R
derived_instance$fourth_attribute
```

> `'2'`

```R
derived_instance$fourth_to_num()
```

> `2`