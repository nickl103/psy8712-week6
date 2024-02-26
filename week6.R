#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
library(rebus)


#Data Import
citations <- stri_read_lines("../data/citations.txt", encoding= 'Windows-1252')
citations_txt <- stri_remove_empty(citations)
length(citations) - length(citations_txt)
mean(str_length(citations_txt))

#Data Cleaning
####come back to it later

citations_tbl <- tibble(line=1:length(citations_txt), cite= citations_txt) %>%
  mutate(cite=str_replace_all(cite, pattern="[\"\']", replacement="")) %>%
  mutate(year=str_extract(cite,pattern= one_or_more(DGT))) %>% #this works because it pulls the first number but it won't work with the next one because there are other numbers before it 
  mutate(page_start=str_extract(cite, pattern= one_or_more(DGT))) ###????? come back to it later


  