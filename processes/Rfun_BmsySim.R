


# Recruitment function list for use in the recruitment index column
# of the object mproc (created by the file generateMP.R)

Rfun_BmsySim <- list(
  
  # MEAN = function(parpop, ...) mean(parpop$R),
  
  # L5SAMP = function(parpop, ...) mean(sample(tail(parpop$R), 5)),
  
  # The median temperature for the Bmsy proxy simulations refers to the
  # median temperature between now and 25 years into the future (if there
  # are 25 years available in the series -- otherwise it just uses what is
  # left).
  
  forecast = function(type, parpop, parenv, SSB, TAnom, sdR, ...){
    
    
    parpop$Rpar['rho'] <- 0
    gr <- get_recruits(type = type, 
                 par = parpop$Rpar, 
                 SSB = SSB,
                 TAnom = TAnom,
                 pe_R = sdR,
                 R_ym1 = 1,
                 Rhat_ym1 = 1)
    return(gr[['Rhat']])
    },
  
  hindcastMean = function(Rest, ...){
    mean(Rest)
  },

  hindcastSample = function(Rest,...){
    sample(Rest, 1)
  }
  
)


