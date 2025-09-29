Samian %>% count(ProdRegion) %>% print(n=100)
RegionsToRemove <- c("British", "Helvetisch")
Samian %>%
  filter(!ProdRegion %in% RegionsToRemove) -> SamianFilt

Samian %>% count(GenericPotform) %>% print(n=100)

SamianFilt <- SamianFilt %>%
  mutate(
    Ornament = case_when(
      str_detect(GenericPotform, "Decorated") ~ "Decorated",
      str_detect(GenericPotform, "Rouletted") ~ "Rouletted",
      TRUE ~ "None"
    )
  )

SamianFilt <- SamianFilt %>%
  mutate(
    BasicPotform = case_when(
      str_detect(GenericPotform, "Beaker") ~ "Beaker",
      str_detect(GenericPotform, "Bowl") ~ "Bowl",
      str_detect(GenericPotform, "Calice") ~ "Calice",
      str_detect(GenericPotform, "Chalice") ~ "Calice",
      str_detect(GenericPotform, "Cup") ~ "Cup",
      str_detect(GenericPotform, "Cylinder") ~ "Cylinder",
      str_detect(GenericPotform, "Dish") ~ "Dish",
      str_detect(GenericPotform, "Lagène") ~ "Lagène",
      str_detect(GenericPotform, "Modiolus") ~ "Modiolus",
      str_detect(GenericPotform, "Mortarium") ~ "Mortarium",
      str_detect(GenericPotform, "Plate") ~ "Plate",
      str_detect(GenericPotform, "Platter") ~ "Platter",
      str_detect(GenericPotform, "Poinçon") ~ "Poinçon",
      TRUE ~ "Other"
    )
  )

SamianFilt %>% count(BasicPotform) %>% print(n=100)
