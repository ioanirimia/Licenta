import os
from flask import Flask, render_template, json , request
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash



app = Flask(__name__)

mysql =MySQL()
app.config['MYSQL_DATABASE_USER'] = 'ioanirimia'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'catalog'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)
conn = mysql.connect()
cursor = conn.cursor()
mysql.init_app(app)



@app.route("/")
def main():
    return "hello"
    
@app.route("/login")
def login():
    return render_template('login.html')

@app.route("/index")
def index():
    return render_template('index.html')
    
@app.route("/showSignUp")
def showSignUp():
    return render_template('signup.html')
    
@app.route("/pagCatalog")
def pagCatalog():
    return render_template('pag_catalog.html')
    

@app.route('/signIn',methods=['POST'])
def signIn():
 
    # read the posted values from the UI
    _name = request.form['username']
    _password = request.form['password']
    
    
    # am pus un comentariu
 
    # validate the received values
    if _name  and _password:
        _hashed_password = generate_password_hash(_password)
        cursor.callproc('sp_check_login',(_name,_hashed_password))
        
        data = cursor.fetchall()
        print str(data[0][0])
        if str(data[0][0]).encode('utf-8') == u'Login fail'.encode('utf-8'):
            return json.dumps({'html':'<span>Login fail</span>',
                               'message':str(data[0][0])})
        else:
            return json.dumps({'html':'<span>Login success</span>',
                               'message':str(data[0][0])})


@app.route('/signUp',methods=['POST'])
def signUp():
 
    # read the posted values from the UI
    
    _email = request.form['inputEmail']
    _name = request.form['inputName']
    _password = request.form['inputPassword']
    
    # validate the received values
    if _name and _email and _password:
        _hashed_password = generate_password_hash(_password)
        cursor.callproc('sp_createUser',(_name,_email,_hashed_password))
        
        data = cursor.fetchall()
        if len(data) is 0: # daca s-a inserat utilizator
            conn.commit()
            return json.dumps({'html':'<span>Toate campurile sunt completate</span>',
                               'message':'User created successfully !'})
        else:
            return json.dumps({'error':str(data[0])})
    else:
        return json.dumps({'html':'<span>Completati campurile lipsa</span>'})

app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT', 8080)))

if __name__ == "__main__":
    app.run()