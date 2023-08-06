# Mapping Post-Secondary Transfer Rates

In recent years, there has been a growing interest in understanding the factors that influence students' choices in selecting and transferring between post-secondary institutions. One such factor is geographical distance, which has been highlighted by the American Council on Education's 2016 study. This study revealed that 57% of incoming freshmen attending public four-year colleges enrolled within 100 miles of their permanent residence, suggesting that proximity plays a significant role in students' college decisions. Furthermore, the same study proposed that some students may strategically use these nearby schools as "steppingstones" to transfer to larger institutions later in their academic journey. Considering these findings, this research aims to explore the relationship between geographical distance and post-secondary transfer rates.


### __Project Purpose__    

* The main purpose of this project was to apply graph theory learning outcomes to real-world data
* Network Transitivity & Clustering Coefficient were computed from the data (e.g. number of triples, number of triangles, Distance between Schools)
* The object of this research was to present at KSU's 2023 Analytics Day
* Awarded 3rd place Graduate Research Project at KSU’s 2023 Analytics Day

### __Tools used__     
* Python  
* R  
* GeoPandas
* Networkx
* Graph Theory and Complex Networks: An Introduction by Maarten van Steen

### __Results__    

!["Figure"](https://github.com/njones738/Mapping-Post-Secondary-Transfer-Rates/blob/main/data/images/figures.JPG)

* __University Transfer Rates between Schools within 100 miles (Figure 1):__ Figure 1 shows the location of each school as a gold dot (or vertex) on a map. The size of each dot represents the number of undergraduate students at the school. When two schools are within 100 miles of each other, a red line (or edge) connects them. The width of this line reflects the school's transfer rate, with wider lines indicating higher transfer rates. From this visualization, we can observe that areas with fewer schools seem to have fewer and thinner connecting lines, which might suggest lower transfer rates. 

* __Histogram of Post-Secondary Transfer Rates (Figure 2):__ Figure 2 presents the distribution of transfer rates among post-secondary institutions. The average transfer rate, marked by a dotted red line, is 25%. We can see that most schools have transfer rates below 50%, indicating that less than half of the students transfer between institutions. The maximum transfer rate observed in the dataset is notably high at 84%. This suggests that there is a wide range of transfer rates among schools, and certain institutions may have unique factors or circumstances contributing to such high transfer rates. Considering the wide range of transfer rates observed in Figure 2, further analysis was conducted to explore the variation in transfer rates among different schools and regions.

* __Boxplot of Transfer Rates by Region (Figure 3):__ Figure 3 displays the distribution of post-secondary transfer rates across different regions of the U.S. This plot shows the average transfer rate of each region does not significantly deviate from the overall average transfer rate observed in Figure 2 (visualized by the dotted red line). The region with the lowest average transfer rate is the Southeast, while the highest average transfer rate was observed by the Great Lakes region. Notably, although the average transfer rate of the Southeast region is less than the average transfer rate of the Great Lakes, the variability of transfer rates observed for the Southeast is much larger than the variability observed for the Great Lakes.

* __Scatterplot of the Number of Schools within 100miles by Transfer Rate (Figure 4):__ Figure 4 displays the number of schools within 100 miles of a school on the vertical axis and the transfer rate horizontally. For each panel, the overall average post-secondary transfer rate is plotted as a dotted red line while the region-specific average is plotted as dotted blue line. Although some regions (Great Lakes) display a slight positive relationship between the number of schools within 100 miles and post-secondary transfer rate, this plot suggests the relationship may be very weak or nonexistent.

* __Boxplot of the Number of Schools within 100 miles by Region (Figure 5):__ Figure 5 displays the distribution of the number of schools within 100 miles across different regions. This plot shows for each region the average number of schools within 100 miles, as well as the range of values observed for schools in that region. The Rocky Mountain region was observed with the lowest average number of schools within 100 miles. This suggests the Rocky Mountain region is very sparse in post-secondary institutions (which can be observed in figure 1). In contrast, the Mid East Region was observed with the highest average suggesting the post-secondary density of this region is very high.

## Folder structure

```
- readme.md
- scripts
---- readme.md
---- 
- data
---- readme.md
---- 
- documents
---- readme.md
---- 
```

## Deliverables

* Mapping Post-Secondary Transfer Rates   

## Data sources

* 2020-2021 Collegescorecard   
* Census Shapefiles

## Methods

* __DISTANCE BETWEEN SCHOOLS__ The latitude and longitude of each school was used to find the distance between schools using ‘the great circle distance’ function which computes the shortest distance between two schools on the surface of a sphere 

* __NUMBER OF SCHOOLS WITHIN 100 MILES__ After finding the distance between schools, we identified the schools within 100 miles of each other This group represents a neighborhood of schools, giving students various ' when considering a transfer

* __CLUSTERING COEFFICIENT__ The clustering coefficient of a school is a measure that aids in understanding the degree to which schools are interconnected This measure represents the likelihood that neighboring schools are also neighbors with each other To calculate the clustering coefficient for a school, determine the number of actual connections between its neighbors and the maximum possible connections between them The clustering coefficient is then calculated as the ratio of the actual connections to the maximum possible connections

* __NETWORK TRANSITIVITY__ The network transitivity is a global view of the clustering coefficient and measures proportion of the interconnected schools within a network It reveals the tendency of schools to form clusters or tight knit groups based on their relationships with one another For this project, the network transitivity was 74 which suggests that schools are more likely to be part of tight knit clusters where the neighbors of a school are also neighboring

* __GEOPANDAS__ GeoPandas is a powerful and user friendly library for handling analyzing and visualizing geospatial data by extending Pandas’ functionality with geospatial capabilities This library, alongside networkx and custom user defined functions were used to create the network map displayed in figure 1

* __NETWORKx__ NetworkX is an open source Python library designed for the creation manipulation analysis and visualization of complex networks or graphs It provides a wide range of tools and algorithms that can be applied to various types of networks, such as social networks, biological networks, transportation networks, and many others

* __GGPLOT__ Ggplot is a popular and powerful data visualization library for the R programming language It is based on the "Grammar of Graphics" concept which aid in creating consistent and expressive visualizations  
