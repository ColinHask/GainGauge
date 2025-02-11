from web_app import db
from werkzeug.security import generate_password_hash, check_password_hash


class User(db.Model):
    # primary key 
    id = db.Column(db.Integer, primary_key=True)

    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'
    
    def set_password(self, password):
        # generate hashed password and store it
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        # return true if given password matches stored hash
        return check_password_hash(self.password_hash, password)