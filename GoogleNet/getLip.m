% if isfile('googlenet.mat') == 0
%     net = googlenet;
%     save('googlenet.mat','net');
% else
%     load('googlenet.mat');
% end

% lgraph = layerGraph(net);
% figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
% plot(lgraph);

% gNet = {};
% j = 0;
% for i = [2 6 8 12:2:20 26:2:34 41:2:49 55:2:63 69:2:77 83:2:91 97:2:105, ...
%         112:2:120 126:2:134]
%     j = j + 1;
%     gNet{j,1} = net.Layers(i).Name;
%     gNet{j,2} = net.Layers(i).Stride(1);
%     gNet{j,3} = net.Layers(i).Weights;
% end
%     

% layer = net.Layers(8,1);
% W = layer.Weights;
% 
% 
% Delta = layer.Stride;
% Delta = Delta(1);
% N = size(W, 1);
% C = size(W, 3);
% D = size(W, 4);
% ND = ceil(N/Delta);

load('gNet.mat');
LL = [];

ii = 0;

for t = 34:5:44
ii = ii + 1;
disp(['The ', num2str(ii), '-th iteration.']);

ind_start = t; % where 1-by-1 is
W0 = gNet{ind_start, 3};
C0 = size(W0, 3);
D0 = size(W0, 4);
W1 = gNet{ind_start+2, 3};
C1 = size(W1, 3);
D1 = size(W1, 4);
W2 = gNet{ind_start+4, 3};
C2 = size(W2, 3);
D2 = size(W2, 4);
W0 = padarray(W0, [4,4], 'post');
W1 = padarray(W1, [2,2], 'post');
C = C0 + C1 + C2;
D = D0 + D1 + D2;
W = zeros(5, 5, C, D);
W(:, :, 1:C0, 1:D0) = W0;
W(:, :, C0+1:C0+C1, D0+1:D0+D1) = W1;
W(:, :, C0+C1+1:C, D0+D1+1:D) = W2;
N = 5;
Delta = 1;
ND = ceil(N/Delta);



% ind_start = t; % where 1-by-1 is
% W1 = gNet{ind_start+1, 3};
% C = size(W1, 3);
% Dtemp = size(W1, 4);
% W2 = gNet{ind_start+3, 3};
% W0 = reshape(eye(C), [1,1,C,C]);
% W = cat(4,W0,W1,W2);
% Delta = 1;
% D = size(W,4);
% ND = ceil(N/Delta);


% M = zeros(ND, ND, D, C*Delta*Delta);
% 
% for d = 1:D
%     for c = 1:C
%         A = W(:,:,c,d);
%         Af = fft2(A, ND*Delta, ND*Delta);
%         for j = 1:ND
%             for k = 1:ND
%                 temp = [];
%                 for l1 = 0:Delta-1
%                     for l2 = 0:Delta-1
%                         temp = [temp, Af(j+l1*ND, k+l2*ND)];
%                     end
%                 end
%                 M(j, k, d, (c-1)*Delta*Delta+1:c*Delta*Delta) = ...
%                     temp/Delta/Delta;
%             end
%         end
%     end
% end

Wf = fft2(W, ND*Delta, ND*Delta);
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
L = [L size(W)];
L = [L Delta];
        
LL = [LL; L];

end
