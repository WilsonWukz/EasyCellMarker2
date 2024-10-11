# EasyCellMarker2

The EasyCellMarker2 package allows users to easily retrieve cell marker genes **from the CellMarker 2.0 database** based on specified filters such as **species**, **tissue class**, **tissue type**, and **cell name**. It provides the corresponding markers along with their source PMID for further analysis. The data in this package comes from the download provided by the official website of CellMarker2.0. 
I am very grateful for their selfless help in bioinformatics research. 

At the same time, since the data in this package is obtained from the local computer, if the official CellMarker2.0 updates the data, there may be some errors in the data in this package. 
The date of obtaining the data from CellMarker2.0 : **October 11, 2024**.

# Installation
EasyCellMarker2 R package can be easily installed from Github using devtools. Please make sure you have installed 'readxl', 'dplyr' and 'ggplot2' packages.
```
library(devtools)
devtools::install_github("WilsonWukz/EasyCellMarker2")
```

# Usage
First, read the required R package, otherwise you will not be able to successfully use the built-in functions of the package.
```
library(readxl)
library(dplyr)
library(ggplot2)
library(EasyCellMarker2)
```

Then we can use the 'get_marker(spc =, tsuClass =, tsuType =, cellname =)' function.
For example, we want to check the cell markers of **Fibroblast** in **Brain** tissue type in **Brain** tissue class, **human** species.
```
get_marker(spc = "Human", tsuClass = "Brain", tsuType = "Brain", cellname = "Fibroblast")
```
![image](https://github.com/user-attachments/assets/2f1d8563-b429-4756-9f81-0ed6fdeb36d7)
![image](https://github.com/user-attachments/assets/2444c611-23ff-4074-9db3-e5c0a2b0fd2f)


Hope you enjoy using it :)
