import os
import random
import psycopg2
import psycopg2.extras
import sys

# need this to prevent UnicodeDecodeError
reload(sys)
sys.setdefaultencoding('utf8')


from flask import Flask, render_template, request
app = Flask(__name__)

def connectToDB():
  connectionString = 'dbname=helix user=helix password=helix123 host=localhost'
  print connectionString
  try:
    return psycopg2.connect(connectionString)
  except:
    print("Can't connect to database")


@app.route('/', methods=['GET', 'POST'])
def mainIndex():
  
    maxLevels = 30
    
    return render_template('index.html', levels=maxLevels)

# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
