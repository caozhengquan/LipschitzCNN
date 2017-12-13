% if isfile('googlenet.mat') == 0
%     net = googlenet;
%     save('googlenet.mat','net');
% else
%     load('googlenet.mat');
% end

% lgraph = layerGraph(net);
% figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
% plot(lgraph);

layer = net.Layers(8,1);
W = layer.Weights;


Delta = layer.Stride;
Delta = Delta(1);
N = size(W, 1);
C = size(W, 3);
D = size(W, 4);
ND = ceil(N/Delta);

M = zeros(ND, ND, D, C*Delta*Delta);

for d = 1:D
    for c = 1:C
        A = W(:,:,c,d);
        Af = fft2(A, ND*Delta, ND*Delta);
        for j = 1:ND
            for k = 1:ND
                temp = [];
                for l1 = 0:Delta-1
                    for l2 = 0:Delta-1
                        temp = [temp, Af(j+l1*ND, k+l2*ND)];
                    end
                end
                M(j, k, d, (c-1)*Delta*Delta+1:c*Delta*Delta) = ...
                    temp/Delta/Delta;
            end
        end
    end
end

Mnorm = zeros(ND);
for j = 1:ND
    for k = 1:ND
        temp = M(j,k,:,:);
        temp = reshape(temp, D, C*Delta*Delta);
        Mnorm(j,k) = norm(temp);
    end
end

L = max(Mnorm(:));
L = [L size(W)];
L = [L Delta];
        

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