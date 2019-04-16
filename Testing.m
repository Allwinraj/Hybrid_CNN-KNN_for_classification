	clc; 
	close all;
	clear ;
	%%% Install and Connect the free IP Webcam mobile app %%%
	url = 'http://192.168.43.1:8080/shot.jpg';
	ss  = imread(url);

	while (1) 
 ss  = imread(url);
 imshow(ss)
	 
	EyeDetect = vision.CascadeObjectDetector('EyePairBig');
	BB=step(EyeDetect,ss);
	 
	if length(BB) == 4
	    disp('face detected')
	   FaceDetect = vision.CascadeObjectDetector; 
FaceDetect.MergeThreshold = 7 ;
BB = step(FaceDetect, ss); 

% imshow(ss); 
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
%     I = rescale(double(I))/2;
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
load Training_feat.mat
load Target_label.mat
 result = knnclassification(net,Training_feat,Target_label,4); %%% KNN classification
if result ==1
    helpdlg('Person 1')
    disp('Person 1')
elseif result ==2
    helpdlg('Person 2')
    disp('Person 2')
elseif result ==3
    helpdlg('Person 3')
    disp('Person 3')
elseif result ==4
    helpdlg('Person 4')
    disp('Person 4')
elseif result ==5
    helpdlg('Person 5')
    disp('Person 5')
elseif result ==6
    helpdlg('Person 6')
    disp('Person 6')
elseif result ==7
    helpdlg('Person 7')
    disp('Person 7')
elseif result ==8
    helpdlg('Person 8')
    disp('Person 8')
elseif result ==9
    helpdlg('Person 9')
    disp('Person 9')
elseif result ==10
    helpdlg('Person 10')
    disp('Person 10')
end
    else
  disp('face not detected')
    end
end
