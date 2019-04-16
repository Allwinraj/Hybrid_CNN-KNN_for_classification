    clc; 
	close all;
	clear ;
	 %%% Install and Connect the free IP Webcam mobile app %%%
	url = 'http://<ipaddress>:8080/shot.jpg'; 
	ss  = imread(url);
    ii= 0;
	while (1) 
	ss  = imread(url);
 	imshow(ss)
	 %%% Detection Of EYE %%%
	EyeDetect = vision.CascadeObjectDetector('EyePairBig');
	BB=step(EyeDetect,ss);
	
	if length(BB) == 4
        ii= ii+1;
	    disp('face detected')
	   FaceDetect = vision.CascadeObjectDetector; 
FaceDetect.MergeThreshold = 7 ;
BB = step(FaceDetect, ss); 

for i = 1 : size(BB,1)     
  rectangle('Position', BB(i,:), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'r'); 
end 
for i = 1 : size(BB, 1) 
  J = imcrop(ss, BB(i, :)); 
  imshow(J); 
end
	I = rgb2gray(J);
%%% Resize the Image %%%
I = imresize(I,[256 256]);
% figure;imshow(I);title('Resized Image')
%%% Filter the Image 
I = medfilt2(I); 
% figure;imshow(I);title('Filtered Image')
disp('Preprocessing Completed')

%%%%%%%%      CNN    %%%%%%%%%%%%%%%
disp('Convolution Neural Network Started')
h = 60;
w = 60;

test_x = zeros([h w]);  
     if(size(I,3) > 1)
        I = rgb2gray(I);

    end
    I = imresize(I, [h w ] );
    test_x=I;
    
     % initialize cnn
 cnn.start=1; % just intiationg cnn object
 cnn=initcnn(cnn,[60 60 ]);
 cnn=cnnAddConvLayer(cnn, 9, [5 5], 'rect'); % 1 Convolution Layer
 cnn=cnnAddPoolLayer(cnn, 2, 'mean');        % 1 Pooling Layer
 cnn=cnnAddConvLayer(cnn, 15, [5 5], 'rect');% 2 Convolution Layer
 cnn=cnnAddPoolLayer(cnn, 2, 'mean');        % 2 Pooling Layer
 cnn=cnnAddConvLayer(cnn, 21, [5 5], 'rect');% 3 Convolution Layer
 cnn=cnnAddPoolLayer(cnn, 2, 'mean');        % 3 Pooling Layer

cnn = ffcnn(cnn, test_x);
net = cnn.layers{1,7}.featuremaps{1,1};
net = round(net(:)');
Training_feat(ii,:) = net;
    else
        disp('Face not Detected')
    end
    end
    save Training_feat.mat
