


## ---- SIMULATION PARAMETERS ---- ##


#### Debugging ####

# Debug using simple temperature trend that reduces variance? (T/F)
simpleTemperature <- FALSE


# Which management procedures csv do you want to read:
#mprocfile<-"mproc.csv"
#mprocfile<-"mprocTest.csv"
#mprocfile<-"mprocEcon_counterfactual_single.csv"

mprocfile<-"mprocEcon_validate.csv"

#### Stock parameters ####

# If you have files in the modelParameters folder for stocks but you don't
# want to include them in a run you can write them in here in the
# stockExclude variable. Do not include the extension.R. For example,
# stockExclude <- 'haddockGB' (string) will leave haddockGB.R out of the analysis.
# stockExclude <- NULL indludes all stocks.
stockExclude <- c()


#### Structural parameters ####

# number of times to repeat this analysis
nrep <- 100

# First year to begin actual management
fmyear <- 2010
# first year after the initial condition period. The initial condition period
# simply fills up the arrays as necessary even before the burn-in period
# begins. This is rather arbitrary but should be larger than the number of
# years in the assessment model and greater than the first age in the model.
fyear <- 35

# maximum year predicted into the future
mxyear <- 2060


#### Burn-in parameters ####

# number of burn-in years (before the pre-2000 non-assessment period)
nburn <- 50


#### Temperature information ####

## Do you want to include temperature projections (in S-R, growth, etc.)
useTemp <- TRUE

## Do you want to use particular models from the cmip data series? If so
## tmods should be a vector of column names (see 
## data/data_raw/NEUS_CMIP5_annual_meansLong.csv'). If NULL use all data
tmods <- NULL

## The temperature quantile of the cmip data series to use. 0.5 for median.
tq <- 0.5

## Representative concentration pathway to use. Currently only 8.5 available.
trcp <- 8.5

## Reference years for temperature downscale
ref0 <- 1982
ref1 <- 2018

## Reference year and function for anomaly calculation
baseTempYear <- 1985
anomFun <- median

# Number of model years to run are defined by the length of the burn-in
# period and the dimension of the CMIP5 data set.
# Load the cmip5 temperature data
# cmip5 <- read.table(file='data/data_raw/NEUS_CMIP5_annual_means.txt',
#                     header=TRUE, skip=2)
# cmip5 <- subset(cmip5, year <= mxyear)

# nyear <- nrow(cmip5) + nburn


#### Management ####

# Scalars to relate the calculated values of reference points to the
# threshold values. Typically this will be 1/2 for Bmsy and 0.75 for F but
# these can be changed to examine sensitivity.
BrefScalar <- 0.5
FrefScalar <- 0.75


#### Helpful parameters ####
# Scalars to convert things
pounds_per_kg<-2.20462
kg_per_mt<-1000
# Set the economic years that we'll use for simulation. 

first_econ_yr<-2010
last_econ_yr<-2015
last_econ_index<-last_econ_yr-first_econ_yr+1

econ_data_start<-2010
econ_data_end<-2015


##############Stocks in the Economic Model #############################
spstock2s<-c("americanlobster","americanplaiceflounder","codGB","codGOM","haddockGB","haddockGOM","monkfish", "other","pollock","redsilveroffshorehake","redfish","seascallop","skates","spinydogfish","squidmackerelbutterfishherring","summerflounder","whitehake","winterflounderGB","winterflounderGOM","witchflounder","yellowtailflounderCCGOM", "yellowtailflounderGB","yellowtailflounderSNEMA")



##############Independent variables in the targeting equation ##########################
### If there are different targeting equations, you can set there up here, then use their suffix in the mproc file to use these new targeting equations
### example, using ChoicEqn=small in the mproc file and uncommenting the next two lines will be appropriate for a logit with just 3 RHS variables.

###########################Make sure you have the correct set of RHS variables.
# Model 2 has a slightly different exp_rev_total variable.

spstock_equation_prenc1=c("exp_rev_total", "fuelprice_distance", "distance", "mean_wind", "mean_wind_noreast", "permitted", "lapermit", "choice_prev_fish", "partial_closure", "start_of_season")
choice_equation_prenc1=c("das_price_mean", "das_price_mean_len","wkly_crew_wage", "len", "fuelprice", "fuelprice_len")

spstock_equation_pre1<-c(spstock_equation_prenc1,"constant")
choice_equation_pre1<-choice_equation_prenc1


spstock_equation_prenc2<-c("exp_rev_total_das", "fuelprice_distance", "distance", "mean_wind", "mean_wind_noreast", "permitted", "lapermit", "choice_prev_fish", "partial_closure", "start_of_season")
choice_equation_prenc2<-c("wkly_crew_wage", "len", "fuelprice", "fuelprice_len")

spstock_equation_pre2<-c(spstock_equation_prenc2,"constant")
choice_equation_pre2<-choice_equation_prenc2


#These are mostly placeholders
spstock_equation_postnc1<-spstock_equation_prenc1
choice_equation_postnc1<-choice_equation_prenc1

spstock_equation_post1<-spstock_equation_pre1
choice_equation_post1<-choice_equation_pre1

spstock_equation_postnc2<-spstock_equation_prenc2
choice_equation_postnc2<-choice_equation_prenc2

spstock_equation_post2<-spstock_equation_pre2
choice_equation_post2<-choice_equation_pre2
############## End Independent variables in the targeting equation ##########################




##############Independent variables in the Production equation ##########################
### If there are different the equations, you can set there up here, then use their suffix in the mproc file to use these new targeting equations
### example, using ProdEqn=tiny in the mproc file and uncommenting the next  line will be regression with 2 RHS variables and no constant.
# production_vars_tiny=c("log_crew","log_trip_days")

production_vars_pre=c("log_crew","log_trip_days","primary","secondary", "log_trawl_survey_weight","constant")
production_vars_post=c("log_crew","log_trip_days","primary","secondary", "log_trawl_survey_weight","log_sector_acl", "constant")
############## End Independent variables in the Production equation ##########################



#### Output ####
# Years after the management period begins to break up the results. For
# example, c(10, 20) would result in plots from 0-10 years after the mgmnt
# period begins, 10-20 years and 20 years to the end of the series.
plotBrkYrs <- c(5, 10, 20)

# Which sets of plots should be created? Set these objects to T/F

# Boxplots of performance measures
plotBP <- TRUE

# Extra folder of reference point plots
plotRP <- FALSE

# Population drivers like temperature, recruitment growth histories
# and selectivity plots
plotDrivers <- TRUE

# Trajectories over different metrics
plotTrajInd <- FALSE     # samples of individual trajectories
plotTrajBox <- FALSE     # boxplots of trajectories
plotTrajSummary <- TRUE  # summary statistics



#how many years before writing out the results to csv? 6 corresponds to 1 "econ" simulation (2010-2015).  Larger will go faster (less overhead) but you lose work if something crashes, 
savechunksize<-10

#Set up a counter for every year that has been simulated
yearcounter<-0

#Set up a list to hold the economic results
revenue_holder<-list()
fishery_output_holder<-list()
fishery_prhat_holder<-list()

#these two lists will hold a vectors that concatenates (r, m, y, calyear, .Random.seed). They should be r*m*y in length.
begin_rng_holder<-list()
end_rng_holder<-list()
