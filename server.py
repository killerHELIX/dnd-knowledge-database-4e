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
  connectionString = 'dbname=dungeons user=dnduser password=dnd host=localhost'
  print connectionString
  try:
    return psycopg2.connect(connectionString)
  except:
    print("Can't connect to database")

conn = connectToDB()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

@socketio.on('getInfo')
def getInfo(Level, Race, Class, username, stats, skills):
  print("Entered getInfo on SERVER.PY")
  # get feats
  query = "SELECT * FROM feats WHERE race = %s OR Class = %s;"
  mog = cur.mogrify(query, (Race, Class))
  print(mog)
  try:
    cur.execute(mog)
  except:
    print("Error:: cannot get feats")
    
  feats = cur.fetchall()
  # get race info
  query = "SELECT * FROM race WHERE name = %s;"
  mog = cur.mogrify(query, [Race])
  print(mog)
  
  try:
    cur.execute(mog)
  except:
    print("Error: cannot get race info")
  raceInfo = cur.fetchall()
  
  for race in raceInfo:
    newRace = {'name':race['name'],'skill':race['skill'],'stats':race['stats'], 'size':race['size'],
    'speed':race['speed'], 'vision':race['vision'], 'language':race['language'], 'traits':race['traits'], 
    'book':race['book']}
    
    emit('updateRaceInfo', newRace);
  
  # get class info
  query = "SELECT * FROM class WHERE name = %s;"
  mog = cur.mogrify(query, [Class])
  print(mog)
  
  try:
    cur.execute(mog)
  except:
    print("Error: cannot get class info")
    
  classInfo = cur.fetchall()
  print(classInfo)
  
  for Class in classInfo:
    newClass = {'name':Class['name'], 'role':Class['role'], 'source':Class['source'], 
    'keystat':Class['keystat'], 'armor':Class['armor'], 'weapon':Class['weapon'], 'implement':Class['implement'], 
    'defense':Class['defense'], 'starthp':Class['starthp'], 'levelhp':Class['levelhp'], 'surge':Class['surge'],
    'skills':Class['skills'], 'features':Class['features']}
    
    emit('updateClassInfo', newClass)
    
  # delete old user's character and add new one
  
  deletion = "UPDATE users SET character = NULL where username = %s;"
  mog = cur.mogrify(deletion, [username])
  print(mog)
  try:
    # cur.execute(mog)
    print("Deletion successful.")
  except:
    print("Deletion FAILED. Rolling back...")
    # conn.rollback();
    print("Done.")
  # conn.commit()
  print("skills[arcana]")
  print(skills['arcana'])
  insertion = "INSERT INTO character VALUES(%s, %s, %s, %s, %s, 'source', %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'feats', 'Corellon', 'hide', 'simple, military');"
  mog = cur.mogrify(insertion, (username, Level, Race, Class, stats['str'], stats['con'], stats['dex'], stats['int'], stats['wis'], stats['cha'],
   skills['acrobatics'], skills['arcana'], skills['athletics'], skills['bluff'], skills['dungeoneering'], skills['endurance'], skills['heal'],
   skills['intimidate'], skills['nature'], skills['perception'], skills['religion'], skills['stealth'], skills['streetwise'], skills['thievery']))
    
  print(mog)
    
@socketio.on('register')
def register(username, password):
  print('Entered register on SERVER.PY')
  
  # check to see if already registered
  query = "SELECT username FROM users where username = %s;"
  mog = cur.mogrify(query, [username])
  cur.execute(mog)
  result = cur.fetchall()
  print(result)
  
  if len(result) is 0:
    
    query = "INSERT INTO users (username, password, character) VALUES (%s, crypt(%s, gen_salt('bf')), 0);"
    mog = cur.mogrify(query, (username, password))
    print(mog)
    
    try:
      cur.execute(mog)
      success = True
    except:
      success = False
      print("Insertion FAILED. Rolling back...")
      conn.rollback()
      print("Done.")
      
    conn.commit()
    emit('registerResult', success)
  else:
    print("User already exists!")
    success = False
    emit('registerResult', success)
    
@socketio.on('login')
def login(username, password):
  print("Entered login on SERVER.PY")
  
  query = "SELECT * FROM users WHERE username = %s AND password = crypt(%s, password);"
  mog = cur.mogrify(query, (username, password))
  print(mog)
  
  cur.execute(mog)
  results = cur.fetchall()
  
  if len(results) is 0:
    success = False;
    emit('loginResult', success)
  
  else:
    success = True;
    
    # get this user's characters, TODO
    query = "SELECT * FROM character, users WHERE users.character = character.id AND users.username = %s;"
    mog = cur.mogrify(query , [username]);
    print(mog)
    
    cur.execute(mog)
    characters = cur.fetchall()
    
    for character in characters:
      print(character['id'])
      newCharacter = {'id':character['id'], 'name':character['name'], 'level':character['level'], 'race':character['race'], 'class':character['class'], 'source':character['source'],
      'str':character['str'], 'con':character['con'], 'dex':character['dex'], 'int':character['int'], 'wis':character['wis'], 'cha':character['cha'], 
      'acrobatics':character['acrobatics'], 'arcana':character['arcana'], 'athletics':character['athletics'], 'bluff':character['bluff'], 'dungeoneering':character['dungeoneering'], 'endurance':character['endurance'], 'heal':character['heal'], 'intimidate':character['intimidate'], 'nature':character['nature'], 'perception':character['perception'], 'religion':character['religion'], 'stealth':character['stealth'],
      'feats':character['feats'], 'god':character['god'], 'armor_proficiency':character['armor_proficiency'], 'weapon_proficiency':character['weapon_proficiency']}
      
      emit('characterData', newCharacter)
    
    emit('loginResult', success);
  

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

