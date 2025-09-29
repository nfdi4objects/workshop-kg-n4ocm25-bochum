Ogham %>% count(SiteType) %>% print(n=30)

OghamFilt <- filter(Ogham, Height <=10)

OghamFilt <- OghamFilt %>%
  mutate(
    BasicSiteType = case_when(
      SiteType == "Burial ground" ~ "Burial ground",
      SiteType == "Burial ground and probable ecclesiastical site" ~ "Burial ground/Ecclesiastical",
      SiteType == "Cairn" ~ "Cairn",
      SiteType == "Castle" ~ "Fortification",
      SiteType == "Children`a burial ground" ~ "Burial ground",
      SiteType == "Ecclesiastical" ~ "Ecclesiastical",
      SiteType == "ecclesiastical" ~ "Ecclesiastical",
      SiteType == "Possible Ecclesiastical" ~ "Ecclesiastical",
      SiteType == "Possible ecclesiastical" ~ "Ecclesiastical",
      SiteType == "Probable Ecclesiastical" ~ "Ecclesiastical",
      SiteType == "souterrain" ~ "Souterrain",
      SiteType == "Possible souterrain" ~ "Souterrain",
      SiteType == "Souterrain" ~ "Souterrain",
      SiteType == "Possible souterrain in ringfort/rath" ~ "Fortification",
      SiteType == "Promontory fort" ~ "Fortification",
      SiteType == "Souterrain at ancient royal site" ~ "Fortification",
      SiteType == "Souterrain in enclosure" ~ "Fortification",
      SiteType == "Souterrain in large Ringfort/Rath" ~ "Fortification",
      SiteType == "Souterrain in ringfort/rath" ~ "Fortification",
      SiteType == "Souterrain/Ecclesiastical" ~ "Souterrain/Ecclesiastical",
      SiteType == "Standing stone" ~ "Standing stone",
      SiteType == "Stone fort/cashel (possible souterrain)" ~ "Fortification",
      SiteType == "Unassociated" ~ "Unassociated",
      SiteType == "Unknown" ~ "Unassociated",
      SiteType == "Ringfort/rath" ~ "Fortification",
      SiteType == "Long cist burial?" ~ "Burial ground",
      SiteType == "Standing stone pair" ~ "Standing stone"
      
      
      
    )
  )

OghamFilt %>% count(BasicSiteType)

OghamFilt %>% count(Form)

OghamFilt <- OghamFilt %>%
  mutate(
    Volume = if_else(
      !is.na(Height) & !is.na(Width) & !is.na(Thickness),
      Height * Width * Thickness,
      NA_real_
    )
  )

OghamFilt <- OghamFilt %>%
  mutate(
    Surface = if_else(
      !is.na(Height) & !is.na(Width),
      Height * Width,
      NA_real_
    )
  )
