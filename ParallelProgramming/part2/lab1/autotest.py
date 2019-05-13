import os
import re

def run(cmd):
    return os.popen(cmd).read()

def test(size, thread):
    return run("./mm-shmem "+str(size)+" "+str(thread))

# print(test(1024,8))

sizelist=[128,256,512,1024]
# sizelist=[128]

resultdict={}

for a in sizelist:
    resultdict[a]=[]
    for b in range(1,9):
        res=test(a,b)
        print(res)
        time=(re.search(r"([0-9]+\.[0-9]+)",res).group(1))
        resultdict[a].append(float(time))

print(resultdict)
print()
print('|'.join(map(str,range(0,9))))
print('-|-|-|-|-|-|-|-|-')

for key in resultdict:
    print(str(key)+'|'+'|'.join(map(str,resultdict[key])))


# def mdstyle_table(dict):
    # for key, value in dict:
