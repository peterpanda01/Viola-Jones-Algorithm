data = load('gtruth_Triangle.mat');
posImg = objectDetectorTrainingData(data.gTruth);
imgDir = fullfile('C:','Users','PJ','Pictures','RobotX','Positive Triangles');
addpath(imgDir);
negFolder = fullfile('C:','Users','PJ','Pictures','RobotX','Negative');
negImg = imageDatastore(negFolder);
trainCascadeObjectDetector('detTriangle2.xml',posImg,negFolder,...
    'FalseAlarmRate',0.1,'NumCascadeStages',5);
detector = vision.CascadeObjectDetector('detTriangle2.xml');
img = imread('posTriangles_TestImg (1).jpg');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'triangle');
figure('Name','posTriangles_TestImg (1)','NumberTitle','off'), imshow(detectedImg);
rmpath(imgDir);