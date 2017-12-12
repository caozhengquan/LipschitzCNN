from __future__ import print_function
import argparse
import os
import sys

import numpy as np
from PIL import Image

import chainer
from chainer import cuda
import chainer.functions as F
from chainer.functions import caffe


xp = cuda.cupy


func = caffe.CaffeFunction('bvlc_googlenet.caffemodel')
cuda.get_device(0).use()
func.to_gpu()


in_size = 224
# Constant mean over spatial pixels                                                                                                  
mean_image = np.ndarray((3, 256, 256), dtype=np.float32)
mean_image[0] = 104
mean_image[1] = 117
mean_image[2] = 123

def forward(x):
    y, = func(inputs={'data': x}, outputs=['pool5/7x7_s1'],
              disable=['loss1/ave_pool', 'loss2/ave_pool'],
              train=False)
    return y


batch_size = 16
x_batch = np.random.random((batch_size, 3, in_size, in_size)).astype(dtype=np.float32)
x = chainer.Variable(xp.asarray(x_batch), volatile=True)
y = forward(x)

y.data