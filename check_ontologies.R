# create api query for glittr.org tags api
# https://glittr.org/api/tags

# load libraries
library(httr)
library(jsonlite)

# get response
res <- GET("https://glittr.org/api/tags")

# create list out of response
res_list <- fromJSON(content(res, "text"), flatten = TRUE)

# get all tag names
all_tags <- sapply(res_list$tags, "[[", "name") |>
  do.call(what = c, args = _)

# get all tags from tag descriptions
library(readxl)
tag_descr <- read_excel("topic_ontologies_glittr.xlsx")

# check which tags are not in common
# specifc to tag description
setdiff(tag_descr$tag, all_tags)
# specific to glittr tags
setdiff(all_tags, tag_descr$tag)
