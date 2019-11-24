# functions for making plots

library(RColorBrewer)

# create color palette
my_pal <- function(x, nm) colorRampPalette(brewer.pal(9, nm))(x)

census_map_df <- function(in_data, state_nm){
  # set "use_cache = F" outside of function before calling
  # input: data with Tract (census tract fips)
  # output: data frame with sp data attached to in_data for ggploting

  library(tigris, quietly = T)
  
  # catch downloading error
  while(class(try(tracts(state=state_nm, cb=T, refresh=T), silent=F)) == "try-error") {
    options(tigris_use_cache = !(use_cache))
  }
  
  # download spdf for state nm
  tract_spdf <- tracts(state=state_nm, cb=T, refresh=T)
  
  # convert spdf to df; rename id column to Tract
  tract_df <- fortify(tract_spdf, region = "GEOID") %>%
    rename(Tract=id)
  
  # merge spatial and in_data
  tract_merge <- left_join(tract_df, in_data, by = c("Tract"))  
  return(tract_merge)
  
}

