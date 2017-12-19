function W = getCsldRed(W0, W1, W2, W3)
%GETCSLD
%   

N = size(W0, 1);
C = size(W0, 3);
D0 = size(W0, 4);
D1 = size(W1, 4);
D2 = size(W2, 4);
D3 = size(W3, 4);

D = D0 + D1 + D2 + D3;
W = zeros(N, N, C, D);
W(:, :, :, 1:D0) = W0;
W(:, :, :, D0+1:D0+D1) = W1;
W(:, :, :, D0+D1+1:D0+D1+D2) = W2;
W(:, :, :, D0+D1+D2+1:D0+D1+D2+D3) = W3;

end

