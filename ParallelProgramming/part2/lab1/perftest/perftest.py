import os
import re

for i in range(10, 30):
    os.popen("perf stat -e L1-dcache-load-misses -e L1-icache-load-misses -e cache-misses -e cache-references - ./testmem_size "+str(i)+" >>np.log 2>&1")

#  L1-dcache-load-misses

#  L1-icache-load-misses 

# cache-misses

# cache-references 


