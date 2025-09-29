#Region x Potform
ggplot(SamianFilt) +
  geom_bar(aes(y=BasicPotform, fill=BasicPotform)) +
  facet_grid(rows=vars(ProdRegion))

#Making it Percentages
SamianRegionPotPerc <- SamianFilt %>%
  count(ProdRegion, BasicPotform) %>%
  group_by(ProdRegion) %>%
  mutate(perc = n / sum(n) * 100)

ggplot(SamianRegionPotPerc) +
  geom_col(aes(x = perc, y = BasicPotform, fill = BasicPotform)) +
  facet_grid(rows = vars(ProdRegion)) +
  xlab("Percentage") +
  theme_minimal()

#Potform x Ornament

SamianBasicOrnPerc <- SamianFilt %>%
  count(BasicPotform, Ornament) %>%
  group_by(BasicPotform) %>%
  mutate(perc = n / sum(n) * 100)

ggplot(SamianBasicOrnPerc) +
  geom_col(aes(x = perc, y = Ornament, fill = Ornament)) +
  facet_grid(rows = vars(BasicPotform)) +
  xlab("Percentage") +
  theme_minimal()

#Region x Ornament

SamianRegionOrnPerc <- SamianFilt %>%
  count(ProdRegion, Ornament) %>%
  group_by(ProdRegion) %>%
  mutate(perc = n / sum(n) * 100)

ggplot(SamianRegionOrnPerc) +
  geom_col(aes(x = perc, y = Ornament, fill = Ornament)) +
  facet_grid(rows = vars(ProdRegion)) +
  xlab("Percentage") +
  theme_minimal()

