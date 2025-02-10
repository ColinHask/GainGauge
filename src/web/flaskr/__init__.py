from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Create a Flask application instance
app = Flask(__name__)

# Set the configuration for SQLAlchemy.
# For development, we use SQLite. This creates a file named 'GainGauge.db' in the root directory.
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///GainGauge.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Create a SQLAlchemy instance and tie it to the Flask app.
db = SQLAlchemy(app)

# Optionally, import models here so they are registered.
from . import user
