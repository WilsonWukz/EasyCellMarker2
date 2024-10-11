library(readxl)
library(dplyr)
library(ggplot2)


get_marker <- function(spc, tsuClass, tsuType, cellname, file_path = NULL, plot = TRUE) {
  library(readxl)
  library(dplyr)
  library(ggplot2)

  plot <- as.logical(plot)


  if (is.null(file_path)) {
    file_path <- system.file("extdata", "Cell_marker_Human.xlsx", package = "EasyCellMarker2")
  }

  # Read Excel
  cell_marker_data <- read_excel(file_path)

  # Filter
  filtered_data <- cell_marker_data %>%
    filter(species == !!spc,
           tissue_class == !!tsuClass,
           tissue_type == !!tsuType,
           cell_name == !!cellname)

  # Extract Columns ：cell_name, marker, PMID
  result <- filtered_data %>%
    select(cell_name, marker, PMID) %>%
    mutate(marker = ifelse(is.na(marker) | marker == "", "NA", marker),    # 处理 marker 为空的情况
           PMID = ifelse(is.na(PMID) | PMID == "", "NA", PMID))             # 处理 PMID 为空的情况

  # Output
  formatted_result <- paste0('"', result$marker, '", PMID: ', result$PMID, collapse = "; ")

  # Print
  cat(cellname, ": ", formatted_result, "\n", sep = "")

  # Count
  marker_counts <- result %>%
    group_by(marker) %>%
    summarise(count = n()) %>%
    arrange(desc(count))

  # Visualization
  if (plot) {
    ggplot(marker_counts, aes(x = reorder(marker, -count), y = count)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      coord_flip() +
      labs(title = paste0("Marker counts for ", cellname),
           x = "Marker",
           y = "Count") +
      theme_minimal()
  }
}


# Samples
get_marker(spc = "Human", tsuClass = "Abdomen", tsuType = "Abdomen", cellname = "Macrophage")
get_marker(spc = "Human", tsuClass = "Breast", tsuType = "Breast", cellname = "B cell")

