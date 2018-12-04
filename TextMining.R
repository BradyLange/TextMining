# Developer: Brady Lange
# Date: 12/3/2018
# Description: Text mining techniques.

# PDF File Type Text Mining:
# Load libraries
library(tidyverse)
library(tidytext)
library(pdftools)
library(tm)

# Text mine raw text from PDF file
pdf_text <- pdf_text(pdf = "C:/Users/brady/Downloads/118_ACCT_CSIS_ECON_FINC_MNGT_Mortenson_Sports Analytics and Marketing Research Internship_11 2018.pdf")

# Concatenate raw text data frame together (if given as a data frame)
pdf_text <- str_c(pdf_text[1], pdf_text[2])

# Organize the raw data into lines within a tibble and remove the white space
tidy_pdf_text <- tibble(text = str_split(pdf_text, "\r\n", simplify = T) %>%
  str_trim(.))

# Convert the data to tokens
tidy_pdf_text <- tidy_pdf_text %>%
  unnest_tokens(input = text, output = token)

# Remove stop words
tidy_pdf_text <- tidy_pdf_text %>%
  anti_join(., stop_words, by = c("token" = "word"))

# Frequency of words in PDF file
tidy_pdf_text %>%
  group_by(token) %>%
  count(.) %>%
  arrange(desc(n))
