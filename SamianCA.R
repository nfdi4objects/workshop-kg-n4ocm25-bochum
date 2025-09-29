# alle Regionen ----

SamianWide <- SamianFilt %>%
  group_by(ProdRegion, BasicPotform) %>%
  summarise(n = n(), .groups = "drop") %>%
  pivot_wider(
    names_from = BasicPotform,
    values_from = n,
    values_fill = 0
  ) %>%
  as.data.frame()

# Move ProdRegion into rownames
rownames(SamianWide) <- SamianWide$ProdRegion
SamianWide$ProdRegion <- NULL

# assuming your wide table is called SamianWide
# remove the first column (ProdRegion) before CA
SamianCA <- CA(SamianWide[,-1],
               graph = FALSE)

# View basic results
print(SamianCA)

# Plot biplot
fviz_ca_biplot(SamianCA, repel = TRUE)

# alle Regionen ohne Italien ----

SamianWide <- filter(SamianFilt, ProdRegion != "Italian") %>%
  group_by(ProdRegion, BasicPotform) %>%
  summarise(n = n(), .groups = "drop") %>%
  pivot_wider(
    names_from = BasicPotform,
    values_from = n,
    values_fill = 0
  ) %>%
  as.data.frame()

# Move ProdRegion into rownames
rownames(SamianWide) <- SamianWide$ProdRegion
SamianWide$ProdRegion <- NULL

# assuming your wide table is called SamianWide
# remove the first column (ProdRegion) before CA
SamianCA <- CA(SamianWide[,-1],
               graph = FALSE)

# View basic results
print(SamianCA)

# Plot biplot
fviz_ca_biplot(SamianCA, repel = TRUE)

 # Produktionsorte nach Regionen ----

SamianWide <- SamianFilt %>%
  group_by(ProdSite, ProdRegion, BasicPotform) %>%
  summarise(n = n(), .groups = "drop") %>%
  pivot_wider(
    names_from = BasicPotform,
    values_from = n,
    values_fill = 0
  ) %>%
  as.data.frame()

# Move ProdRegion into rownames
rownames(SamianWide) <- SamianWide$ProdSite
SamianWide$ProdSite <- NULL

# assuming your wide table is called SamianWide
# remove the first column (ProdRegion) before CA
SamianCA <- CA(SamianWide[,-1],
               graph = FALSE)

# View basic results
print(SamianCA)

# Plot biplot
fviz_ca_biplot(SamianCA, repel = TRUE, col.row = SamianWide$ProdRegion)

# Produktionsorte nach Regionen ohne Italien ----

SamianWide <- filter(SamianFilt, ProdRegion!="Italian") %>%
  group_by(ProdSite, ProdRegion, BasicPotform) %>%
  summarise(n = n(), .groups = "drop") %>%
  pivot_wider(
    names_from = BasicPotform,
    values_from = n,
    values_fill = 0
  ) %>%
  as.data.frame()

# Move ProdRegion into rownames
rownames(SamianWide) <- SamianWide$ProdSite
SamianWide$ProdSite <- NULL

# assuming your wide table is called SamianWide
# remove the first column (ProdRegion) before CA
SamianCA <- CA(SamianWide[,-1],
               graph = FALSE)

# View basic results
print(SamianCA)

# Plot biplot
fviz_ca_biplot(SamianCA, repel = TRUE, col.row = SamianWide$ProdRegion)
