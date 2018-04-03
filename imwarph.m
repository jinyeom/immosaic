function W = imwarph(I, J, H)
% Warp the input image I1 via homography with H.
    im = size(I, 1);
    in = size(I, 2);
    jm = size(J, 1);
    jn = size(J, 2);

    % Map all pixel values to warped image.
    [IX, IY] = meshgrid(1:in, 1:im); 
    P = round(homography([IX(:), IY(:)], H));   

    % Coordinates of destination image.
    % This image should be able to contain both images.
    minDX = min(1, min(P(:, 1)));
    maxDX = max(jn, max(P(:, 1)));
    minDY = min(1, min(P(:, 2)));
    maxDY = max(jm, max(P(:, 2)));
    W = zeros(int32(maxDY - minDY), int32(maxDX - minDX), 3);
    
    % First transfer the base image.
    % This is a part of the "stitching the images". It's easier to put the
    % base image down first, than doing so after warping the other image.
    for y = 1:jm
        for x = 1:jn
            wx = min(max(x - minDX, 1), size(W, 2));
            wy = min(max(y - minDY, 1), size(W, 1));
            W(wy, wx, :) = J(y, x, :);
        end
    end

    [X, Y] = meshgrid(minDX:maxDX, minDY:maxDY);
    DC = [X(:), Y(:)]; % Coordinates in the destination image.
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

    % This function doensn't seem to be necessary...
    % Weird, but the result looks good enough I think.
    %W(:, :, 1) = interp2(double(W(:, :, 1)), IX, IY);    
    %W(:, :, 2) = interp2(double(W(:, :, 2)), IX, IY);
    %W(:, :, 3) = interp2(double(W(:, :, 3)), IX, IY);
    W(isnan(W)) = 0;
    W = W / 255;
end
