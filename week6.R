#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)



#Data Import
citations <- stri_read_lines("../data/citations.txt", encoding= 'Windows-1252')
citations_txt <- stri_remove_empty(citations)
length(citations) - length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning


citations_tbl <- tibble(line=1:length(citations_txt), cite= citations_txt) 
  