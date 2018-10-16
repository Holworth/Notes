# coding: utf-8
# ============================================================================
#   Copyright (C) 2017 All rights reserved.
#
#   filename : Logistic_Regression.py
#   author   : chendian / okcd00@qq.com
#   date     : 2018-09-26
#   desc     : Tensorflow Logistic Regression Tutorial
#   
# ============================================================================
from __future__ import print_function
import os
os.environ["CUDA_VISIBLE_DEVICES"] = ""

import sys
import math
import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt

# use data from sklearn package
def load_moons():
    from sklearn.datasets import make_moons
    np.random.seed(0)
    X, y = make_moons(800, noise=0.2)
    print ("dataset shape:", X.shape)
    
    # return train validate test sets 
    return [(X[0:600,],y[0:600,]), (X[600:800,],y[600:800,])]

def load_circles():
    from sklearn.datasets import make_circles
    np.random.seed(0)
    X, y = make_circles(800, noise=0.2, factor=0.5, random_state=2)
    print ("dataset shape:", X.shape)
    
    # return train validate test sets 
    return [(X[0:600,],y[0:600,]), (X[600:800,],y[600:800,])]

def load_linear():
    from sklearn.datasets import make_classification
    np.random.seed(0)
    X, y = make_classification(
        800, n_features=2, n_redundant=0, n_informative=1,
        random_state=1, n_clusters_per_class=1)
    print ("dataset shape:", X.shape)
    
    # return train validate test sets 
    return [(X[0:600,],y[0:600,]), (X[600:800,],y[600:800,])]

def load_data(name='moons', load_directly=False):
    _datasets={
        'moons': load_moons,
        'linear': load_linear,
        'circles': load_circles,
    }
    try:
        ret = pickle.load(open('./{}.pkl'.format(name), 'r')) if load_directly else _datasets[name]()
    except Exception as e:
        print("set name as 'moons', 'linear' or 'circles',\n or check your files' existence")
        print(e)
    return ret

load_data()

class LogisticRegression():
    def __init__(self, n_in, n_out):
        self.X = tf.placeholder(tf.float32, [None, n_in], name='X')
        self.y = tf.placeholder(tf.int32, [None], name='y')
        self.init_variables(n_in, n_out)
        
    def init_variables(self, n_in, n_out):
        # n_in means n_features
        # n_out means n_classes
        self.W = tf.Variable(
            initial_value=tf.constant(0.0, shape=[n_in, n_out]),
            dtype=tf.float32, name='weight')
        self.b = tf.Variable(
            initial_value=tf.constant(0.0, shape=[n_out]),
            dtype=tf.float32, name='bias')

    def softmax(self, logits):
        # softmax = tf.exp(logits) / tf.reduce_sum(tf.exp(logits), axis)
        return tf.nn.softmax(logits, -1)
        
    def negative_log_likelihood(self, y_pred, y):
        prob = self.sigmoid(y_pred)
        positive_likelihood = tf.log(prob) * y.reshape(-1, 1)
        negative_likelihood = tf.log(1 - prob) * (1 - y.reshape(-1, 1))
        log_likelihood = positive_likelihood + negative_likelihood
        return -tf.reduce_mean(log_likelihood)
    
    def get_network(self):
        hidden = tf.matmul(self.X, self.W) + self.b
        self.y_pred = tf.argmax(self.softmax(hidden), axis=-1)  
        return self.y_pred, hidden
    
    def get_loss(self, hidden):
        # self.loss = self.negative_log_likelihood(y_pred, y)
        # self.loss = tf.nn.sigmoid_cross_entropy_with_logits(pred, y)
        onehot_labels = tf.one_hot(self.y, depth=2)
        self.loss = tf.losses.softmax_cross_entropy(onehot_labels=onehot_labels, logits=hidden)
        return tf.reduce_mean(self.loss)
    
    def gen_input(self, data_x, data_y=None):
        feed_dict = {}
        feed_dict[self.X] = data_x
        if data_y is not None:    
            self.y_truth = data_y
            feed_dict[self.y] = data_y
        return feed_dict
    
    def errors(self, y_pred, y_truth=None):
        if y_truth is None:
            y_truth = self.y
            not_equal_counts = tf.abs(y_pred - y_truth)
            return tf.reduce_mean(not_equal_counts)
        else:
            not_equal_counts = abs(y_pred - y_truth)
            return np.mean(not_equal_counts)



