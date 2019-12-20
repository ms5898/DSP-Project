ELEN 4810 course project use

Implementation of super resolution based on sparse coding

Reference:
	[1]	J. Yang et al. Image super-resolution via sparse representation. IEEE Transactions on Image Processing, Vol 19, Issue 11, pp2861-2873, 2010
	[2]	Code provided by the author at: http://www.ifp.illinois.edu/~jyang29/

Useage:
	main.m	is the main program for running the SCSR algorithm and compare results

	ScSR.m	contains the algorithm realization by us, with plenty of comments of our understanding & purpose
		refering to the original code by author

Other functions are some simple mathematical processing funcs derived from the provided code.
Note that the optimization problem solving in the illustrated algorithm is realized by the function 
"L1QP_FeatureSign_yang.m". Since this is different from the illustrated optimization and it is beyond our ability to realize it.