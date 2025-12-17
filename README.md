# Shrinking-Tropical-Snow-Cover-in-the-Sierra-Nevada-de-Santa-Marta-A-Multisensor-Satellite-Assessment
This repository contains the **Google Earth Engine (GEE)** and **R** source codes, as well as the derived satellite products, supporting the study:

> **Portnoy, I., Torregroza-Espinosa, A. C., Jaramillo, E., & González-Márquez, L. C. (2025).  
> **Shrinking Tropical Snow Cover in the Sierra Nevada de Santa Marta: A Multisensor Satellite Assessment of Seasonal and Perennial Snow (2015–2024)**

The study provides a **high-frequency assessment of seasonal and perennial snow cover dynamics** in the Sierra Nevada de Santa Marta (SNSM), Colombia, using multisensor optical satellite data for the 2015–2024 period.

---

## Study Area
The Sierra Nevada de Santa Marta (SNSM) is an isolated tropical mountain massif in northern Colombia, rising abruptly from sea level to elevations above **5,700 m a.s.l.** It hosts the northernmost and most vulnerable tropical glaciers in South America.
All analyses are restricted to elevations **≥ 4,800 m a.s.l.**, where seasonal or perennial snow occurrence is possible.

---

## Data Sources
The workflow relies exclusively on open and publicly available datasets:

- **Sentinel-2 Level-2A Surface Reflectance**  
  (COPERNICUS/S2_SR_HARMONIZED)
- **Landsat 8 & 9 Collection 2 Level-2 Surface Reflectance**  
  (LANDSAT/LC08/C02/T1_L2, LANDSAT/LC09/C02/T1_L2)
- **SRTM GL1 (30 m) Digital Elevation Model**  
  (USGS/SRTMGL1_003)

All satellite processing was conducted in **Google Earth Engine (GEE)**.

---

## Repository Contents

GGE Source Code.txt        # Google Earth Engine source code

SNSM_SnowCover_Analysis.R    # R script for area computation & plotting

Data:                        # Retrieved Satellite Images
SNSM_SCF_2015.tif
SNSM_SCF_2016.tif
 ...
SNSM_SCF_2024.tif

README.md       

LICENSE_CODE.txt
