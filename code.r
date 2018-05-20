library(leaflet)
library(maps)
mapStates <- map("state", fill=TRUE, plot = TRUE, boundary = TRUE)
forestation <- read.csv("state_forestation.csv")
forestation$state <- tolower(forestation$state)
colnames(forestation)[2] = "forests_pct"
df <- data.frame(mapStates$names)
colnames(df)[1] <- "locations"
df$state <- gsub(":.*", "", df$locations)
df <- merge(df, forestation, by="state", all.x=TRUE)
df <- df[,-1]
##colors
pal <- colorNumeric(palette= "Greens", domain = df$forests_pct)

##initialize map
m <- leaflet(data = mapStates) %>%
  addTiles() %>%  
  addPolygons(stroke = TRUE, weight = .2, opacity = .5, color = "black", smoothFactor = 0.2, fillOpacity = 1,
              fillColor = pal(df$forests_pct))


