function W = imwarph(I, J, H)
% Warp the input image I1 via homography with H.
    im = size(I, 1);
    in = size(I, 2);
    jm = size(J, 1);
    jn = size(J, 2);

    % Map all pixel values to warped image.
    [IX, IY] = meshgrid(1:in, 1:im); 
    P = round(homography([IY(:), IX(:)], H));   
    minX = min(P(:, 1));
    maxX = max(P(:, 1));
    minY = min(P(:, 2));
    maxY = max(P(:, 2));

    % Coordinates of destination image.
    % This image should be able to contain both images.
    minDX = min(1, minX);
    maxDX = max(jn, maxX);
    minDY = min(1, minY);
    maxDY = max(jm, maxY);
    W = zeros(int8(maxDY - minDY), int8(maxDX - minDX), 3);

    [X, Y] = meshgrid(minDX:maxDX, minDY:maxDY);
    DC = [X(:), Y(:)]; 			% Coordinates in the destination image.
    SC = round(homography(DC, inv(H)));	% Coordinates in the source image
    					% (inverse warping).

    % Transfer pixel values for each point.
    for i = 1:size(DC, 1)
        dx = max(1, DC(i, 1) - minDX);
        dy = max(1, DC(i, 2) - minDY);
        sx = SC(i, 1);
        sy = SC(i, 2);
        if sx >= 1 && sx <= in && sy >= 1 && sy <= im
            W(dy, dx, :) = I(sy, sx, :);
        end
    end

    %W(:, :, 1) = interp2(double(W(:, :, 1)), IX, IY);    
    %W(:, :, 2) = interp2(double(W(:, :, 2)), IX, IY);
    %W(:, :, 3) = interp2(double(W(:, :, 3)), IX, IY);
    W(isnan(W)) = 0;
    W = W / 255;
    
    imshow(W);
end
