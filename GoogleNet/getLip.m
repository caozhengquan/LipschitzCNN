if isfile('googlenet.mat') == 0
    net = googlenet;
    save('googlenet.mat','net');
else
    load('googlenet.mat');