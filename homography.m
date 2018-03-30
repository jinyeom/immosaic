function P2 = homography(P1, H)
% Transfrom the argument set of points through homography using the
% argument parameter 3 x 3 matrix H.
    n = size(P1, 1);        % number of points
    P = [P1, ones(n, 1)];   % add ones to each points
    P2 = dot(H, P');        % apply homography
    P2 = P2 ./ P2(3, :);    % divide by lambda
    P2 = P2(1:2, :)';       % return rows of points
end
