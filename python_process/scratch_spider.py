import requests
from bs4 import BeautifulSoup
import datetime
import random



def spider_scratch():
    html = requests.get('https://www.taiwanlottery.com.tw/info/instant/sale.aspx')
    bs = BeautifulSoup(html.text, 'html.parser')
    trs = bs.find_all('tr')
    rows = list()
    for tr in trs:
        content = [td.text for td in tr.find_all('td')]
        rows.append(content)

    dummy_data = set()

    for i in range(0, len(rows), 2):
        for d in rows[i][:]:
            dummy_data.add(d)

    trs = bs.find_all('tr')[1:]
    rows = list()
    for tr in trs:
        content = []
        for td in tr.find_all('td'):
            if td.text not in dummy_data:
                content.append(td.text)
            if td.find('img'):
                content.append(td.find('img')['src'])
        if len(content) != 0:
            rows.append(content)

    data_prettify = []
    for num, row in enumerate(rows):
        if num % 2 == 1:
            data_prettify.append(rows[num-1] + rows[num])
    data_prettify[random.randint(0, len(data_prettify))]



    paser_data = []
    for num, data in enumerate(data_prettify):
        template_data = dict()
        template_data['idScratchItems'] = int(data[0].split('/')[1].strip())
        template_data['name'] = data[0].split('/')[0].strip()
        template_data['imageUrl'] = data[1]
        template_data['price'] = int(data[2].replace(',', ''))
        template_data['maxBonus'] = int(data[3].replace(',', ''))
        template_data['startSellDay'] = str(int(data[4].split('/')[0]) + 1911) + '-' + data[4].split('/')[1].zfill(2) + '-' + data[4].split('/')[2].replace("(註)", "").zfill(2)
        template_data['stopSellDay'] = str(int(data[5].split('/')[0]) + 1911) + '-' + data[5].split('/')[1].zfill(2) + '-' + data[5].split('/')[2].zfill(2)
        template_data['lastRedeemDay'] = str(int(data[6].split('/')[0]) + 1911) + '-' + data[6].split('/')[1].zfill(2) + '-' + data[6].split('/')[2].zfill(2)
        template_data['maxIssue'] = int(data[7].replace(',', ''))
        template_data['maxTop'] = int(data[9].replace(',', ''))
        template_data['salesRate'] = float(data[8][0: -1]) if len(data[8][0: -1]) > 0 else None
        template_data['unredeemed'] = int(data[10].replace(',', '')) if data[10] != '' else -1
        paser_data.append(template_data)

    return paser_data
