function vispoints(I1, I2, P1, P2, filename)
% Visualize sets of points P1 and P2 on images I1 and I2.
    fig = figure;
	subplot(1, 2, 1);
    imshow(I1); 
    hold on; 
    plot(P1(:, 1), P1(:, 2), 'r*');
    hold off;
    subplot(1, 2, 2);
    imshow(I2);
    hold on;
    plot(P2(:, 1), P2(:, 2), 'r*');
    hold off;
    
    % Save the figure
    saveas(fig, filename);
end