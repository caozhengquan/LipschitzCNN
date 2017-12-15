% Install and compile MatConvNet (needed once).
untar('http://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta25.tar.gz') ;
cd matconvnet-1.0-beta25
cd matlab
vl_compilenn('enableGpu', true, ...
    'cudaRoot', 'C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v8.0', ...
    'cudaMethod', 'nvcc', ...
    'enableCudnn', true, ...
    'cudnnRoot', 'C:/Cudnn/cudnn-8.0-windows10-x64-v6.0/cuda', ...
    'EnableImreadJpeg',false) ;
cd ..


% setup MatConvNet
run  matlab/vl_setupnn

% download a pre-trained CNN from the web (needed once)
urlwrite(...
  'http://www.vlfeat.org/matconvnet/models/imagenet-googlenet-dag.mat', ...
  'imagenet-googlenet-dag.mat') ;

% load the pre-trained CNN
net = dagnn.DagNN.loadobj(load('imagenet-googlenet-dag.mat')) ;
net.mode = 'test' ;

% load and preprocess an image
im = imread('peppers.png') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = bsxfun(@minus, im_, net.meta.normalization.averageImage) ;

% run the CNN
net.eval({'data', im_}) ;

% obtain the CNN output
scores = net.vars(net.getVarIndex('prob')).value ;
scores = squeeze(gather(scores)) ;

% show the classification results
[bestScore, best] = max(scores) ;
figure(1) ; clf ; imagesc(im) ;
title(sprintf('%s (%d), score %.3f',...
net.meta.classes.description{best}, best, bestScore)) ;