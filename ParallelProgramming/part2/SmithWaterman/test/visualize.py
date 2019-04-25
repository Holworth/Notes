import json
import numpy as np
import matplotlib.pyplot as plt

result={}

with open('result.json','r') as f:
   result=json.load(f)

# result={
#     'result_x10_parallel':result_x10_parallel,
#     'result_x10_parallel_diagonal':result_x10_parallel_diagonal,
#     'result_x10_basic':result_x10_basic,
#     'result_baseline':result_baseline,
#     'result_omp':result_omp
# }

def visualize(result_name):
# print result
    print(result_name)
    x=range(10,1000,100)
    y=[]
    cnt=0
    for i in x:
        print(result[result_name][str(i)])
        y.append(result[result_name][str(i)][cnt])
        cnt+=1
# print graph
    plt.figure()
    plt.plot(x,y)
    plt.xlabel("length")
    plt.ylabel("time(ms)")
    plt.title(result_name)
    plt.savefig(result_name+'.png')
    print("--------------------------------------------")

visualize('result_x10_parallel')
visualize('result_x10_parallel_diagonal')
visualize('result_x10_basic')
visualize('result_baseline')
visualize('result_omp')

print("\n------------------FINISHED------------------")




