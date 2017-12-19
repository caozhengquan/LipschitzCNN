function W = getCsld(W0, W1, W2, W3)
%GETCSLD
%   

N0 = size(W0, 1);
N1 = size(W1, 1);
N2 = size(W2, 1);
N3 = size(W3, 1);

C0 = size(W0, 3);
D0 = size(W0, 4);
C1 = size(W1, 3);
D1 = size(W1, 4);
C2 = size(W2, 3);
D2 = size(W2, 4);
C3 = size(W3, 3);
D3 = size(W3, 4);

W0 = padarray(W0, [N3-N0,N3-N0], 'post');
W1 = padarray(W1, [N3-N1,N3-N1], 'post');
W2 = padarray(W2, [N3-N2,N3-N2], 'post');
C = C0 + C1 + C2 + C3;
D = D0 + D1 + D2 + D3;
W = zeros(N3, N3, C, D);
W(:, :, 1:C0, 1:D0) = W0;
W(:, :, C0+1:C0+C1, D0+1:D0+D1) = W1;
W(:, :, C0+C1+1:C0+C1+C2, D0+D1+1:D0+D1+D2) = W2;
W(:, :, C0+C1+C2+1:C0+C1+C2+C3, D0+D1+D2+1:D0+D1+D2+D3) = W3;

end

