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
        x = P1(i, 1);
        y = P2(i, 2);
        A(2 * i - 1, :) = [x y 1 0 0 0 1 1];
        A(2 * i, :) = [0 0 0 x y 1 1 1];
    end
    
    % Build b with the set of target points.
    b = zeros(2 * n, 1);
    b(1:2:2 * n) = P2(:, 1);
    b(2:2:2 * n) = P2(:, 2);
    
    H = b \ A;
    H = reshape([H 1], [3, 3])';
end