class LinearRegression():
    def __init__(self, n_in, n_out):
        self.X = tf.placeholder(tf.float32, [None, n_in], name='X')
        self.y = tf.placeholder(tf.int32, [None], name='y')
        self.init_variables(n_in, n_out)
        
    def init_variables(self, n_in, n_out):
        # n_in means n_features
        # n_out means n_classes
        self.W = tf.Variable(
            initial_value=tf.constant(0.0, shape=[n_in, n_out]),
            dtype=tf.float32, name='weight')
        self.b = tf.Variable(
            initial_value=tf.constant(0.0, shape=[n_out]),
            dtype=tf.float32, name='bias')

    def linear_normalize(self, input):
        # return tf.exp(input) / tf.reduce_sum(tf.exp(input), -1) #有问题: 维度不对
        # return tf.exp(input) / tf.reduce_sum(tf.exp(input), 0) #应为这样的写法
        # return tf.nn.softmax(input, -1) #应该使用这样的维度
        return  input/tf.reduce_sum(input, 0)
        
    # def negative_log_likelihood(self, y_pred, y):
    #     prob = self.sigmoid(y_pred)
    #     positive_likelihood = tf.log(prob) * y.reshape(-1, 1)
    #     negative_likelihood = tf.log(1 - prob) * (1 - y.reshape(-1, 1))
    #     log_likelihood = positive_likelihood + negative_likelihood
    #     return -tf.reduce_mean(log_likelihood)
    
    def get_network(self):
        hidden = tf.matmul(self.X, self.W) + self.b
        # self.y_pred = tf.argmax(self.softmax(hidden), axis=-1)  
        # self.y_pred = tf.argmax(hidden, axis=-1)  
        self.y_pred = tf.argmax(self.linear_normalize(hidden), axis=-1)  
        return self.y_pred, hidden
    
    def get_loss(self, hidden):
        # self.loss = self.negative_log_likelihood(y_pred, y)
        # self.loss = tf.nn.sigmoid_cross_entropy_with_logits(pred, y)
        onehot_labels = tf.one_hot(self.y, depth=2)
        self.loss = tf.losses.mean_squared_error(labels=onehot_labels, predictions=hidden)
        return tf.reduce_mean(self.loss)
    
    def gen_input(self, data_x, data_y=None):
        feed_dict = {}
        feed_dict[self.X] = data_x
        if data_y is not None:    
            self.y_truth = data_y
            feed_dict[self.y] = data_y
        return feed_dict
    
    def errors(self, y_pred, y_truth=None):
        if y_truth is None:
            y_truth = self.y
            not_equal_counts = tf.abs(y_pred - y_truth)
            return tf.reduce_mean(not_equal_counts)
        else:
            not_equal_counts = abs(y_pred - y_truth)
            return np.mean(not_equal_counts)


def sgd_optimization(datasets, learning_rate=0.10, n_epochs=50, draw_freq=10):
    train_set_x, train_set_y = datasets[0]
    test_set_x,  test_set_y  = datasets[1]
    classifier = LinearRegression(n_in=2, n_out=2)  # Classifier
    
    def get_model_train():
        with tf.name_scope('train'):
            y_pred, hidden = classifier.get_network()
            loss = classifier.get_loss(hidden)
            return y_pred, loss
    
    def get_model_test():
        with tf.name_scope('test'):
            y_pred, hidden = classifier.get_network()
            return y_pred
        
    train_output = get_model_train()  # y_pred, loss
    test_output = get_model_test()  # y_pred
    optimizer = tf.train.GradientDescentOptimizer(learning_rate).minimize(train_output[-1])
    
    init = tf.global_variables_initializer()
    sess = tf.Session()
    sess.run(init)
    
    def call_model(data_x, data_y=None, name=None):
        # generate data_y for placeholder while testing
        if data_y is None:
            data_y = np.zeros(data_x.shape[:-1])
            
        if name == 'test':
            ret = sess.run(  # return y_pred
                test_output,
                feed_dict=classifier.gen_input(data_x, data_y))
        else:  # name == 'train'
            _, ret = sess.run(  # return y_pred, loss
                [optimizer, train_output], 
                feed_dict=classifier.gen_input(data_x, data_y))
        return ret
    
    epoch = 0
    while epoch < n_epochs:
        # draw a figure every 'draw_freq' times
        if epoch % draw_freq == 0:
            # print(train_set_x, train_set_y)
            plot_decision_boundary(
                lambda x: call_model(x)[0], 
                train_set_x, train_set_y)
        
        # print error/cost per epoch
        train_pred, loss = call_model(
            train_set_x, train_set_y, 'train')
        train_error = classifier.errors(
            y_pred=train_pred, y_truth=train_set_y)
        
        test_pred = call_model(
            test_set_x,  test_set_y, 'test')
        test_error = classifier.errors(
            y_pred=test_pred, y_truth=test_set_y)

        print ("epoch is %d, train error %f, test error %f" % (
            epoch, train_error, test_error))
        epoch += 1

    # draw a figure at last        
    plot_decision_boundary(
        lambda x: call_model(x)[0], 
        train_set_x, train_set_y)
    sess.close()


def plot_decision_boundary(pred_func, train_set_x, train_set_y):
    # Draw figures as Matlab 
    x_min, x_max = train_set_x[:, 0].min() - .5, train_set_x[:, 0].max() + .5
    y_min, y_max = train_set_x[:, 1].min() - .5, train_set_x[:, 1].max() + .5
    h = 0.01
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))
    grid_input = np.c_[xx.ravel(), yy.ravel()].reshape([-1, 2])
    Z = pred_func(grid_input)
    plt.contourf(xx, yy, Z.reshape(xx.shape), cmap=plt.cm.Spectral)
    plt.scatter(train_set_x[:, 0], train_set_x[:, 1], c=train_set_y, cmap=plt.cm.Spectral)
    plt.show()

if __name__=="__main__":
    data = load_data('moons')
    sgd_optimization(data, learning_rate=0.1, n_epochs=200, draw_freq=25)

import os
# os.environ["CUDA_VISIBLE_DEVICES"] = ""
import numpy as np
import tensorflow as tf

# input
x = tf.placeholder(tf.int32, [None], name='x')
hello = tf.constant("Hello world!")

# network
y = x

# data
data_x = np.ones(4)

# run
with tf.Session() as sess:
    output = sess.run(
        [y, hello],
        feed_dict = {x: data_x}
    )
    x_output, hello_output = output
    print(x_output)
    print(hello_output)

a = tf.eye(3 ,name='a')
b = tf.ones(3, name='b')
c = tf.zeros([2,5], name='c')
d = tf.reshape(tf.range(6), [2,3], name='d')
e = tf.constant([1,2,3,4,5], name='e')
f = tf.constant(-1.0, shape=[2, 3], name='f')
var = [a,b,c,d,e,f]

sess = tf.Session()

output = sess.run(
    var,
    feed_dict = {x: np.ones(3)}
)

for k,v in zip(var, output):
    print(k)
    print(v)
    print()

sess.close()