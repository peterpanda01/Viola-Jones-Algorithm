clear;

%% Instantiate video device, detector, and KLT object tracker
vidObj = webcam;

circleDetector = vision.CascadeObjectDetector('detCircle3.xml'); 
triangleDetector = vision.CascadeObjectDetector('detTriangle2.xml');

tracker = MultiObjectTrackerKLT;

%% Get a frame for frame-size information
frame = snapshot(vidObj);
frameSize = size(frame);

%% Create a video player instance
videoPlayer  = vision.VideoPlayer('Position',[200 100 fliplr(frameSize(1:2)+30)]);

%% Iterate until we have successfully detected a face
bboxes = [];
while isempty(bboxes)
    framergb = snapshot(vidObj);
    frame = rgb2gray(framergb);
    bboxes = circleDetector.step(frame);
    bboxes = triangleDetector.step(frame);    
end
tracker.addDetections(frame, bboxes);

%% And loop until the player is closed
frameNumber = 0;
keepRunning = true;

while keepRunning
    
    framergb = snapshot(vidObj);
    frame = rgb2gray(framergb);
    
    if mod(frameNumber, 10) == 0
        % (Re)detect objects.
        %
        % NOTE: object detection is more expensive than imresize; we can
        % speed up the implementation by reacquiring objects using a
        % downsampled frame:
        % bboxes = circleDetector.step(frame);
        bboxes = 2 * circleDetector.step(imresize(frame, 0.5));
        bboxes = 2*triangleDetector.step(imresize(frame, 0.5));
        if ~isempty(bboxes)      
            tracker.addDetections(frame, bboxes);            
        end
    else
        % Track objects
        tracker.track(frame);
    end
    
    % Display bounding boxes and tracked points.
    displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
        tracker.Bboxes, tracker.BoxIds);
    displayFrame = insertMarker(displayFrame, tracker.Points);
    videoPlayer.step(displayFrame);    
 
    frameNumber = frameNumber + 1;
    keepRunning = isOpen(videoPlayer);
end

%% Clean up
release(videoPlayer);
release(cam);
release(circleDector);
release(triangleDetector);