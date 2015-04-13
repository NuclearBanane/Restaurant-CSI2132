import pg8000 


conn = pg8000.connect(user="postgres", password="kate",database="proj") #Don't judge. 
t= conn.cursor()
t.execute("SET CLIENT_ENCODING TO 'UTF8'")
t.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';""")
print t.fetchall()




def addUsr(info):
  print info
  email=info['email']
  userName=info['userName']
  t=conn.cursor()
  t.execute('SELECT R.userID FROM rater R WHERE R.userName = %s',(userName,))
  y=t.fetchone()
  print y
  t.execute('SELECT R.userID FROM rater R WHERE R.email = %s',(email,))
  x=t.fetchone()
  print x
  if not y and not x:
    password=info['password']
    name=info['firstname']
    lastname=info['lastname']
    t.execute(
      """
      INSERT INTO rater(
      userName,email,password,raterFirstName,raterLastName,raterJoinDate,raterType,reputation) 
      VALUES (%s, %s, %s, %s, %s, (SELECT current_timestamp ),'blog',0)""",
      (email,userName,password,name,lastname))
    conn.commit()
    #inserted new user
    return True
  else :
    #user or email already existed in the database
    return False

def addResto(info):
  email=info['email']
  restoName=info['restoName']
  t=conn.cursor()
  t.execute('SELECT R.userID FROM restaurant R WHERE R.resName = %s',(restoName,))
  y=t.fetchone()
  t.execute('SELECT R.userID FROM restaurant R WHERE R.email = %s',(email,))
  x=t.fetchone()
  print y
  if not y and not x:
    password=info['password']
    name=info['firstname']
    lastname=info['lastname']
    t.execute(
      """
      INSERT INTO rater(
      userName,email,password,raterFirstName,raterLastName,raterJoinDate,raterType,reputation) 
      VALUES (%s, %s, %s, %s, %s, (SELECT current_timestamp ),'blog',0)""",
      (email,userName,password,name,lastname))
    conn.commit()
    #inserted new user
    return True
  else :
    #user or email already existed in the database
    return False
