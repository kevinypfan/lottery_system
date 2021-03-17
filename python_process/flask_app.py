from flask import Flask
from scratch_spider import spider_scratch
app = Flask(__name__)

@app.route('/ping')
def hello():
    return "here!"

@app.route('/scratch-data')
def scratch_data():
    return {"data": spider_scratch()}

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8300, debug=True, threaded=True)