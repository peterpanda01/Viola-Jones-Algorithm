data = load('gtruth_Circle.mat');
posImg = objectDetectorTrainingData(data.gTruth);
imgDir = fullfile('C:','Users','PJ','Pictures','RobotX','Positive Circles');
addpath(imgDir);
negFolder = fullfile('C:','Users','PJ','Pictures','RobotX','Negative');
negImg = imageDatastore(negFolder);
trainCascadeObjectDetector('detCircle1.xml',posImg,negFolder,...
    'FalseAlarmRate',0.1,'NumCascadeStages',20);
detector = vision.CascadeObjectDetector('detCircle1.xml');
img = imread('posCircle_TestImg (1).jpg');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'circle');
figure('Name','posCircle_TestImg (1)','NumberTitle','off'), imshow(detectedImg);
rmpath(imgDir);