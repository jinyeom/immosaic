function H = solveh(P1, P2)
% Compute homography matrix H from a set of corresponding image points.
% P1 is a set of points before the transformation, and P2 is a set of
% target points.
    n = size(P1, 1);
    if n ~= size(P2, 1) || n < 4  
        error('Invalid sets of points provided.')
    end
    
    % Build A with the set of points before homography.
    A = zeros(2 * n, 8);
    for i = 1:n
        x1 = P1(i, 1);
        y1 = P1(i, 2);
        x2 = P2(i, 1);
        y2 = P2(i, 2);
        A(2 * i - 1, :) = [x1, y1, 1, 0, 0, 0, -(x1 * x2), -(y1 * x2)];
        A(2 * i, :) = [0, 0, 0, x1, y1, 1, -(x1 * y2), -(y1 * y2)];
    end
    
    % Build b with the set of target points.
    b = zeros(2 * n, 1);
    b(1:2:2 * n) = P2(:, 1);
    b(2:2:2 * n) = P2(:, 2);
    
    H = A \ b;
    H = reshape([H; 1], [3, 3])';
end
