function W = imwarph(I, H)
% Warp the input image I1 via homography with H.
    m = size(I, 1);
    n = size(I, 2);

    % Bounding box for the input image.
    % Corners are in clock-wise order.
    B1 = [1, 1; 
          n, 1; 
          n, m; 
          1, m];
      
    % Map all pixel values to warped image.
    [IX, IY] = meshgrid(1:n, 1:m); 
    [JX, JY] = homography([IX(:), IY(:)], H);   
    J = zeros(max(JY(:)) - min(JY(:)), max(JX(:)) - min(JX(:)), 3);
    J(JX, JY, :) = I(IX, IY, :);
    imshow(J);

    % Construct a bounding box for the warped original
    % bounding box.
    B2 = round(homography(B1, H));
    minX = min(B2(:, 1));
    maxX = max(B2(:, 1));
    minY = min(B2(:, 2));
    maxY = max(B2(:, 2));
    imshow(I);
    hold on;
    plot([B2(:, 1); B2(1, 1)]', [B2(:, 2); B2(1, 2)]');
    plot([minX, maxX, maxX, minX, minX], [minY, minY, maxY, maxY, minY]);
    
    [X, Y] = meshgrid(minX:maxX, minY:maxY);
    W = zeros([size(X), 3]);
    disp(size(W));
    
    W(:, :, 1) = interp2(double(I(:, :, 1)), X, Y);    
    W(:, :, 2) = interp2(double(I(:, :, 2)), X, Y);
    W(:, :, 3) = interp2(double(I(:, :, 3)), X, Y);
    W(isnan(W)) = 0;
    W = W / 255;
    
end
