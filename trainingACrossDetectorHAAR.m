data = load('gtruth_Cross.mat');
posImg = objectDetectorTrainingData(data.gTruth);
imgDir = fullfile('C:','Users','PJ','Pictures','RobotX','Positive Crosses');
addpath(imgDir);
negFolder = fullfile('C:','Users','PJ','Pictures','RobotX','Negative');
negImg = imageDatastore(negFolder);
trainCascadeObjectDetector('detCrosses1.xml',posImg,negFolder,...
    'FalseAlarmRate',0.1,'NumCascadeStages',5,'FeatureType','Haar');
detector = vision.CascadeObjectDetector('detCrosses1.xml');
img = imread('posCrosses_TestImg (1).jpg');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'Cross');
figure('Name','posCrosses_TestImg (1)','NumberTitle','off'), imshow(detectedImg);
rmpath(imgDir);