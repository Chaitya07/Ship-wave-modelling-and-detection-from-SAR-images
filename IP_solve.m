clearvars
close all
addpath('.\source functions');
addpath('.\saved data');
addpath('.\Images');
%% Parameter Initialization
thetaRotate = 45;
numRotate = 180/thetaRotate;               
thetaInt = -90:0.25:(-90+thetaRotate);       
normType = 'GMC';                                                           % Norm type. For storing only.
lambda = 50;                                                                
gamma = 0.9;                                                                                     
load('testImage.mat');                                                      % Loading the test image. It returns an image within a variable "Image"
%% Inverse problem solution
GMCImage = zeros([size(Image) numRotate]);
for rotation = 1:numRotate
    fprintf('Processing... %d/%d\n', rotation, numRotate)
    theta = thetaInt + thetaRotate*(rotation-1);
    A  = @(x) radonT(x,theta);                                              % Inverse Radon Transform operator - C
    AH = @(x) radon(x,theta);                                               % Radon Transform Operator - R
    temp = GMC_regularisation(Image, A, AH, 1, lambda, gamma);                     % Variable "temp" is the solution in Radon space
    image_GMC = A(temp);                                                    % Tranform into image domain.
    image_GMC = image_GMC/max(image_GMC(:));                                % Normalization between 0 and 1.
    GMCImage(:, :, rotation) = image_GMC;                                   % Storing results.
end
%% Storing processed data for future use
cd('.\saved data')
filename = 'wakeDetection_test.mat';
save(filename)
cd('.\..')
