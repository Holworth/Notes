# coding=utf8
from copy import deepcopy
'''
This script evaluate the result of triple matching.
The evaluation metrics is defined as follows:
There are ns sentences, with `n` manually annotated triples which we regard as ground truth.
Some program predicted `n'` triples.
Then we compute a confusion matrix:
                    real_is_triple    real_not_triple
program_is triple         a                b
program_not_triple        c

The final metrics are:
recall = a / (a + c)
precision = a / (a + b)
'''

'''
input contains two lists:
    manual_result: [{'documentId':xxx, 'sentenceId':xxx, 'results':[[t, a, v], [t, a, v], ...]}, ...]
    model_result: same format
'''

def evaluate(manual_result, model_result):
    # First, align manual_result and model_result so that same sentence is a pair
    manual_ids = ['%s-%s'%('', r['sentenceId']) for r in manual_result]
    model_ids = ['%s-%s'%('', r['sentenceId']) for r in model_result]
    manual_ids_set = set(manual_ids)
    model_ids_set = set(model_ids)
    common_ids = list(manual_ids_set.intersection(model_ids_set))
    print 'model_sentence: {}, manual_sentence: {}, common_sentence: {}, model-manual: {}, manual-model: {}'.format(
        len(model_ids_set), len(manual_ids_set), len(common_ids), 
        len(model_ids_set.difference(manual_ids_set)), 
        len(manual_ids_set.difference(model_ids_set)))
    aligned_result = {}  # id: {..., mdl_triples:['1-1-1', ], man_triples:['', ]}
    for r in model_result:
        id = '%s-%s'%('', r['sentenceId'])
        if id not in common_ids:
            continue
        sentence_result = deepcopy(r)
        mdl_triples = sentence_result.pop('results')
        mdl_triples_str = ['{}-{}-{}'.format(*triple) for triple in mdl_triples] # for later comparing
        sentence_result['mdl_triples'] = mdl_triples_str
        aligned_result[id] = sentence_result

    for r in manual_result:
        id = '%s-%s'%('', r['sentenceId'])
        if id not in common_ids:
            continue
        man_triples_str = ['{}-{}-{}'.format(*triple) for triple in r['results']] # for later comparing
        aligned_result[id]['man_triples'] = man_triples_str

    for r in aligned_result:
        assert aligned_result[r].has_key('mdl_triples'), 'no model result for sentence %s'%id
        assert aligned_result[r].has_key('man_triples'), 'no manual result for sentence %s'%id

    # second compute the numbers `a, b, c` and metrics `precision` and `recall`
    a = 0
    b = 0
    c = 0
    A = []  # recording ids that contains true positive triples
    BC = []  # recording ids that contains false positive / false negative triples
    result_pairs = []
    for id in aligned_result:
        sentence = aligned_result[id]
        man_rs = set(sentence['man_triples'])
        mdl_rs = set(sentence['mdl_triples'])
        da, db, dc = 0, 0, 0
        da = len(man_rs.intersection(mdl_rs))
        db = len(mdl_rs.difference(man_rs))
        dc = len(man_rs.difference(mdl_rs))
        a += da
        b += db
        c += dc
        if da > 0:
            A.append(sentence)
        if dc > 0 or db > 0:
            BC.append(sentence)

    print 'a = {} b = {}\nc = {}'.format(a, b, c)
    if a == 0:
        precision = 0
        recall = 0
    else:
        precision = float(a)/(a+b)
        recall = float(a)/(a+c)
    print 'precision = {}, recall = {}'.format(precision, recall)
    # return sentences that contains A, B, C types
    return precision, recall, A, BC


def small_test():
        manual_result = [{'sentenceId':1, 'documentId': 1, 'results':[(1, 1, 2), (2, 1, 2), (3, 1, 1)]} ]
        model_result = [{'sentenceId':1, 'documentId': 1, 'results':[(1, 1, 1), (2, 1, 2)]}]
        p, r, A, BC = evaluate(manual_result, model_result)
        assert p == 0.5
        assert r == 1./3
        print 'pass small_test'

if __name__ == '__main__':
    import sys
    print sys.argv
    if len(sys.argv) == 2 and sys.argv[1] == 'test':
        small_test()
