function [P1, P2] = manualcorr(I1, I2)
% Get manually identified corresponding points from two views.
	[w1, h1] = size(I1);
	[w2, h2] = size(I2);

	% Show two images on the same figures in separate subplots.
	figure;
	subplot(1, 2, 1);
    imshow(I1);
    subplot(1, 2, 2);
    imshow(I2);

    % Manually select points on two subplots.
    % NOTE: the user MUST click on the first image, then on the second
    % image in the corresponding position, and then again on the first
    % image, etc.
    [x, y] = ginput();
    
    P1 = [x(1:2:size(x)), y(1:2:size(y))];
    P2 = [x(2:2:size(x)), y(2:2:size(y))];
    
    close;
end
