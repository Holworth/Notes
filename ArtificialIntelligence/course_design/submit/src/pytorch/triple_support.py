# coding: utf-8 

import sys
import math
import json
import pickle
import numpy as np

def load_data(input):
    data={}
    with open(input, 'r') as file:
        input_data=file.read()
        data=json.loads(input_data)
    return data

def save_data(output, output_data):
    data=json.dumps(output_data)
    with open(output, 'w') as file:
        file.write(data)
    return

def k_fold_cv(model, k):
    errors=[]
    for i in range(k):
        #get model
        errors[i]=model.errorcnt()
    return sum(errors)/float(k)

def evalute_model(input):
    info = json.load(open(input, 'r'))  # original data json
    answers = json.load(open("predict_result.json", 'r'))  # your prediction

    n_info = len(info)
    n_answers = len(answers)

    prec, recall = 0., 0.
    post, negt, posf = 0, 0, 0

    n = n_answers

    if n_info == n_answers:
        print ("No missing or flowing problem")
    else:
        if n_info < n_answers:
            n = n_info
            print ("flowing problems")
        else :
            n = n_answers
            print ("missing problems")

    for i in np.arange(0, n):
        for r in info[i]["results"]:
            if (r in answers[i]["results"]):
                post = post + 1
            else :
                posf = posf + 1
        for r in answers[i]["results"]:
            if (r not in info[i]["results"]):
                negt = negt + 1

    recall = post * 1. / (post + posf)
    prec   = post * 1. / (post + negt)
    correct = post * 1. / (post + posf + negt)
    f1 = (prec * recall) * 2. / (prec + recall)

    print("recall:%.2lf prec:%.2lf correct:%.2lf F1:%.2lf" % (recall, prec, correct, f1))