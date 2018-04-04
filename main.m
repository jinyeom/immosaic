% main.m

% This part could be uncommented to manually get the matrices again,
% but for convenience, I have saved I, J, P1, P2, and H to a file.
%
% I = imread('uttower1.JPG');
% J = imread('uttower2.JPG');
% [P1, P2] = manualcorr(I, J);
load('setup.mat');

% Plot the corresponding points.
fig1 = figure;
subplot(1, 2, 1);
imshow(I); hold on;
plot(P1(:, 1), P1(:, 2), 'rx');
subplot(1, 2, 2);
imshow(J); hold on;
plot(P2(:, 1), P2(:, 2), 'bx');

% Compute homography matrix and verify.
H = solveh(P1, P2);
P3 = homography(P1, H);
fig2 = figure;
subplot(1, 2, 1);
imshow(I); hold on;
plot(P1(:, 1), P1(:, 2), 'rx');
subplot(1, 2, 2);
imshow(J); hold on;
plot(P3(:, 1), P3(:, 2), 'bx');

% Using the two images and the homography matrix, stitch the images
% together.
W = imwarph(I, J, H);
fig3 = figure;
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
