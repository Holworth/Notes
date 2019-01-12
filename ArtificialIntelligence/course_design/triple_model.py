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

def get_next_input(data_list):
    for i in data_list:
        for ii in i['test_set']:
            yield ii

class LSTMTagger(nn.Module):

    def __init__(self, input_dim, hidden_dim, output_dim):
        super(LSTMTagger, self).__init__()
        self.hidden_dim = hidden_dim
        # self.word_embeddings = nn.Embedding(vocab_size, embedding_dim)
        self.lstm = nn.LSTM(input_dim, hidden_dim)
        self.hidden2tag = nn.Linear(hidden_dim, output_dim)
        self.hidden = self.init_hidden()#?

    def init_hidden(self):
        return (autograd.Variable(torch.zeros(1, 1, self.hidden_dim)),
                autograd.Variable(torch.zeros(1, 1, self.hidden_dim)))

    def forward(self, sentence):
        # embeds = self.word_embeddings(sentence)
        # lstm_out, self.hidden = self.lstm(embeds.view(len(sentence), 1, -1), self.hidden)
        # self.parsed_sentence=parse_sentence_atvp2(sentence)
        lstm_out, self.hidden = self.lstm(self.sentence, self.hidden)
        tag_space = self.hidden2tag(lstm_out.view(len(self.parsed_sentence), -1))
        tag_scores = F.log_softmax(tag_space)
        return tag_scores


# def prepare_sequence(seq, to_ix):
#     idxs = [to_ix[w] for w in seq]
#     tensor = torch.LongTensor(idxs)
#     return autograd.Variable(tensor)


def train(input, output, model, hidden_dim, epochs):
    
    jsonstr=triple_support.load_data(input)
    data_list=atvp_map.atvp2_taged_map(jsonstr)

    torch.manual_seed(1)

    model = LSTMTagger(INPUT_DIM, hidden_dim, OUTPUT_DIM)
    loss_function = nn.NLLLoss()
    optimizer = optim.SGD(model.parameters(), lr=0.1)
    
    # inputs = prepare_sequence(training_data[0][0], word_to_ix)
    # tag_scores = model(inputs)
    # print(training_data[0][0])
    # print(inputs)
    # print(tag_scores)
    
    
    for epoch in range(epochs): # 我们要训练300次，可以根据任务量的大小酌情修改次数。
        for sentence in data_list:
            for each_case in sentence['testset']:
                # 清除网络先前的梯度值，梯度值是Pytorch的变量才有的数据，Pytorch张量没有
                model.zero_grad()
                # 重新初始化隐藏层数据，避免受之前运行代码的干扰
                model.hidden = model.init_hidden()
                # 准备网络可以接受的的输入数据和真实标签数据，这是一个监督式学习
                is_triple, sentence_in = each_case['is_triple'], each_case['input_vecs']

                tags=[int(is_triple), int(not is_triple)]

                # 运行我们的模型，直接将模型名作为方法名看待即可
                tag_scores = model(sentence_in)

                # 计算损失，反向传递梯度及更新模型参数
                loss = loss_function(tag_scores, tags)
                loss.backward()
                optimizer.step()
    
    # # 来检验下模型训练的结果
    # inputs = parse_sentence_atvp2(training_data[0][0])
    # tag_scores = model(inputs)
    # print(tag_scores)
    # print(training_data[0][1])
    
    # 保存模型到指定目录
    torch.save(model, PATH)


def predict(input, output):
    #加载模型
    model = torch.load(PATH)

    #加载数据
    jsonstr=triple_support.load_data(input)
    predict_data=atvp_map.atvp2_untaged_map(jsonstr)

    counter=0

    result=[]
    for sentence in predict_data:
        print('current sentence:', counter)
        result.append({})
        result[counter]['sentenceId']=sentence['sentenceId']
        result[counter]['results']=[]
        for each_case in sentence['test_set']: 
            # 清除网络先前的梯度值，梯度值是Pytorch的变量才有的数据，Pytorch张量没有
            model.zero_grad()
            # 重新初始化隐藏层数据，避免受之前运行代码的干扰
            model.hidden = model.init_hidden()
            # 准备网络可以接受的的输入数据
            sentence_in = each_case['input_vecs']
            # 运行模型，直接将模型名作为方法名看待即可
            tag_scores = model(sentence_in)
            # result.append(tag_scores)
            if(tag_scores[0]>tag_scores[1]):
                result[counter]['results'].append(each_case['tav'])
        counter=counter+1

    return result