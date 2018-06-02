data = load('gtruth_Circle.mat');
posImg = objectDetectorTrainingData(data.gTruth);
imgDir = fullfile('C:','Users','PJ','Pictures','RobotX','Positive Circles');
addpath(imgDir);
negFolder = fullfile('C:','Users','PJ','Pictures','RobotX','Negative');
negImg = imageDatastore(negFolder);
trainCascadeObjectDetector('detCircle5.xml',posImg,negFolder,...
    'FalseAlarmRate',0.1,'NumCascadeStages',5,'FeatureType','Haar');
%%
detector = vision.CascadeObjectDetector('detCircle3.xml');
img = imread('posCircle_TestImg (1).jpg');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'circle');
figure('Name','posCircle_TestImg (1) Haar','NumberTitle','off'), 
imshow(detectedImg);
rmpath(imgDir);