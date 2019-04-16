# Hybrid_CNN-KNN_for_classification
This is a matlab-code implementation of cascaded Convolution Neural Network and K-Nearest Neighbor for real time face recognition using mobile camera.

INTRODUCTION:

The proposed architecture replaces the softmax layer by a k-Nearest Neighbor (kNN) algorithm for inference. Although this is a common technique in transfer learning, apply it to the same domain for which the network was trained. In this work, proposed hybrid CNN + kNN architecture is evaluated using real time image dataset. The results show important accuracy improvements in the inference stage with respect to the standard CNN. While KNN itself is a Multi-classification algorithm, so we just adjust the data to the KNN and then we will get the result. But the problem is that it is difficult to choose the suitable parameter K.

PREREQUISITES

In order to run this toolbox you will need:
MATLAB: (tested with MATLAB R2018a)
Data: Your own data (Have fun)
Download & Install: IP Webcam mobile app (Google playstore)

USAGE:

1.	Clone the Repository.
2.	First open training.m file in matlab and IP webcam app in mobile.
3.	Note the IP address from the mobile and write in the testing.m and training.m
4.	Run the program.
5.	Write the Target_label file by your respective dataset.
6.	Then stop the program after training all images.
7.	Now run the testing.m file.

