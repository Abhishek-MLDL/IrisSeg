#### IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images


This is the matlab  implementation of the paper
***IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images*** This code is provided for learning and benchmarking.
Algorithms details are given in the paper.


#### Prerequisites
The code is tested on ***Matlab R2014b*** with *i5* processor and 4GB RAM.

#### How to use this code

If you want to see the complete cycle of the segmentation process the best way
is to use the matlab function **irisseg_main** on the matlab command prompt

    >> irisseg_main(/path/to/image/file)
    >>

This will create a folder named **output** if not already created and inside that
four files will be created in the following format

    iris_<filename>.jpg
    irismask_<filename>.jpg
    normalizediris_<filename>.jpg
    normalizedirismask_<filename>.jpg

The details for the above files are as follows

* **iris_filename.jpg** This file will be the same size as the input image and
shows the segmented iris. Only iris pixels are shown and everything else is
white(255,255,255)

* **irismask_filename.jpg** This is the mask file for the iris segmentation with
same size as the input file. All non-iris pixels are black and all the iris
pixels are white.

* **normalizediris_filename.jpg** This is the normalized iris segmented and its
width is 512 pixels and the height is 64 pixels. The size is irresepective of
the input image size. In this file all the iris-pixels are unchanged and the
non-iris pixels are white.

* **normalizedirismask_filename.jpg** This is the mask file for the normalized
segmented iris. It is 512 pixels wide and 64 pixels height. The size is invariant
of the input image and all the iris-pixels are black and the non-iris pixels are
white.

Most of the files are protected but one can get the idea of high level modules
in *irisseg_main.m*


**Parameters**

This version of Code has not been verified to work with different Values for
Scale Parameter. Hence We do not recommend Changing value of Scale Parameter below
Changing Scale may provide better time complexity. But we are not sure
about segmentation or recognition accuracy



**Terms and Conditions**
This code is provided "as is", without any warranty, and for research/academic
purposes only. By downloading the code, you agree with the terms and conditions.

**Reference**

Please remember to cite following reference [1] if you make use of this code in any publication.

    [1] Abhishek Gangwar, Akanksha Joshi, Ashutosh Singh, Fernando Alonso-Fernandez and Josef Bigun,  
        IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images,
        International Conference on Biometrics (ICB), 2016


### Contact
If you have any queries/suggestions regarding the code you can contact the authors at

* abhishekg [at] cdac [dot] in
* akanksha  [at] cdac [dot] in
