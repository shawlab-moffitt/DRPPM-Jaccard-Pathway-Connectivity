# DRPPM-Jaccard-Pathway-Connectivity

# Introduction

The integration of patient genome expression data, phenotypye data, and clinical data can serve as an integral resource for patient prognosis. DRPPM PATH SURVEIOR: **Path**way level **Surv**ival **E**xam**i**nat**or** serves to do just that, by examining the interaction of pathway analysis with patient expression and cilinical data to discover prominent features that take part in patient outcome. This utility is comprised of 3 R Shiny apps and a pipeline script which can be employed in a cohesive manor to provide an in-depth analysis towards pathway analysis of patient survival. Gene Set pathways utilized in this workflow include the Molecular Signatures Database (MSigDB), LINCS L1000 Small-Molecule Perturbations, and Clue.io ER Stress signtatures, as well as user provided gene sets. 

Here we focus on the Pathway Connectivity portion of this workflow with the DRPPM-Jaccard-Pathway-Connectivity R Shiny App. This app takes a list of gene sets as input and performs a Jaccard distance calculation to determine the proximity on the gene sets to one another. Working in tandem with the [DRPPM-PATH-SURVEIOR pipeline](), the user may subset a top portion of the gene sets that were output from the comprehensive Cox Proportional Hazard table and use that as input to the Jaccard Connectivity app. This allows the user to gain another perspective on the top gene sets identified and how they cluster together by utilizing visualiztions of heatmaps, dendrograms, and phylogeny-type branched outputs.

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/FlowChart_PathwayConnectivity.png?raw=true)

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

* **User Provided List of Gene Sets (.txt/.tsv):**
  * The only requirements for the file is that it it tab delimited and teh first column is the list of gene sets. 
    * The file will work if there is only one column or multiple, the app will only use the first column
  * This input should be a subset of the table that was output from the [DRPPM-PATH-SURVIOER-Pipeline](https://github.com/shawlab-moffitt/DRPPM-PATH-SURVEIOR-Pipeline)
  * It is recommended to take the top 50-1000 number of significant and high-risk gene sets (rows) from the comprehensive table that is output from the pipeline
    * The table should be pre filtered to have gene sets with a hazard ratio > 1 and a P.value < 0.05.
    * Please note that large input files will take longer for the app to process
  * Example Input files are provided [here](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/tree/main/Example_File_Inputs), these are files that were ouput from the example run of the [DRPPM-PATH-SURVIOER-Pipeline](https://github.com/shawlab-moffitt/DRPPM-PATH-SURVEIOR-Pipeline) with the 50 MSigDB Hallmark Gene sets, with and without the use of the "Responder" covariate.

# App Set-Up

* It is important to ensure that the comprehensive gene set file that is provided is in the proper location for the app to locate it when running.
  * If the [Installation Section](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity#installation) is followed properly there should be no issue.
* When the app is running the user can select to input a file in the user interface and proceed with analysis

# App Features

## Sidebar Panel

###   Pathway and Clustering Parameters

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_Sidebar1.png?raw=true)

### Figure Parameters

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_Sidebar2.png?raw=true)

## Main Panel

### Jaccard Pathway Connectivity Table

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_MainTable.png?raw=true)

### Connectivity Heatmap

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_heatmap.png?raw=true)

### Clustering

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_clustering.png?raw=true)

### Clustering Annotation

![alt text](https://github.com/shawlab-moffitt/DRPPM-Jaccard-Pathway-Connectivity/blob/main/App_Pictures/Jaccard_Conn_annotation.png?raw=true)

# Quesions and Comments

Please email Alyssa Obermayer at alyssa.obermayer@moffitt.org if you have any further comments or questions.
