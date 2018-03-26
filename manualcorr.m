function [P1, P2] = manualcorr(I1, I2)
% Get manually identified corresponding points from two views. P1 and P2 each 
% refers to rows of (x, y) coordinates of points in each image I1 and I2.
	[w1, h1] = size(I1);
	[w2, h2] = size(I2);

	% Show two images on the same figures in separate axes.
	f = figure;
	ax1 = axes('View 1', [0.0, 0.0, 0.45, 1.0]);
	ax2 = axes('View 2', [0.55, 0.0, 1.0, 1.0]);

end
