# DRPPM-Jaccard-Pathway-Connectivity

# Introduction

# Installation

## Via Download

1. Download the [Zip File](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/archive/refs/heads/main.zip) from this GitHub repository: https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity
2. Unzip the downloaded file into the folder of your choice.
4. Set your working directory in R to the local version of the repository
   * This can be done through the "More" settings in the bottom-right box in R Stuido
   * You may also use the `setwd()` function in R Console.

## Via Git Clone

1. Clone the [GitHub Repository](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity.git) into the destination of your choice.
   * Can be done in R Studio Terminal or a terminal of your choice
```bash
git clone https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity.git
```
3. Set your working directory in R to the cloned repository
   * This can be done through the "More" settings in the bottom-right box in R Stuido
   * You may also use the `setwd()` function in R Console.

# Requirments

* `R` - https://cran.r-project.org/src/base/R-4/
* `R Studio` - https://www.rstudio.com/products/rstudio/download/

# R Dependencies

|  |  |  |  |
| --- | --- | --- | --- |
| shiny_1.7.1 | shinythemes_1.2.0 | shinyjqui_0.4.1 | shinycssloaders_1.0.0 |
| DT_0.23 | pheatmap_1.0.12 | readr_2.1.2 | dplyr_1.0.9 |
| plotly_4.10.0 | clusterProfiler_4.0.5 | ggdendro_0.1.23 | factoextra_1.0.7 |
| reshape2_1.4.4 | stringr_1.4.0 | viridis_0.6.2 | RColorBrewer_1.1-3 |


# Required Files

* **Comprehensive Gene Set File:**
  * This is a provided file [Comprehensive_GeneSet.RData](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/GeneSet_Data/Comprehensive_GeneSet.RData)
  * This is for use in the back end and provides the genes for the gene sets that are input.
  * The gene set names should match the ones provdide when running the DRPPM-PATH-SURVIOER-Pipeline
    * If you ran the pipeline with a user provided gene set the genes for those gene sets will unlikely be found to compare distance between gene sets.

* **User Provided List of Gene Sets:**
  * This input should be a subset of the table that was output from the [DRPPM-PATH-SURVIOER-Pipeline](https://github.com/shawlab-moffitt/DRPPM-PATH-SURVIOER-Pipeline)
  * It is recommended to take the top 50-1000 number of significant and high-risk gene sets (rows) from the comprehensive table that is output from the pipeline
    * The table should be pre filtered to have gene sets with a hazard ratio > 1 and a P.value < 0.05.
  * Please note that large input files will take longer for the app to process

# App Set-Up

* It is important to ensure that the comprehensive gene set file that is provided is in the propper location for the app to locate it when running.
* If the [Installation Section](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity#installation) is followed properly there should be no issue.

# App Features

# Quesions and Comments

Please email Alyssa Obermayer at alyssa.obermayer@moffitt.org if you have any further comments or questions.
