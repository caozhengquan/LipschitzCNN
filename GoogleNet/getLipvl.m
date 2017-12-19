function [L, N, C, D] = getLipvl(W, Delta)
%GETLIPVL get Lipschitz const given tensor W
%   W - 4D tensor H * W * I * O

if nargin < 2
    Delta = 1;
end

N = size(W, 1);
C = size(W, 3);
D = size(W, 4);

ND = ceil(N/Delta);

Wf = fft2(W, ND*Delta, ND*Delta) / Delta / Delta;

M = reshape(Wf, [ND, ND, C*Delta*Delta, D]);

Mnorm = zeros(ND);
for j = 1:ND
    for k = 1:ND
        temp = M(j,k,:,:);
        temp = reshape(temp, C*Delta*Delta, D);
        Mnorm(j,k) = norm(temp);
    end
end

L = max(Mnorm(:));

end

