import argparse, sys
import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance
from scipy.cluster.hierarchy import linkage, fcluster
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_samples, silhouette_score
from pyclustering.cluster.elbow import elbow

"""
    mash_cluster.py: clustering of mash distance matrices

	description: this script performs a few basic steps to cluster and visualize mash matrices:
		- perform analysis of the mash distances using one of several optimal cluster detection
		  techniques - currently, these are "elbow", "silhouette", "gap", or "fixed"
		- form row and column linkages from the input matrix
		- use `fclust` to flatten each GCA into a cluster
		- use Seaborn's `clustergram` to visualize the matrix

	required packages: 
		- scikit-learn, pyclustering, numpy, pandas, matplotlib, scipy

	inputs:
		- mash matrix formed by using mash_square; this should be a text file containing a square
		  matrix where the first row and column are the sample names, and each element otherwise is
		  a pairwise distance between samples

	outputs:
		- a CSV written according to the -o flag, containing a cluster for each input sample
		- a PNG file of the seaborn clustergram

	notes on cluster selection methods:
		- `elbow` uses the elbow implementation from the pyclustering package. This is an automated
		   version of the elbow method that looks for a bend in within-cluster error for increasing
		   K-means cluster groups. It is still somewhat pseudo-deterministic, and can result in 
		   different clusters even between runs; it is best to run this script in interactive mode
		   (using -e or --interactive) in order to validate the chosen K by eye.
		- `silhouette` uses silhouette scoring from the sklearn package. It is a reliable optimization
		  method, but is usually the longest-running one.
		- `gap` uses a python implementation of the R gap statistic optimization method; the code here
		  is taken from https://github.com/milesgranger/gap_statistic. It tends to favor larger K.
		- `fixed` can be used if you have already computed the number of clusters and just want to use
		  that number directly. Use it by using both the -x and -n flags, i.e., -x fixed -n 15.
"""

# create argument parser
parser=argparse.ArgumentParser(
	description='''mash_cluster.py: clustering of mash distance matrices

	description: this script performs a few basic steps to cluster and visualize mash matrices: 
	(1) perform analysis of the mash distances using one of several optimal cluster detection 
	(2) form row and column linkages from the input matrix 
	(3) use `fclust` to flatten each GCA into a cluster, and write the results to CSV 
	(4) use Seaborn's `clustergram` to visualize the matrix and write it to a PNG''',
	epilog="""Written for the Lopatkin Lab, 2020""")

parser.add_argument('--input', '-i' , type=str, default="", 
	help='the path to the input mash matrix file')
parser.add_argument('--output', '-o' , type=str, default="", 
	help='the path to write the output CSV file')
parser.add_argument('--clrs', '-b' , type=str, default="", 
	help='the colors of heatmap bar')
parser.add_argument('--metric' , type=str, default="euclidean", 
	choices=['euclidean', 'minkowski', 'cityblock', 'seuclidean','sqeuclidean','cosine','correlation','chebyshev','jaccard','yule'], 
	help='the distance metric to use when calculating the clustergram; default is euclidean')
parser.add_argument('--method' , type=str, default="complete", 
	choices=['single', 'complete', 'average', 'weighted', 'centroid', 'ward'], 
	help='the method to use for clustergram distance calculation; the default is complete')
parser.add_argument('--colormap', '-l' , type=str, default="vlag", help='the path to write the output CSV file')
parser.add_argument('--clusterMethod', '-m' , type=str, default="silhouette", 
	choices=['silhouette', 'elbow', 'gap', 'fixed'], 
	help='the method to use for optimal cluster selection; the default is silhouette')
parser.add_argument('--minClusters' , type=int, default=3,
	help='the minimum number of clusters to find using optimization methods; default is 3')
parser.add_argument('--maxClusters' , type=int, default=30,
	help='the maximum number of clusters to find using optimization methods; default is 30')
parser.add_argument('--numFixedClusters', '-n' , type=int, default=0, 
	help='the number of fixed clusters to apply when clusterMethod is "fixed"')
parser.add_argument('--noStandardize', '-s' , default=False, 
	help='turn off standardization of clustergram rows', action="store_false")
parser.add_argument('--clusterColOff', '-c' , default=True, 
	help='turn off clustergram clustering for columns', action="store_false")
parser.add_argument('--clusterRowOff', '-r' , default=True, 
	help='turn off clustergram clustering for rows', action="store_false")
parser.add_argument('--interactive', '-e' , default=False, 
	help='run the script interactively, requires user input', action="store_true")

args = parser.parse_args()

# get parameters from parser
input_file = args.input
output_file = args.output
strain_color_file = args.clrs
metric = args.metric
method = args.method
cmap = args.colormap
clusterMethod = args.clusterMethod
numFixedClusters = args.numFixedClusters
noStandardize=args.noStandardize
cluster_col=args.clusterColOff
cluster_row=args.clusterRowOff
interactive=args.interactive
minClusters=args.minClusters
maxClusters=args.maxClusters

# test for parameter errors
if output_file == "" or input_file == "":
	print("Error: output and input must be specified. Exiting...")
	sys.exit(2)
elif not interactive and clusterMethod == "fixed" and numFixedClusters == 0:
	print("Warning: when mode is not interactive (-e) and cluster selection is 'fixed', number of clusters must be provided using -n or --numFixedClusters.")
	print("Defaulting method to 'Silhouette' instead.")
	clusterMethod = "silhouette"

# read in the mash matrix
mash_mat = pd.read_csv(input_file, index_col=0, sep="\t", header=0)

