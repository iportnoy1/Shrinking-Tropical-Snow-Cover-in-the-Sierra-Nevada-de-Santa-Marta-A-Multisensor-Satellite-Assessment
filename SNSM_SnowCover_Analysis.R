# ---- Setting working directory ----
setwd("C:/Users/idpdl/Desktop/Landscape Research/Snow in Sierra Nevada de Santa Marta")

# ---- Libraries ----
library(terra)   # for area calculations
library(raster)  # for plotting

# ---- Years ----
years <- 2015:2024

# ---- Preallocate results ----
areas <- data.frame(
  Year = years,
  Expected.Snow.Area.km2 = NA_real_,
  Perennial.Area.km2     = NA_real_
)

# ---- High-resolution TIFF export ----
tiff("SNSM_SCF_panels_2015_2024_600dpi.tif", width  = 6000, height = 8000, 
     res = 600, compression = "lzw")

# Layout, margins, and global text sizes
par(mfrow = c(4, 3), mar  = c(5, 7, 4, 4),
    oma  = c(1, 1, 1, 1), cex.axis = 1.5, cex.lab  = 1.5, cex.main = 1.5)

# ---- Loop over years ----
for (i in seq_along(years)) {
    yr <- years[i]
  # Load raster with terra
  r_t <- terra::rast(paste0("SNSM_SCF_", yr, ".tif"))
  names(r_t) <- "SCF_MEAN"
  
  # Convert to raster object for plotting
  r_r <- raster::raster(r_t)
  
  # Plot
  raster::plot(r_r, xlab = "Longitude", ylab = "Latitude",
               main = as.character(yr), axes = TRUE)
  
  # ---- Area calculations using terra ----
  a_m2 <- terra::cellSize(r_t, unit = "m")
  
  # Expected (probability-weighted) snow area
  areas$Expected.Snow.Area.km2[i] <-
    terra::global(r_t * a_m2, "sum", na.rm = TRUE)[1, 1] / 1e6
  
  # Perennial snow area (SCF >= 0.9)
  px_km2 <- a_m2 / 1e6
  areas$Perennial.Area.km2[i] <-
    terra::global((r_t >= 0.9) * px_km2, "sum", na.rm = TRUE)[1, 1]
}
dev.off()

# Save table with areas
#write.csv(areas, "SNSM_snow_areas_2015_2024.csv", row.names = FALSE)

png("snow_area_plot.png", width = 3000, height = 2000, res = 400) 
plot(areas$Year, areas$Expected.Snow.Area.km2, type = "b", col = "magenta",
     pch = 1, lty = 2, lwd = 1.2, xlab = "Year",
     ylab = "Snow-covered Area (km^2)", ylim = c(2.6,15.5)) 
lines(areas$Year, areas$Perennial.Area.km2, type = "b", col = "blue",
      pch = 3, lty = 2, lwd = 1.2)
legend("bottomleft", c("Overall","Perennial"), col = c("magenta","blue"),
       pch = c(1,3), lty = c(2,2), lwd = 1.2, bty = "n")
dev.off()

#Overall 2015-2024 area change
Ai <- areas$Expected.Snow.Area.km2[1]
Af <- areas$Expected.Snow.Area.km2[10]
D <- Af - Ai
SE_D = sqrt(0.010^2 + 0.008^2)
Z = D/SE_D
pval = 2*pnorm(-abs(Z))

#Year-to-year area change
areas$Year.to.Year.Change <- NA
areas$Year.to.Year.Z <- NA
areas$Year.to.Year.pval <- NA

for (i in 2:10) {
  Ai <- areas$Expected.Snow.Area.km2[i-1]
  Af <- areas$Expected.Snow.Area.km2[i]
  D <- Af - Ai
  SE_D = sqrt(areas$SE[i-1]^2 + areas$SE[i-1]^2)
  Z = D/SE_D
  pval = 2*pnorm(-abs(Z))
  areas$Year.to.Year.Change[i] <- D
  areas$Year.to.Year.Z[i] <- Z
  areas$Year.to.Year.pval[i] <- pval
}