####----Install and load packages----####

packages <- c("shiny","shinythemes","shinyjqui","pheatmap","RColorBrewer",
              "ggdendro","factoextra","dplyr","DT","viridis","readr",
              "shinycssloaders","stringr","tools","plotly","reshape2")

installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))
#bioconductor packages
bioCpacks <- c("clusterProfiler")
installed_packages_BIOC <- bioCpacks %in% rownames(installed.packages())
if (any(installed_packages_BIOC == FALSE)) {
  BiocManager::install(bioCpacks[!installed_packages_BIOC], ask = F)
}
invisible(lapply(bioCpacks, library, character.only = TRUE))


####---- Read in Files----####

GeneSet_File <- "GeneSet_Data/Comprehensive_GeneSet.RData"

GeneSetTable_File <- "GeneSet_Data/Comprehensive_GeneSet_CatTable.zip"





# R Data list load function for naming
loadRData <- function(fileName){
  #loads an RData file, and returns it
  load(fileName)
  get(ls()[ls() != "fileName"])
}
gs <- loadRData(GeneSet_File)

GeneSetTable <- as.data.frame(read_delim(GeneSetTable_File, delim = '\t', col_names = T))

GeneSetCatTable <- GeneSetTable[,-3]
GeneSetCatTable <- unique(GeneSetCatTable)

#increase file upload size
options(shiny.maxRequestSize=50*1024^2)

shinytheme("sandstone")

ui <- 
  navbarPage("{ Jaccard Pathway Connectivity Index }",
             
             ####----Intra-Pathway Connectivity----####
             
             tabPanel("Pathway Connectivity",
                      fluidPage(
                        title = "Pathway Connectivity",
                        sidebarLayout(
                          sidebarPanel(
                            tabsetPanel(
                              
                              ####----Pathway Input----####
                              
                              tabPanel("Pathway Parameters",
                                       p(),
                                       h4("Upload Pathways of Interest"),
                                       fluidRow(
                                         column(9,
                                                 fileInput("UserPathwayFile","Upload File (.gmt/.tsv/.txt/.RData)",
                                                           accept = c(".gmt",".tsv",".txt"))
                                                ),
                                         column(3,
                                                checkboxInput("HeaderCheckIntra","Header",value = T))
                                       ),
                                       h4("Clustering Parameters"),
                                       fluidRow(
                                         column(4,
                                                selectInput("ClustMethodIntra","Clustering Method:",
                                                            choices = c("ward.D", "complete", "ward.D2", "single", "average", "mcquitty", "median", "centroid"))
                                                ),
                                         column(8,
                                                numericInput("NumClusters", step = 1, label = "Number of Clusters (Cut Tree with ~k)", value = 10)
                                                )
                                         ),
                                       checkboxInput("ViewClustTabIntra","View Cluster Results Table"),
                                       uiOutput("rendClustTabIntra"),
                                       downloadButton("dnldClustTabIntra","Download Cluster Result"),
                                       h4("SIF Download"),
                                       numericInput("JaccDistCutoff","Jaccard Distance Cutoff",
                                                    min = 0,max = 1, step = 0.1, value = 0.9, width = "200px"),
                                       checkboxInput("PrevSIF","Preview SIF File",value = F),
                                       uiOutput("rendSIFPreview"),
                                       downloadButton("dnldSIFTabIntra","Download SIF File")
                                       ),
                              
                              ####----Figure Parameters----####
                              
                              tabPanel("Figure Parameters",
                                       h4("Heatmap Parameters"),
                                       selectInput("ColorPaletteIntra", "Select Color Palette:",
                                                   choices = c("Red/Blue" = "original",
                                                               "OmniBlueRed" = "OmniBlueRed",
                                                               "LightBlue/BlackRed" = "LightBlueBlackRed",
                                                               "Green/Black/Red" = "GreenBlackRed",
                                                               "Yellow/Green/Blue" = "YlGnBu","Inferno" = "Inferno",
                                                               "Viridis" = "Viridis","Plasma" = "Plasma",
                                                               "Reds" = "OrRd","Blues" = "PuBu","Greens" = "Greens")),
                                       fluidRow(
                                         column(6,
                                                checkboxInput("HeatColNamesIntra","Show Heatmap Column Names", value = F),
                                                numericInput("HeatColFontIntra", "Heatmap Column Font Size:",
                                                             min = 5, max = 75,
                                                             value = 12, step = 1),
                                                numericInput("HeatColDendHeight","Column Dendrogram Height:",
                                                             value = 50, step = 1)
                                                ),
                                         column(6,
                                                checkboxInput("HeatRowNamesIntra","Show Heatmap Row Names", value = F),
                                                numericInput("HeatRowFontIntra", "Heatmap Row Font Size:",
                                                             min = 5, max = 75,
                                                             value = 9, step = 1),
                                                numericInput("HeatRowDendHeight","Row Dendrogram Height:",
                                                             value = 50, step = 1)
                                                )
                                         ),
                                       h4("Connectivity Visualization Parameters"),
                                       selectInput("ConnView","View Connectivity as:",
                                                   choices = c("Phylogeny" = "phylogenic","Dendrogram" = "rectangle","Circular" = "circular")),
                                       uiOutput("rendPhyloLayout"),
                                       fluidRow(
                                         column(6,
                                                checkboxInput("ShowConnLabels","Show Labels:",value = T)
                                                ),
                                         column(6,
                                                numericInput("ConnFontSize","Font Size:",
                                                             value = 0.4, step = 0.1)
                                                )
                                         )
                                       )
                              )
                            ),
                          mainPanel(
                            tabsetPanel(
                              
                              ####----Jaccard Table----####
                              
                              tabPanel("Jaccard Pathway Connectivity Table",
                                       p(),
                                       div(DT::dataTableOutput("JaccTableIntra"), style = "font-size:12px"),
                                       uiOutput("renddnldJaccTabIntra")
                                       ),
                              
                              ####----Jaccard Heatmap----####
                              
                              tabPanel("Heatmap",
                                       withSpinner(jqui_resizable(plotOutput('JaccHeatmapIntra', width = "100%", height = "800px")), type = 6)
                                       ),
                              
                              ####----Jaccard Clustering----####
                              
                              tabPanel("Clustering",
                                       uiOutput("rendJaccDendo")
                                       ),
                              
                              ####----Jaccard Cluster Annotation----####
                              
                              tabPanel("Gene Clusters and Annoation",
                                       fileInput("UserAnnotationFile","Upload Annotation File",
                                                 accept = c(".tsv",".txt",".csv")),
                                       div(DT::dataTableOutput("ClusterTabAnno"), style = "font-size:12px"),
                                       uiOutput("renddnldClusterTabAnno")
                                       )
                              )
                            )
                          )
                        )
             )
  )























