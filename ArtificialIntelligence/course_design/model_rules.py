# -*- coding:utf-8 -*-
# Author:LFZ
import json

def predict(input, output):

    Cut_List = [7, 26, 10] # ，；。
    Del_List = [14,19, 21,  22,  32, 36,  40,  88,  97, 244,  270,  915, 360,  82,    335,  408, 29,  546, 532,  545,227,789, 102]
    #          [占,较,比例,增加,增长,增幅,减少,占比,同比,相比,增长率,占据，贡献，毛利率，左右，低于，比重，大于, 归还，高于,至。回升,均]
    #包含这些词语的句子一般不会包含三元组中的数据
    # json_file = './assignment_training_data_word_segment.json'
    json_file=input
    sentence_list = json.load(open(json_file , 'r'))
    def Sort_Key(elem):
        return elem[0]
    
    new_sentence = []
    for sentence in sentence_list:#去掉数据中没用的部分，只留下ID和关键词
        keys = []
        for i in sentence['times']:
            keys.append([i, 'T'])
        for i in sentence['values']:
            keys.append([i, 'V'])
        for i in sentence['attributes']:
            keys.append([i, 'A'])
        for i in range(len(sentence['indexes'])):
            if sentence['indexes'][i] in Cut_List:
                keys.append([i, 'C'])
            if sentence['indexes'][i] in Del_List:
                keys.append([i, 'D'])
        keys.append([len(sentence['indexes'])+1, 'C'])
        keys.append([-1, 'C'])
        keys.sort(key = Sort_Key)
        app = {'sentenceId':sentence['sentenceId'], 'keys':keys}
        new_sentence.append(app)
        
    for sentence in new_sentence:#完了删掉  对一个句子的处理
        need_V = need_A = need_T = cole_T = []
    #	有了Value，需要Attribute
    #	有了V和A，需要Time
    #	Time的集合(collection)
        result = []
    #	把含有D关键词的句子中的关键词全部标记为D
        for i in range(len(sentence['keys'])):
            if sentence['keys'][i][1] == 'D':
                cur = i - 1
                while sentence['keys'][cur][1] != 'C':# or sentence['keys'][cur][1] == 'A':很重要，带A的不能删掉！！！！
                    sentence['keys'][cur][1] = 'D'
                    cur -= 1
                cur = i + 1
                while sentence['keys'][cur][1] != 'C':# or sentence['keys'][cur][1] == 'A':
                    sentence['keys'][cur][1] = 'D'
                    cur += 1
        for i in range(len(sentence['keys'])-1, -1, -1):		#逆序遍历
            if sentence['keys'][i][1] == 'V':
                #if len(need_V) == 0:
                need_A.append([-1, -1, sentence['keys'][i][0]])
                #else:
                #   for tmp in range(len(need_A)):
                #       need_V[tmp][2] = sentence['keys'][i][0]
                #   need_T.append(need_V)
                #   need_V = []
            if sentence['keys'][i][1] == 'A':#遇到一个Attribute就与全部的Value组合
                #if len(need_A) == 0:
                #   need_V.append([-1, sentence['keys'][i][0], -1])
                #else:
                for tmp in range(len(need_A)):
                    need_A[tmp][1] = sentence['keys'][i][0]
                need_T.append(need_A)
                need_A = []
            if sentence['keys'][i][1] == 'T':
                cole_T.append(sentence['keys'][i][0])
            if sentence['keys'][i][1] == 'C':					#遇到一个分割符号
                if len(need_A) < 2:								#如果一句话里只有一个value，一般不是三元组的数据，所以删掉
                    need_A = []
                if len(cole_T) != 0 and len(need_T) != 0:		#三个元素同时存在就组合成Result
                    if len(cole_T) == 1:						#如果只有一个时间，那么一个时间对应多个Value
                        for nT in need_T:
                            for tri in nT:
                                tri[0] = cole_T[0]
                                result.append(tri)
                    else:
                        for nT in need_T:#为什么这个if没有发挥作用？
                            #if len(nT) == 1 and len(cole_T) > 1:
                            #   for cur in range(len(cole_T)):
                            #      nT[0][0] = cole_T[cur]
                            #     result.append(nT[0])
                            #else:
                            if len(nT) <= len(cole_T):
                                for cur in range(len(nT)):
                                    nT[cur][0] = cole_T[cur]
                                    result.append(nT[cur])
                            #else:
                            #    for cur in range(len(cole_T)):
                            #        nT[cur+len(nT)-len(cole_T)][0] = cole_T[cur]
                            #        result.append(nT[cur+len(nT)-len(cole_T)])
                    need_T = []
                    cole_T = []
                    #need_T = cole_T = []为什么不行？
                #cole_T = []#为什么这一行不能删掉？
                else:
                    if len(need_A) == 0:
                        cole_T = []
        sentence['results'] = result
    json.dump(new_sentence, open(output , 'w'))
    