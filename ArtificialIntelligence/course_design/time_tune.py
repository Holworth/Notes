import pstats 

p=pstats.Stats('1.stats')

p.print_stats()
p.print_callers()
p.print_callees()