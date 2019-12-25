import csv
import requests
import datetime
data_temp = []


class APIError(Exception):
    """An API Error Exception"""

    def __init__(self, status):
        self.status = status

    def __str__(self):
        return "APIError: {}".format(self.status)


with open('trustee-test.csv', encoding="utf8", newline='') as csvfile:
    # 讀取 CSV 檔案內容
    rows = csv.reader(csvfile)

    # 以迴圈輸出每一列
    for row in rows:
        data_temp.append(row)


json_template = {
    "name": "string",
    "card_code": "string",
    "bank": "string",
    "store": "string",
    "identity": "string",
    "birthday": "2019-12-08T14:03:38.848Z",
    "hex": "string",
    "phone": "string",
    "consignee_1": "string",
    "consignee_2": "string"
}

for trustee in data_temp:
    json_template['name'] = trustee[0]
    json_template['card_code'] = trustee[1]
    json_template['consignee_1'] = trustee[6]
    json_template['consignee_2'] = trustee[7]
    json_template['hex'] = trustee[5]
    json_template['identity'] = trustee[4]
    json_template['phone'] = trustee[3]
    json_template['birthday'] = datetime.datetime(int(trustee[2].split('.')[0]), int(
        trustee[2].split('.')[1]), int(trustee[2].split('.')[2])).isoformat()+'.000Z'
    json_template['store'] = trustee[9]
    json_template['bank'] = trustee[8]
    resp = requests.post('http://localhost:3001/trustees', json=json_template)
    if resp.status_code != 200:
        raise APIError('POST /trustees {}'.format(resp.status_code))
    print('Created trustees. ID: {}'.format(resp.json()["id"]))
