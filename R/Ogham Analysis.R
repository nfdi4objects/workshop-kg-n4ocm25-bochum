ggplot(filter(OghamFilt, !is.na(Province))) +
  geom_histogram(aes(Surface, fill=Province)) +
  facet_grid(rows=vars(Province))

ggplot(filter(OghamFilt, !is.na(Province))) +
  geom_histogram(aes(Volume, fill=Province)) +
  facet_grid(rows=vars(Province))

ggplot(filter(OghamFilt, BasicSiteType!="Unassociated")) +
  geom_histogram(aes(Surface, fill=BasicSiteType)) +
  facet_grid(rows=vars(BasicSiteType))

ggplot(filter(OghamFilt, BasicSiteType!="Unassociated")) +
  geom_histogram(aes(Volume, fill=BasicSiteType)) +
  facet_grid(rows=vars(BasicSiteType))

ggplot(filter(OghamFilt, BasicSiteType!="Unassociated")) +
  geom_boxplot(aes(Volume, fill=BasicSiteType))

ggplot(filter(OghamFilt, BasicSiteType!="Unassociated")) +
  geom_boxplot(aes(Surface, fill=BasicSiteType)) 

ggplot(filter(OghamFilt, !is.na(Form))) +
  geom_boxplot(aes(Surface, fill=Form))

ggplot(filter(OghamFilt, !is.na(Form))) +
  geom_boxplot(aes(Volume, fill=Form))
