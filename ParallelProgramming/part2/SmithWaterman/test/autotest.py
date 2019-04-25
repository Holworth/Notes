import os
import re
import json

def run(cmd):
    return os.popen(cmd).read()

def test(tgt, input1, input2):
    try:
        print(r"[run] ./"+tgt+" "+input1+" "+input2+" BLOSUM62 10 5")
        resstr = run("./"+tgt+" "+input1+" "+input2+" BLOSUM62 10 5")
        print(resstr)
        # Running Time: 607
        return int(re.search(r'Running Time: (\d+)',resstr).group(1))
    except:
        return -1 # error occured

from random import randint

def rand_alpha():
    case = randint(0, 3)
    if(case==0):
        return 'A'
    if(case==1):
        return 'C'
    if(case==2):
        return 'T'
    if(case==3):
        return 'G'


def rand_str(length):
    str=''
    for i in range(length):
        str=str+rand_alpha()
    return str

def make_input_file(length, name):
    output=r'''>gi|2829193|gb|AF043946.1| ... ignore all this ...
'''
    output=output+rand_str(length)
    with open(name, 'w') as f:
        f.write(output)


result_x10_parallel={}
result_x10_parallel_diagonal={}
result_x10_basic={}
result_baseline={}
result_omp={}

# test main

length1 = range(10, 1000, 100)
length2 = range(10, 1000, 100)

# length1.append(2000)
# length2.append(2000)

for a in length1:
    result_x10_parallel[a]=[]
    result_x10_parallel_diagonal[a]=[]
    result_x10_basic[a]=[]
    result_baseline[a]=[]
    result_omp[a]=[]
    for b in length2:
        print("[info] now testing: %d, %d"%(a,b))
        make_input_file(a, 'in1.temp')
        make_input_file(b, 'in2.temp')
        result_x10_parallel[a].append(test('x10_parallel','in1.temp','in2.temp'))
        result_x10_parallel_diagonal[a].append(test('x10_parallel_diagonal','in1.temp','in2.temp'))
        result_x10_basic[a].append(test('x10_basic','in1.temp','in2.temp'))
        print("[info] x10 finished")
        result_baseline[a].append(test('baseline','in1.temp','in2.temp'))
        result_omp[a].append(test('omp','in1.temp','in2.temp'))
        print("[info] cpp finished")

result={
    'result_x10_parallel':result_x10_parallel,
    'result_x10_parallel_diagonal':result_x10_parallel_diagonal,
    'result_x10_basic':result_x10_basic,
    'result_baseline':result_baseline,
    'result_omp':result_omp
}


with open('result.json','w') as f:
    json.dump(result, f)
print("Test finished.")