if maxClusters > len(mash_mat):
	print("Warning: max number of clusters exceeds size of mash matrix. Reducing maxClusters.")
	maxClusters = len(mash_mat)

# collapse the distance matrix
X=distance.pdist(mash_mat).reshape(-1, 1)

# define the range of number of clusters to test
range_n_clusters = range(minClusters,maxClusters+1)

# use the elbow method
if clusterMethod == "elbow":

	elbow_instance = elbow(X, range_n_clusters[0], range_n_clusters[-1]+1)
	elbow_instance.process()
	wce = elbow_instance.get_wce()
	chosen_nClusters = elbow_instance.get_amount()

	if interactive:
		plt.plot(range_n_clusters, wce, 'bx-')
		plt.xlabel('#Clusters')
		plt.ylabel("Distortion")
		plt.title("Elbow Method showing optimal K")
		plt.draw()
		plt.pause(0.001)

		manual_clusters = input("Chose {} clusters. OK? [y/n] ".format(chosen_nClusters)) 
		if manual_clusters in ["n","N","No","no"]:
			chosen_nClusters = input("Please choose the number of clusters: ")

# use the silhouette method
elif clusterMethod == "silhouette":
	avgs = []

	for n_clusters in range_n_clusters:

		clusterer = KMeans(n_clusters=n_clusters, random_state=10)
		cluster_labels = clusterer.fit_predict(X)
		silhouette_avg = silhouette_score(X, cluster_labels)
		avgs.append(silhouette_avg)
		if interactive:
			print("For n_clusters =", n_clusters,
				"The average silhouette_score is :", silhouette_avg)

	if interactive:
		plt.plot(range_n_clusters, avgs, 'bx-')
		plt.xlabel('#Clusters')
		plt.ylabel("Silhouette Average")
		plt.title("Silhouette Method showing optimal K")
		plt.draw()
		plt.pause(0.001)

	chosen_nClusters = avgs.index(min(avgs)) + range_n_clusters[0]
	print("Chosen number of clusters: {}".format(chosen_nClusters))

# use gap statistics (based on https://github.com/milesgranger/gap_statistic)
elif clusterMethod == "gap":
	nrefs = 5
	gaps = np.zeros((len(range_n_clusters),))
	resultsdf = pd.DataFrame({'clusterCount':[], 'gap':[]})
	for gap_index, k in enumerate(range_n_clusters):

		refDisps = np.zeros(nrefs)

		for i in range(nrefs):

			randomReference = np.random.random_sample(size=X.shape)
			km = KMeans(k)
			km.fit(randomReference)
			refDisp = km.inertia_
			refDisps[i] = refDisp

		km = KMeans(k)
		km.fit(X)

		origDisp = km.inertia_
		gap = np.log(np.mean(refDisps)) - np.log(origDisp)
		gaps[gap_index] = gap
		resultsdf = resultsdf.append({'clusterCount':k, 'gap':gap}, ignore_index=True)

	if interactive:
		plt.plot(resultsdf.clusterCount, resultsdf.gap, linewidth=3)
		plt.scatter(resultsdf[resultsdf.clusterCount == k].clusterCount, resultsdf[resultsdf.clusterCount == k].gap, s=250, c='r')
		plt.grid(True)
		plt.xlabel('Cluster Count')
		plt.ylabel('Gap Value')
		plt.title('Gap Values by Cluster Count')
		plt.draw()
		plt.pause(0.001)

	chosen_nClusters = gaps.argmax() + range_n_clusters[0]
	print("Chosen number of clusters: {}".format(chosen_nClusters))

# input cluster number manually
elif clusterMethod == "fixed":
	if interactive:
		chosen_nClusters = input("Please choose the number of clusters: ")
	else:
		chosen_nClusters = numFixedClusters

else:
	print("Error: unknown cluster method. Exiting...")
	sys.exit(2)

# calculate the row and column linkages
row_linkage = linkage(distance.pdist(mash_mat), method=method)
col_linkage = linkage(distance.pdist(mash_mat.T), method=method)

# cluster the linkage using fcluster
clusters = fcluster(row_linkage, chosen_nClusters, criterion='maxclust')
cluster_df = pd.DataFrame(clusters, index=mash_mat.index)
cluster_df.columns = ["Cluster_Association"]
cluster_df.index.name = ""
strain_colors = pd.read_csv(strain_color_file, index_col=0)

# form the clustermap
if noStandardize:
	g = sns.clustermap(mash_mat, 
		vmin=-3, vmax=3,
		metric=metric, 
		row_linkage=row_linkage,
		col_linkage=col_linkage,
		cmap="Spectral", 
		row_cluster=cluster_row,
		col_cluster=cluster_col,
		row_colors=strain_colors, 
		cbar_pos=[.05,.87,.03,.1], 
		tree_kws=dict(linewidths=1.1, colors=(0,0,0)))
else:
	g = sns.clustermap(mash_mat, 
		vmin=-3, vmax=3,
		z_score=0, 
		metric=metric, 
		row_linkage=row_linkage,
		col_linkage=col_linkage,
		cmap="Spectral",
		row_cluster=cluster_row,
		col_cluster=cluster_col,
		row_colors=strain_colors, 
		cbar_pos=[.05,.87,.03,.1], 
		tree_kws=dict(linewidths=1.1, colors=(0,0,0)))


# save the clustergram and the cluster assignments
g.savefig(output_file + ".png")
cluster_df.to_csv(output_file)

if interactive:
	plt.draw()
	plt.pause(0.001)
	input("Press [enter] to terminate.")
