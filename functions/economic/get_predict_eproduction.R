

# A function to do predictions for the production model. 
#
# prod_ds: Combined dataset of production data and coefficients recovered 
# 	from a log-log regression.
# logh=q+XB, where X is q, log crew, log trip days, log cumulative harvest, primary, secondary, and dummies for month and fishing year.
# Returns a data.table with an extra column in it.

get_predict_eproduction <- function(prod_ds){
  indepvars=c("log_crew","log_trip_days","primary","secondary", "log_trawl_survey_weight","constant")
  
  # crew, trip days, trawl survey, 
  fyvars=paste0("fy",2004:2015)
  monthvars=paste0("month",1:12)
  
  datavars=c(indepvars,fyvars,monthvars)
  alphavars=paste0("alpha_",datavars)
  
  
  Z<-as.matrix(prod_ds[, ..datavars])
  A<-as.matrix(prod_ds[,..alphavars])
  
  prod_ds$harvest_sim<-rowSums(Z*A)
  prod_ds$harvest_sim=prod_ds$harvest_sim+prod_ds$q
  
  #production
  # bad way to smear
  #prod_ds$harvest_sim<- exp(prod_ds$harvest_sim + fx)*exp((prod_ds$rmse^2)/2)
  
  #good way to smear
  prod_ds$harvest_sim<- (exp(prod_ds$harvest_sim))*prod_ds$emean 
  

  return(prod_ds)
}
