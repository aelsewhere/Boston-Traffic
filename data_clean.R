libs <- c(
  "dplyr", "dbplyr", "tidyverse", "stringr",
  "readr", "tidymodels", "pdftools", "ggplot2",
  "readxl", "fs"
)
invisible(lapply(libs, library, character.only = TRUE))

folder_path <- "Data Sources"
file_selection <- list.files(path = folder_path, full.names = TRUE)

volume_data <- NULL

for (file in file_selection) {

  # Import Data
  #extension <- tolower(tools::file_ext(file))

  csv_full <- read_excel(file)
  csv_file <- read_excel(file, skip = 8)

  loc_1 <- rep(csv_full[6, 1], times = nrow(csv_file))
  loc_2 <- rep(csv_full[5, 1], times = nrow(csv_file))
  data <- data.frame(csv_file)

  # Sum all columns after date & time -> volume
  file_volume <- data.frame(data[, -c(1,2)]) %>%
    mutate_all(as.numeric)
  data <- data.frame(data[, c(1, 2)])
  
  # Warning: some files only have one column
  # & others already include a sum column
  # We don't want to double the traffic volume
  num_cols <- ncol(file_volume)

  if (num_cols >= 1) {
    volume <- rowSums(file_volume)
  } else {
    volume <- rep(NA, nrow(file_volume))
  }

  data$Volume <- volume

  data$"Location 1" <- loc_2
  data$"Location 2" <- loc_1
  data$"File Name" <- file

  data_row <- data %>%
    pivot_wider(
      id_cols = c("Location 1", "Location 2", "Date", "File Name"),
      names_from = "Time",
      values_from = "Volume"
    ) %>%
    select(
      "Location 1",
      "Location 2",
      "Date",
      "File Name",
      everything()
    )

  # Add data to dataframe
  if (is.null(volume_data)) {
    volume_data <- data_row
  } else {
    volume_data <- rbind(volume_data, data_row)
  }
}

final_volumes <- bind_rows(volume_data)

print(final_volumes)

############################################################
############## TROUBLESHOOTING #############################

list_columns <- sapply(final_volumes, is.list)
print(names(final_volumes)[list_columns])

final_volumes <- final_volumes %>%
  mutate(across(where(is.list), ~as.character(.)))

write.csv(final_volumes, file = "FINAL_BUILD.csv", row.names = FALSE)
