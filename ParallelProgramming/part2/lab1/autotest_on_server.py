import os
import re

# scp -r  ../01 e0389042@xcna0:lab01

# e0389042@xcna0.comp.nus.edu.sg

# scp e0389042@xcna0.comp.nus.edu.sg:lab01/serverlog.log ./serverlog.log 

def run(cmd):
    return os.popen(cmd).read()

def test(size, thread):
    return run("./mm-shmem "+str(size)+" "+str(thread))

# print(test(1024,8))

thread=40
sizelist=[128,256,512,1024,2048]
# sizelist=[128]

resultdict={}

print(test(128,8))

for a in sizelist:
    resultdict[a]=[]
    for b in range(1,thread+1):
        res=test(a,b)
        print(res)
        time=(re.search(r"([0-9]+\.[0-9]+)",res).group(1))
        resultdict[a].append(float(time))

print(resultdict)
print()
print('|'.join(map(str,range(0,thread+1))))
print('|'.join('-' for i in range(thread+1)))

for key in resultdict:
    print(str(key)+'|'+'|'.join(map(str,resultdict[key])))


# def mdstyle_table(dict):
    # for key, value in dict:
