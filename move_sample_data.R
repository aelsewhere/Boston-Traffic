addPrefix <- function(folder_path, prefix){
  files <- list.files(path = folder_path, full.names = TRUE)
  for (file in files){
    file_name <- basename(file)
    new_name <- file.path(folder_path, paste0(prefix, "_", file_name))
    file.rename(file, new_name)
  }
}


addPrefix("sample_1", "A")
addPrefix("sample_2", "B")
addPrefix("sample_3", "C")
addPrefix("sample_4", "D")
addPrefix("sample_5", "E")
