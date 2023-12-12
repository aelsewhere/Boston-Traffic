# Boston-Traffic
	Boston is one of the most congested cities in the world and is seeing an uptick in congestion since the pandemic.
 We conducted a practical project to investigate streets in Boston with higher and lower congestion levels through clustering methods to allow for future planning based on what streets need and don’t need attention.
 The data obtained was from the City of Boston’s document management system and had format issues leading to our only using data between a narrower window of time of 2016-18.
 We ran agglomerative clustering with four different linkage methods, DBSCAN with fine tuned parameters, and K-Means finding that DBSCAN had the lowest silhouette score and produced 2 clusters
 We found that one cluster had very few data points and represented less congested streets in Boston, indicating that it is possible the majority of streets in Boston reach high levels of congestion.
 Possible extensions of this project all are related to the access of more data including pedestrian and bike counts.
