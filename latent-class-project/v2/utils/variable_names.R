## SES

ses_full <- c("non_hispanic_black","no_vehicle","single_household","female_householder",
              "less_than_hs_graduate","below_poverty_line","public_assistance","unemployed",
              "rental","males_professional","fem_professional","num_occupants_crowded",
              "phone_service") # "males_occ_management", "fem_occ_management"

ses_abbrv <- c("NHBLK","NO_VHCL", "SINGLE", "HSHLDR_F", "LS_HS", "POV", "PA", "UNMPLYD", "RENT", "PRFL_M",
               "PRFL_F", "CROWD", "PHONE")

ses_adv <- ifelse(ses_abbrv %in% c("PRFL_M", "PRFL_F", "LS_HS"), "ADV", "DISADV")

ses_vrbs <- data.frame(abbrv = ses_abbrv, nms = ses_full, type = ses_adv, orig = rep(NA, length(ses_adv)))

## Pollutants

poln_abbrv <- c("BUTA", "ACET", "BENZENE", "CARBON", "DIESEL", "ETHYL", "FORM", "HEXANE", "LEAD", "MANG", "MERC", "METH", "METHYL", "NICK", "TOLUENE", "XYLENE")
poln_full <- tolower(c("1,3-BUTADIENE", "ACETALDEHYDE", "BENZENE", "CARBON TETRACHLORIDE", "DIESEL PM", "ETHYLBENZENE", 
              "FORMALDEHYDE", "HEXANE", "LEAD COMPOUNDS", "METHANOL", "METHYL CHLORIDE", 
              "TOLUENE", "XYLENES", "MANGANESE COMPOUNDS", "MERCURY COMPOUNDS", "NICKEL COMPOUNDS"))
poln_orig <- tolower(c("1,3-BUTADIENE", "ACETALDEHYDE", "BENZENE", "CARBON TETRACHLORIDE", "DIESEL PM", "ETHYLBENZENE", 
                       "FORMALDEHYDE", "HEXANE", "LEAD COMPOUNDS", "METHANOL", "METHYL CHLORIDE (CHLOROMETHANE)", 
                       "TOLUENE", "XYLENES (MIXED ISOMERS)", "MANGANESE COMPOUNDS", "MERCURY COMPOUNDS", "NICKEL COMPOUNDS"))

poln_type <- rep("VOC", length(poln_abbrv))
for (p in poln_abbrv) {
  w <- which(poln_abbrv == p)
  if (p %in% c("LEAD", "MANG", "MERC", "NICK")) {
    poln_type[w] <- "Metal"
  } else if (p == "DIESEL") {
    poln_type[w] <- "PM"
  }
}

poln_vrbs <- data.frame(abbrv = poln_abbrv, nms = sort(poln_full), type = poln_type, orig = poln_orig)


## Combined

all_vrbs <- rbind(ses_vrbs, poln_vrbs)
