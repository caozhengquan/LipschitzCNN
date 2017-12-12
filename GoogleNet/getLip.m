if isfile('googlenet.mat') == 0
    net = googlenet;
    save('googlenet.mat','net');
else
    load('googlenet.mat');
end

lgraph = layerGraph(net);
figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
plot(lgraph);

A = net.Layers(2,1).Weights;