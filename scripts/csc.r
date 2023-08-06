library(tidyverse)
library(tidycensus)
library(tigris)
library(skimr)
library(sf)
library(DataExplorer)

options(tigris_use_cache = TRUE)

# Opens up plot view
rerun_hgd <- function(x) {
    httpgd::hgd()
    httpgd::hgd_browse()
}
rerun_hgd()


df <- read_csv(df_pth, col_types = c("UNITID" = "c",
                                     "OPEID" = "c",
                                     "OPEID6" = "c",
                                     "HCM2" = "c",
                                     "MAIN" = "c",
                                     "PREDDEG" = "c",
                                     "HIGHDEG" = "c",
                                     "CONTROL" = "c",
                                     "REGION" = "c",
                                     "LOCALE" = "c",
                                     "CCBASIC" = "c",
                                     "CCUGPROF" = "c",
                                     "CCSIZSET" = "c",
                                     "ICLEVEL" = "c",
                                     "OPENADMP" = "c"
                                    ) # nolint
              ) %>% # nolint
        filter(STABBR %in% c("AL", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")) # nolint

    mutate(
        CATEG_TRANSFER_RATE_33 = case_when(OMENRAP_ALL < 0.325 ~ "1", T ~ "0")
    ) %>%
    ggplot(aes(x = OMENRAP_ALL, fill = CATEG_TRANSFER_RATE_33)) +
        scale_x_continuous(breaks = seq(0, 0.8, 0.1)) +
        scale_fill_manual(values = c("0" = "gold", "1" = "grey")) +
        geom_histogram(bins = 15,
                    #    fill = "lavender",
                       color = "#6f6f6f"
                      ) +
        xlab("Transfer Rate") +
        ylab("Frequency of Schools") +
        labs(title = "Histogram of Post-Secondary Institution Transfer Rate's") + # nolint
        theme_bw()

df %>%
    mutate(
        CATEG_TRANSFER_RATE_33 = case_when(OMENRAP_ALL < 0.325 ~ "1", T ~ "0")
    ) %>%
    ggplot(aes(x = schools_within_15_miles)) +
        geom_histogram(bins = 25,
                    #    fill = "lavender",
                       color = "grey") +
        xlab("Transfer Rate") +
        ylab("Frequency of Schools") +
        labs(title = "Histogram of Post-Secondary Institution Transfer Rate's") + # nolint
        theme_bw()

df



# subd_df <- df %>%
#     select(
#            INSTNM,
#            LONGITUDE,
#            LATITUDE,
#            OMENRAP_ALL,
#            ADM_RATE,
#            OPENADMP
#           )

df$average_distance %>% max()
df %>%
    ggplot(aes(x = OMENRAP_ALL, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 30) +
        theme_bw()

df %>%
    ggplot(aes(x = average_distance, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        scale_x_continuous(breaks = seq(500, 7500, 1000)) +
        # facet_wrap(is_mainland ~ ., scale = "free_x") +
        theme_bw()

df %>%
    ggplot(aes(x = num_within_250m, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()

df %>%
    ggplot(aes(x = num_within_60m, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()

df %>%
    ggplot(aes(x = num_within_15m, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()

df %>%
    ggplot(aes(x = local_clust_coeff_60, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()

df %>%
    ggplot(aes(x = local_clust_coeff_110, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()

df %>%
    ggplot(aes(x = local_clust_coeff_250, fill = is_mainland)) +
        geom_histogram(col = "grey", bins = 60) +
        theme_bw()



df %>%
    ggplot(aes(x = OMENRAP_ALL, fill = PREDDEG)) +
        geom_histogram(col = "grey", bins = 30) +
        facet_grid(PREDDEG ~ .) +
        theme_bw()


REGION






















county_df <- counties(state = unique(df$STABBR), year = 2020)

df <- st_as_sf(df,
               coords = c("LONGITUDE", "LATITUDE"),
               crs = 4269,
               agr = "constant")

df %>% names()

for (i in seq(1, nrow(df), 1)) {
    
    school_unitid <- paste0("school_", df$UNITID[i])
    school_geometry <- df$geometry[i]

    county_df <- county_df %>%
                    mutate(
                        school_unitid = st_distance(geometry, school_geometry)
                    )

}
county_df

school_unitid




st_distance(county_df$geometry[i],
            df$geometry[i]
           )


df







