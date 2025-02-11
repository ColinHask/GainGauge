import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()  # Create a global SQLAlchemy instance

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        SQLALCHEMY_DATABASE_URI=f"sqlite:///{os.path.join(app.instance_path, 'gainguage.sqlite')}",
        SQLALCHEMY_TRACK_MODIFICATIONS=False
    )

    if test_config is None:
        # load the instance config, if it exists
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # Initialize the db object with this app
    db.init_app(app)

    # Possibly import and register Blueprints or routes here, e.g.:
    # from .views import main_bp
    # app.register_blueprint(main_bp)

    return app
