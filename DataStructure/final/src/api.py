import requests
import urllib
import json

def resolveData(date_str,from_str,to_str):
    #蜜汁验证码
    #出现机制尚不明确......
    #出现了这就用不了
    #出现了就直接去携程查吧.....
    # url = 'https: // kyfw.12306.cn/otn/leftTicketPrice/query?leftTicketDTO.train_date = 2018-07-11 & leftTicketDTO.from_station = BJP & leftTicketDTO.to_station = SHH & leftTicketDTO.ticket_type = 1 & randCode = '+randcode
    # randcode=input()
    #查询链接
    url='https://kyfw.12306.cn/otn/leftTicket/query?leftTicketDTO.train_date='+date_str+'&leftTicketDTO.from_station='+from_str+'&leftTicketDTO.to_station='+to_str+'&purpose_codes=ADULT'
    # url = 'https: // kyfw.12306.cn/otn/leftTicketPrice/query?leftTicketDTO.train_date = 2018-07-11 & leftTicketDTO.from_station = BJP & leftTicketDTO.to_station = SHH & leftTicketDTO.ticket_type = 1 & randCode = '+randcode
    #获取数据
    while 1:
        try:
            data = getData(url)
            lists = json.loads(data)["data"]["result"]
            break
        except:
            continue#获取失败则重新获取
    for item in lists:#打印result信息
        print(item)
    return lists

date_str=input()
from_str=input()
to_str=input()
resolveData(date_str,from_str,to_str)

# 测试数据: 2018-07-13 BJP SHH

# si=item.spilt(',')之类的懒得写了
# 没提取到票价,所以没接到主程序里

# 之前的查询接口
# 'https://kyfw.12306.cn/otn/leftTicket/query?leftTicketDTO.train_date=2018-09-01&leftTicketDTO.from_station=XAY&leftTicketDTO.to_station=GZG&purpose_codes=ADULT'

# 需要票价的话直接用这个+正则匹配更快我懒得改了....
# http: // www.tieyou.com/daigou/beijing-shanghai.html?date = 2018-07-13 & utm_source = baidu_search
