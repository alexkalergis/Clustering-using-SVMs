## Project Overview

The tasks are divided into three main problems:

1. **Kernel Density Estimation** - Estimating probability densities using Gaussian kernels for a uniformly distributed random variable.
2. **Kernel-Based Classification** - Building a classifier to distinguish between two sets of data points (stars and circles) using kernel-based methods and optimization.
3. **K-Means Clustering** - Grouping data into clusters using K-Means and improving clustering accuracy through dimensional extension.

## Structure of the Exercises

### Problem 3.1: Kernel Density Estimation
- Generates 1000 samples of a uniformly distributed random variable.
- Approximates the probability density function using Gaussian kernels with different bandwidths (`h` values).
- Analyzes the effect of different bandwidths on the density estimation.

### Problem 3.2: Kernel-Based Classification
- Uses two sets of 2D data points (stars and circles) and builds a classifier using a Gaussian kernel.
- Solves an optimization problem to minimize classification error while controlling the smoothness of the classifier.
- Demonstrates the decision boundary for different values of `h` (bandwidth) and `λ` (regularization parameter).

### Problem 3.3: K-Means Clustering
- Implements the K-Means algorithm to group data into clusters based on proximity to randomly chosen representatives.
- Improves clustering performance by extending the data with an additional dimension.
- Compares results before and after dimensional extension.

## Files in this Repository

- `data32.mat`, `data33.mat`: Data files used for kernel-based classification and K-Means clustering.
- `ex1.m`, `ex2.m`, `ex3.m`: MATLAB scripts corresponding to each problem.

## Usage Instructions

1. **Setup**
   - Ensure MATLAB is installed.
   - Load data files using `load('data32.mat')` or `load('data33.mat')`.

2. **Running the Scripts**
   - `ex1.m`: Runs kernel density estimation.
   - `ex2.m`: Executes kernel-based classification.
   - `ex3.m`: Performs K-Means clustering.

3. **Visualization**
   - Results are displayed as plots showing the density approximation, decision boundaries, and clustering results.


## Project Details

### Problem 3.1: Kernel Density Estimation
- **Method**: Gaussian kernels with varying bandwidths to estimate probability densities.

### Problem 3.2: Kernel-Based Classification
- **Data**: 2D points representing stars (labeled as 1) and circles (labeled as -1).
- **Optimization Problem**: Minimizes error while controlling smoothness using a kernel function.

### Problem 3.3: K-Means Clustering
- **Standard K-Means**: Groups data based on proximity to cluster centers.
- **Extended Dimension**: Adds a new coordinate based on the norm of data points to improve clustering.
