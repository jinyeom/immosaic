% main.m

% This part could be uncommented to manually get the matrices again,
% but for convenience, I have saved I, J, P1, P2, and H to a file.
%
% I = imread('uttower1.JPG');
% J = imread('uttower2.JPG');
% [P1, P2] = manualcorr(I, J);
% H = solveh(P1, P2);
load('setup.mat');
W = imwarph(I, J, H);
figure;
imshow(W);

% Now for the lab images.
% Again, this can be done manually, but for convenience, we're gonna load
% the pre-computed matrices.
%
% I = imread('lab1.JPG');
% J = imread('lab2.JPG');
% [P1, P2] = manualcorr(I, J);
% H = solveh(P1, P2);
load('setup_lab.mat');
W = imwarph(I, J, H);
figure;
imshow(W);

% Giant iPad!
%
% I = imread('ipad.jpg');
% J = imread('lab2.JPG');
% [P1, P2] = manualcorr(I, J);
% H = solveh(P1, P2);
load('setup_ipad.mat');
W = imwarph(I, J, H);
figure;
imshow(W);
