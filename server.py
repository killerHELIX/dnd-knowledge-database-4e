import os
import random
import psycopg2
import psycopg2.extras
import sys
from flask_socketio import SocketIO, emit
from flask import Flask, render_template, request
app = Flask(__name__)

# need this to prevent UnicodeDecodeError
reload(sys)
sys.setdefaultencoding('utf8')

socketio = SocketIO(app)

def connectToDB():
  connectionString = 'dbname=dungeons user=postgres password=postgres host=localhost'
  print connectionString
  try:
    return psycopg2.connect(connectionString)
  except:
    print("Can't connect to database")

conn = connectToDB()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

@socketio.on('getInfo')
def getInfo(Level, Race, Class):
  print("Entered getInfo on SERVER.PY")
  
  # get class info
  query = "SELECT * FROM class WHERE name = %s;"
  mog = cur.mogrify(query, [Class])
  print(mog)
  
  cur.execute(mog)
  classInfo = cur.fetchall()
  print(classInfo)
  
  for Class in classInfo:
    newClass = {'name':Class['name'], 'role':Class['role'], 'source':Class['source'], 
    'keystat':Class['keystat'], 'armor':Class['armor'], 'weapon':Class['weapon'], 'implement':Class['implement'], 
    'defense':Class['defense'], 'starthp':Class['starthp'], 'levelhp':Class['levelhp'], 'surge':Class['surge'],
    'skills':Class['skills'], 'features':Class['features']}
    
    emit('updateClassInfo', newClass)

@socketio.on('connect')
def makeConnection():
  print("Entered makeConnection on SERVER.PY")

@app.route('/', methods=['GET', 'POST'])
def mainIndex():
  
  method = request.method
  print (method)
    
  return render_template('index.html')

# start the server
if __name__ == '__main__':
    socketio.run(app, host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)

