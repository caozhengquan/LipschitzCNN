L = [];
for i = [7, 19, 31, 49, 61, 73, 91, 103, 115]

W0 = params(i+4).value;
W1 = params(i+10).value;

% W2 = reshape(eye(size(W0,3)),[1,1,size(W0,3),size(W0,3)]);
% W3 = reshape(eye(size(W0,3)),[1,1,size(W0,3),size(W0,3)]);

W2 = params(i+6).value;
W3 = params(i+8).value;

% W = getCsldRed(W0, W1, W2, W3);

W = getCsld(W0, W1, W2, W3);

L = [L; getLipvl(W)];
end