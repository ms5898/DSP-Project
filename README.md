# ELEN 4810 Digital Signal Processing Project
## members:
```
Mingfei Sun (ms5898); Yifeng Deng (yd2505); Zihan Yang (zy2362); Zhuoxu Duan (zd2235)
```
## The Project code is divided into two parts

* 1 PART1: SRCNN 

* 2 PART2: SCSR 

## Prerequisites
* Tensorflow
* MATLAB
* Python3.6.9

## Usage
PART1 SRCNN: 
* For Training and Testing: Run ```All_in_One.ipynb```
* For the saved image: Find in ```PART1_SRCNN/Sample/*.jpg```

PART2 SCSR:
* main.m : 
```
the main program for running the SCSR algorithm and compare results
```
* ScSR.m :
```
contains the algorithm realization by us, with plenty of comments of 
our understanding & purposerefering to the original code by author
```
## Result
* Result for SRCNN
<pre>    Fig1.Original image           Fig2.Bicubic image         Fig3.Super-resolved image </pre>

![orig](https://github.com/ms5898/DSP-Project/blob/master/PART1_SRCNN/Sample/butterfly_GT_hr.jpg)
![bicubic](https://github.com/ms5898/DSP-Project/blob/master/PART1_SRCNN/Sample/butterfly_GT_lr.jpg)
![srcnn](https://github.com/ms5898/DSP-Project/blob/master/PART1_SRCNN/Sample/butterfly_GT_SRCNN.jpg)
* Result for SCSR
![scsr](https://github.com/ms5898/DSP-Project/blob/master/PART2_SCSR/img/result.png)

## References
[1]Dong, C., Loy, C.C., He, K. and Tang, X., 2015. Image super-resolution using deep convolutional networks. IEEE transactions on pattern analysis and machine intelligence, 38(2), pp.295-307.

[2]Yang, J., Wright, J., Huang, T.S. and Ma, Y., 2010. Image super-resolution via sparse representation. IEEE transactions on image processing, 19(11), pp.2861-2873.

[3][Image Super-Resolution Using Deep Convolutional Networks](http://mmlab.ie.cuhk.edu.hk/projects/SRCNN.html) 

[4] PART2 Code provided by the author at: http://www.ifp.illinois.edu/~jyang29/
