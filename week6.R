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
View(sample_n(citations_tbl, 20))

citations_tbl <- tibble(line=1:length(citations_txt), cite= citations_txt) %>%
  mutate(cite=str_replace_all(cite, pattern="[\"\']", replacement="")) %>%
  mutate(year=str_extract(cite,pattern= one_or_more(DGT))) %>% 
  mutate(page_start = str_extract(cite, pattern= capture(one_or_more(DGT)) %R% one_or_more(optional("-"))) ) %>%
  mutate(perf_ref=str_detect(cite, pattern=regex("performance", ignore_case=T))) %>%
  mutate(title=str_extract(cite, pattern = "(?<=\\))\\.(?=\\s)([^\\.]+[.?!])")) %>% 
  mutate(first_author= str_extract(cite, pattern= START %R% one_or_more(WRD) %R% zero_or_more("-" %R% one_or_more(WRD)) %R% optional(",") %R% SPC %R% char_class("A-Z") %R% optional(SPC) %R% optional(DOT) %R% optional(SPC) %R% optional(char_class("A-Z"))))  

sum(!is.na(citations_tbl$first_author))
 

  