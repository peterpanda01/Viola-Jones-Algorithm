data = load('gtruth_Cross.mat');
posImg = objectDetectorTrainingData(data.gTruth);
imgDir = fullfile('C:','Users','PJ','Pictures','RobotX','Positive Crosses');
addpath(imgDir);
negFolder = fullfile('C:','Users','PJ','Pictures','RobotX','Negative');
negImg = imageDatastore(negFolder);
trainCascadeObjectDetector('detCrosses2.xml',posImg,negFolder,...
    'FalseAlarmRate',0.1,'NumCascadeStages',5);
detector = vision.CascadeObjectDetector('detCrosses2.xml');
img = imread('posCrosses_TestImg (1).jpg');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'Cross');
figure('Name','posCrosses_TestImg (1)','NumberTitle','off'), imshow(detectedImg);
rmpath(imgDir);