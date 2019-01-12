# coding: utf-8 

P1=[7, 10]
P2=[6]

def atvp2_taged_map(data):
    result=[]
    for i in data:
        i['testset']=[]
        for t in i['times']:
            for a in i['attributes']:
                for v in i['values']:
                    triple=[t,a,v]
                    is_triple=0
                    for ii in i['results']:
                        if((ii[0]==triple[0]) and(ii[1]==triple[1]) and (ii[2]==triple[2])):
                            is_triple=1
                            break
                    #now gen results
                    is_considered=0
                    input_vecs=[]
                    debug_vec=[]
                    for iii in range(len(i['indexes'])):
                        #[is_picked, T, A, V, P1, P2]                        
                        input_vecs.append([])
                        input_vec=[]

                        if(iii in triple):
                            input_vec.append(1)
                        else:
                            input_vec.append(0)

                        if(iii in i['times']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('T')
                        else:
                            input_vec.append(0)

                        if(iii in i['attributes']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('A')
                        else:
                            input_vec.append(0)

                        if(iii in i['values']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('V')
                        else:
                            input_vec.append(0)

                        if(i['indexes'][iii] in P1):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('P1')
                        else:
                            input_vec.append(0)

                        if(i['indexes'][iii] in P2):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('P2')
                        else:
                            input_vec.append(0)

                        input_vecs.append(input_vec)

                    print(debug_vec)     
                    if(is_considered):
                        i['testset'].append({'is_triple':is_triple, 'input_vecs':input_vecs, 'debug_vec':debug_vec, 'tav':[t,a,v]})
        result.append(i)
    return result

def atvp2_untaged_map(data):
    result=[]
    for i in data:
        i['testset']=[]
        for t in i['times']:
            for a in i['attributes']:
                for v in i['values']:
                    triple=[t,a,v]

                    #now gen results
                    is_considered=0
                    input_vecs=[]
                    debug_vec=[]
                    for iii in range(len(i['indexes'])):
                        #[is_picked, T, A, V, P1, P2]                        
                        input_vecs.append([])
                        input_vec=[]

                        if(iii in triple):
                            input_vec.append(1)
                        else:
                            input_vec.append(0)

                        if(iii in i['times']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('T')
                        else:
                            input_vec.append(0)

                        if(iii in i['attributes']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('A')
                        else:
                            input_vec.append(0)

                        if(iii in i['values']):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('V')
                        else:
                            input_vec.append(0)

                        if(i['indexes'][iii] in P1):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('P1')
                        else:
                            input_vec.append(0)

                        if(i['indexes'][iii] in P2):
                            input_vec.append(1)
                            is_considered=1
                            debug_vec.append('P2')
                        else:
                            input_vec.append(0)

                        input_vecs.append(input_vec)

                    print(debug_vec)     
                    if(is_considered):
                        i['testset'].append({'input_vecs':input_vecs, 'debug_vec':debug_vec, 'tav':[t,a,v]})
        result.append(i)
    return result
