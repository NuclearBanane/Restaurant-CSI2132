import pg8000 


conn = pg8000.connect(user="postgres", password="kate") #Don't judge. 



def addUsr(info):
  t=conn.cursor()
  t.execute("""create table "Rater"
(
       userID integer, 
       userName varchar(32),
       email varchar(60),
       raterFirstName varchar(20),
       raterLastName varchar(20),
       raterJoinDate date,
       raterType varchar(20),
       reputation integer,

       constraint pk_rater primary key(userID),
       constraint repBounds check (reputation between 0 and 5)
);"""
    )
  t.execute("SELECT userID FROM Rater WHERE userName = %s",(info['userName'],))
  y=t.fetchone()
  if len(y)==0:
    t.execute("INSERT INTO Rater VALUES (100, %s, %s, %s, %s, %s,'blog',0)",(info['email'],info['userName'],info['name'],info['lastname'],info['date']))
    print 'inserted some fool'
    return true
  else :
    print 'fool, you already exist'
    return false

