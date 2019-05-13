import json
import argparse
import pickle

import triple_support
import atvp_map
# import triple_model
import model_lstm
import model_rnn
import model_rules

parser = argparse.ArgumentParser(description="Triple classifier by William Wang.")
parser.add_argument("-i", "--input", help="set input file's name", default='./assignment_training_data_word_segment.json')
parser.add_argument("-p","--predict", help="do predict with exist model", action="store_true")
parser.add_argument("-t","--train", help="train and save model", action="store_true")
parser.add_argument("-m", "--method", help="network build method, atvp-rnn in default", default="rules")
parser.add_argument("-o", "--output", help="set output file's name", default='predict_result.json')
parser.add_argument("-e", "--epochs", help="set epohs for training", type=int, default=300)
parser.add_argument("-hd", "--hidden_dim", help="hidden layer dimension", type=int, default=5)
parser.add_argument("-eva", "--evalute", help="evalute result", action="store_true")
# parser.parse_args()

# def train(input, output, model, hidden_dim):
#     pass

# def predict(input, output):
#     pass

train_dict={'lstm':model_lstm.train, 'rnn':model_rnn.train}
predict_dict={'rules': model_rules.predict, 'lstm':model_lstm.predict, 'rnn':model_rnn.predict}

if __name__=='__main__':
    print('Triple classifier by William Wang.')
    print('You can use python3 triple_main.py -h to get help.')
    print('Args: ', parser.parse_args())
    args=parser.parse_args()
    
    if(args.train):
        # Load training data in Python:
        sentence_list_fname = args.input
        sentence_list = json.load(open(sentence_list_fname , 'r'))

        # Load vocabulary in Python:
        voc_dict_fname = './voc-d.pkl'
        voc_dict = pickle.load(open(voc_dict_fname, 'rb'))
        idx2word, word2idx = voc_dict['idx2word'], voc_dict['word2idx'] 
        # idx2word[index] is a word
        # word2idx[word] is an index
        train_dict[args.method](args.input, args.output, args.method, args.hidden_dim, args.epochs)

    if(args.predict):
        result=predict_dict[args.method](args.input, args.output)
    
    if(args.evalute):
        triple_support.evalute_model(args.input)


