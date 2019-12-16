import requests
from bs4 import BeautifulSoup
import datetime
import random

html = requests.get('https://www.taiwanlottery.com.tw/info/instant/sale.aspx')
bs = BeautifulSoup(html.text, 'html.parser')


trs = bs.find_all('tr')
rows = list()
for tr in trs:
    content = [td.text for td in tr.find_all('td')]
    rows.append(content)
dummy_data = set()
for d in rows[0][:]:
    dummy_data.add(d)
for d in rows[2][:]:
    dummy_data.add(d)
dummy_data.add('頭獎兌獎分行奬金結構')
dummy_data.add('頭獎兌獎分行奬金結構增量發行')
trs = bs.find_all('tr')[1:]
rows = list()
for tr in trs:
    # td.text for td in tr.find_all('td') if td.text not in dummy_data
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
template_data = {
    "id": "string",
    "name": "string",
    "image_url": "string",
    "price": 0,
    "max_bonus": 0,
    "start_sell": "2019-12-09T09:32:41.349Z",
    "stop_sell": "2019-12-09T09:32:41.349Z",
    "last_redeem": "2019-12-09T09:32:41.349Z",
    "max_issue": 0,
    "max_top": 0,
    "sales_rate": "string",
    "unredeemed": 1
}


class Lottery():
    def __init__(self, data_dict):
        self.id = data_dict['id']
        self.name = data_dict['name']
        self.image_url = data_dict['image_url']
        self.price = data_dict['price']
        self.max_bonus = data_dict['max_bonus']
        self.start_sell = data_dict['start_sell']
        self.stop_sell = data_dict['stop_sell']
        self.last_redeem = data_dict['last_redeem']
        self.max_issue = data_dict['max_issue']
        self.max_top = data_dict['max_top']
        self.sales_rate = data_dict['sales_rate']
        self.unredeemed = data_dict['unredeemed']


paser_data = []
for num, data in enumerate(data_prettify):
    template_data['id'] = data[0].split('/')[1].strip()
    template_data['name'] = data[0].split('/')[0].strip()
    template_data['image_url'] = data[1]
    template_data['price'] = int(data[2].replace(',', ''))
    template_data['max_bonus'] = int(data[3].replace(',', ''))
    template_data['start_sell'] = datetime.datetime(int(data[4].split('/')[0]) + 1911, int(
        data[4].split('/')[1]), int(data[4].split('/')[2].replace("(註)", ""))).isoformat()+'.000Z'
    template_data['stop_sell'] = datetime.datetime(int(data[5].split(
        '/')[0]) + 1911, int(data[5].split('/')[1]), int(data[5].split('/')[2])).isoformat()+'.000Z'
    template_data['last_redeem'] = datetime.datetime(int(data[6].split(
        '/')[0]) + 1911, int(data[6].split('/')[1]), int(data[6].split('/')[2])).isoformat()+'.000Z'
    template_data['max_issue'] = int(data[7].replace(',', ''))
    template_data['max_top'] = int(data[9].replace(',', ''))
    template_data['sales_rate'] = data[8]
    template_data['unredeemed'] = int(
        data[10].replace(',', '')) if data[10] != '' else -1
    paser_data.append(Lottery(template_data))


class APIError(Exception):
    """An API Error Exception"""

    def __init__(self, status):
        self.status = status

    def __str__(self):
        return "APIError: {}".format(self.status)


for data in paser_data:
    resp = requests.patch(
        'http://localhost:3001/lottery-data/' + data.id, json=data.__dict__)
    if resp.status_code == 404:
        resp = requests.post(
            'http://localhost:3001/lottery-data', json=data.__dict__)
    if resp.status_code != 200:
        pass
