library(readxl)
library(dplyr)
library(ggplot2)

get_marker <- function(cellname, spc = NULL, tsuClass = NULL, tsuType = NULL, file_path = NULL, plot = TRUE, output_limit = 10) {
  
  plot <- as.logical(plot)
  
  if (is.null(file_path)) {
    file_path <- system.file("extdata", "Cell_marker_All.xlsx", package = "EasyCellMarker2")
  }
  
  cell_marker_data <- read_excel(file_path)
  
  filtered_data <- cell_marker_data %>%
    filter(cell_name == !!cellname) %>%
    {if (!is.null(spc)) filter(., species == !!spc) else .} %>%
    {if (!is.null(tsuClass)) filter(., tissue_class == !!tsuClass) else .} %>%
    {if (!is.null(tsuType)) filter(., tissue_type == !!tsuType) else .}
  
  result <- filtered_data %>%
    select(cell_name, marker, PMID) %>%
    mutate(marker = ifelse(is.na(marker) | marker == "", "NA", marker),
           PMID = ifelse(is.na(PMID) | PMID == "", "NA", PMID))
  
  if (nrow(result) > output_limit) {
    limited_result <- head(result, output_limit)
    message("The displayed results exceed the upper limit. Only the first ", output_limit, " results.")
  } else {
    limited_result <- result
  }
  
  formatted_result <- paste0('"', limited_result$marker, '", PMID: ', limited_result$PMID, collapse = "; ")
  
  cat(cellname, ": ", formatted_result, "\n", sep = "")
  
  marker_counts <- result %>%
    group_by(marker) %>%
    summarise(count = n()) %>%
    arrange(desc(count))
  
  if (plot && nrow(marker_counts) > 0) {
    ggplot(marker_counts, aes(x = reorder(marker, -count), y = count)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      coord_flip() +
      labs(title = paste0("Marker counts for ", cellname),
           x = "Marker",
           y = "Count") +
      theme_minimal()
  }
}

