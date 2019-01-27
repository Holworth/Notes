# -*- coding:utf-8 -*-
# Author:LFZ
import json
Cut_List = [7, 26] # ，；
Del_List = [14,19, 21,  22,  32, 36,  40,  50,  61,  88,  90,  97, 244, 270, 915, 360, 82, 335,408, 29, 546, 532,545,227,789,102]
#          [占,较,比例,增加,增长,增幅,减少,下降,上升,占比,同期,同比,相比,增长率,占据,贡献,毛利率,左右,低于,比重,大于,归还,高于,至,回升,均]
json_file = './assignment_test_data_word_segment.json'
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
    
for sentence in new_sentence:
    need_A = need_T = cole_T = []
    result = []
    for i in range(len(sentence['keys'])):
        if sentence['keys'][i][1] == 'D':
            cur = i - 1
            while sentence['keys'][cur][1] != 'C':
                sentence['keys'][cur][1] = 'D'
                cur -= 1
            cur = i + 1
            while sentence['keys'][cur][1] != 'C':
                sentence['keys'][cur][1] = 'D'
                cur += 1
    for i in range(len(sentence['keys'])-1, -1, -1):#逆序遍历
        if sentence['keys'][i][1] == 'C':
            if len(need_A) < 2:
                need_A = []
            if len(cole_T) != 0 and len(need_T) != 0:
                if len(cole_T) == 1:
                    for nT in need_T:
                        for tri in nT:
                            tri[0] = cole_T[0]
                            result.append(tri)
                else:
                    for nT in need_T:
                        if len(nT) <= len(cole_T):
                            for cur in range(len(nT)):
                                nT[cur][0] = cole_T[cur]
                                result.append(nT[cur])
                need_T = []
            cole_T = []
        if sentence['keys'][i][1] == 'V':
            need_A.append([-1, -1, sentence['keys'][i][0]])
        if sentence['keys'][i][1] == 'A':
            for tmp in range(len(need_A)):
                need_A[tmp][1] = sentence['keys'][i][0]
            need_T.append(need_A)
            need_A = []
        if sentence['keys'][i][1] == 'T':
            cole_T.append(sentence['keys'][i][0])
    sentence['results'] = result
output = './result.json'
json.dump(new_sentence, open(output , 'w'))
