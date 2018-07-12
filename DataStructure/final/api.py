import requests
import urllib
import json

"""获取data"""
def getData(url):
    data = ''
    while 1:
        try:
            headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0'}
            # 关键代码：###############################################
            req = urllib.request.Request(url=url, headers=headers)
            data = urllib.request.urlopen(req).read().decode('utf-8')
            ###########################################################
            if data.startswith(u'\ufeff'):
                data = data.encode('utf8')[3:].decode('utf-8')
            break
        except:
            continue
    return data

"""获取result"""
def resolveData():
    #查询链接
    url = 'https://kyfw.12306.cn/otn/leftTicket/queryO?leftTicketDTO.train_date=2018-09-01&leftTicketDTO.from_station=XAY&leftTicketDTO.to_station=GZG&purpose_codes=ADULT'
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

resolveData()

# https: // kyfw.12306.cn/otn/leftTicketPrice/query?leftTicketDTO.train_date = 2018-07-11 & leftTicketDTO.from_station = BJP & leftTicketDTO.to_station = SHH & leftTicketDTO.ticket_type = 1 & randCode = sg2s

# http: // www.tieyou.com/daigou/beijing-shanghai.html?date = 2018-07-13 & utm_source = baidu_search
