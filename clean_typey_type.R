## Idea is to take in the file to/from
## https://didoesdigital.com/typey-type/progress
## Clean it up

library(jsonlite)

current_progress <- read_json("../typeytype.txt", simplifyVector = FALSE)

words <- names(current_progress)
counts <- unname(unlist(current_progress))

quote_space <- grepl("\" ", words)
space_quote <- grepl(" \"", words)

## just remove, simple

keep <- !quote_space & !space_quote

if (mean(keep) < 0.95) {
    stop("throwing away too many, check manually")
}

new_words <- words[keep]
new_counts <- counts[keep]

new_list <- as.list(new_counts)
names(new_list) <- new_words

write_json(
    new_list,
    "../clean_typeytype.txt",
    auto_unbox = TRUE ## still...
)
