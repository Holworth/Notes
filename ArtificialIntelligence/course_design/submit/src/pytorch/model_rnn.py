import torch.nn as nn
# coding: utf-8
# Author: Wang Huaqiang
# Ref: https://www.pytorchtutorial.com/pytorch-sequence-model-and-lstm-networks/ 

import torch
import torch.autograd as autograd # torch中自动计算梯度模块
import torch.nn as nn             # 神经网络模块
import torch.nn.functional as F   # 神经网络模块中的常用功能 
import torch.optim as optim       # 模型优化器模块
import os

import atvp_map
import triple_support

PATH='triple.model'
INPUT_DIM=6
# HIDDEN_DIM=5
OUTPUT_DIM=2

#input=[is_picked, is_A, is_T, is_V, is_P1, is_P2]


class RNN(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(RNN, self).__init__()

        self.hidden_size = hidden_size

        self.i2h = nn.Linear(input_size + hidden_size, hidden_size)
        self.i2o = nn.Linear(input_size + hidden_size, output_size)
        self.softmax = nn.LogSoftmax(dim=1)

    def forward(self, input, hidden):
        combined = torch.cat((input, self.hidden), 1)
        hidden = self.i2h(combined)
        output = self.i2o(combined)
        output = self.softmax(output)
        return output, hidden

    def init_hidden(self):
        return torch.zeros(1, self.hidden_size)

# Usage:
# rnn = RNN(n_letters, n_hidden, n_categories)

# def get_next_input(data_list):
#     for i in data_list:
#         for ii in i['test_set']:
#             yield ii

class RNN(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(RNN, self).__init__()

        self.hidden_size = hidden_size

        self.i2h = nn.Linear(input_size + hidden_size, hidden_size)
        self.i2o = nn.Linear(input_size + hidden_size, output_size)
        self.softmax = nn.Softmax(dim=1)

    def forward(self, input, hidden):
        # print(input)
        # print(hidden)
        combined = torch.cat((input, hidden), 1)
        hidden = self.i2h(combined)
        output = self.i2o(combined)
        output = self.softmax(output)
        return output, hidden

    def init_hidden(self):
        return torch.zeros(1, self.hidden_size)

def train(input, output, model, hidden_dim, epochs):
    
    jsonstr=triple_support.load_data(input)
    data_list=atvp_map.atvp2_taged_map(jsonstr)

    torch.manual_seed(1)

    loss_function = nn.BCELoss()
    # optimizer = NULL #Manually designed
    learning_rate = 0.005

    model= RNN(6, hidden_dim, 2)

    print("Now training.")
    
    for epoch in range(epochs): # 我们要训练300次，可以根据任务量的大小酌情修改次数。
        print('epoch:',epoch)
        now_at=0
        cases=0
        right=0
        for sentence in data_list:
            now_at=now_at+1
            for each_case in sentence['testset']:
                model.zero_grad()
                hidden = model.init_hidden()
                is_triple, sentence_in = each_case['is_triple'], each_case['input_vecs']

                tags=[float(is_triple), float(not is_triple)]

                # tag_scores = model(torch.tensor(sentence_in, dtype=torch.float).view(len(sentence_in), 1, -1))

                sentence_in=torch.tensor(sentence_in, dtype=torch.float).view(len(sentence_in), 1, -1)
                # print(sentence_in.size())
                for i in range(sentence_in.size()[0]):
                    tag_scores, hidden = model(sentence_in[i], hidden)

                # print(tag_scores)

                if tag_scores[0][1]<tag_scores[0][0]:
                    if(is_triple):
                        right=right+1
                else:
                    if(not is_triple):
                        right=right+1

                cases=cases+1
                # print(tag_scores,  torch.autograd.Variable(torch.tensor(tags).view(1,-1)))
                # loss=loss_function(tag_scores, torch.tensor(is_triple).view(1, -1))
                loss = loss_function(tag_scores,torch.autograd.Variable(torch.tensor(tags).view(1,-1)))
                loss.backward()

                for p in model.parameters():
                    p.data.add_(-learning_rate, p.grad.data)
    
            # if((now_at%100)==0):
            print(now_at)
            print('cases', cases,'right', right,'acc_rate', right/cases)
        torch.save(model, str(epoch)+PATH)

    # # 来检验下模型训练的结果
    # inputs = parse_sentence_atvp2(training_data[0][0])
    # tag_scores = model(inputs)
    # print(tag_scores)
    # print(training_data[0][1])

    
    # 保存模型到指定目录
    torch.save(model, PATH)
    print('Train finished.')


def predict(input, output):
    #加载模型
    model = torch.load(PATH)

    #加载数据

    print('Now loading data set.')
    jsonstr=triple_support.load_data(input)
    predict_data=atvp_map.atvp2_untaged_map(jsonstr)

    counter=0

    print('Now predicting.')
    result=[]
    for sentence in predict_data:
        print('current sentence:', counter)
        result.append({})
        result[counter]['sentenceId']=sentence['sentenceId']
        result[counter]['results']=[]
        for each_case in sentence['testset']: 
            # 清除网络先前的梯度值，梯度值是Pytorch的变量才有的数据，Pytorch张量没有
            model.zero_grad()
            # 重新初始化隐藏层数据，避免受之前运行代码的干扰
            model.hidden = model.init_hidden()
            # 准备网络可以接受的的输入数据
            sentence_in = each_case['input_vecs']
            # 运行模型，直接将模型名作为方法名看待即可
            # tag_scores = model(sentence_in)

            # print(sentence_in)
            tag_scores = model(torch.tensor(sentence_in, dtype=torch.float).view(len(sentence_in), 1, -1).cuda())

            # result.append(tag_scores)
            # print(tag_scores)
            if(tag_scores[-1][0]<tag_scores[-1][1]):
                result[counter]['results'].append(each_case['tav'])
        counter=counter+1
    
    triple_support.save_data('predict_result.json', result)

    return result
