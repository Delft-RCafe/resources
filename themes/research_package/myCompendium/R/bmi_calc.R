#' BMI calculator
#'
#' @param data A data frame with height and weight
#' @return data frame with height, weight, and bmi.
#' @export
bmi_calc <- function(data){
  height_m <- data$height / 100
  weight <- data$weight
  data$bmi <- weight / height_m ** 2
  return(data)
}
