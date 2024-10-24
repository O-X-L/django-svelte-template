from multiprocessing import cpu_count
from string import ascii_letters
from random import choice as random_choice

import gunicorn
from gunicorn.app.wsgiapp import WSGIApplication

PORT_WEB = 8080
LISTEN_ADDRESS = '0.0.0.0'

# https://docs.gunicorn.org/en/stable/settings.html


class StandaloneApplication(WSGIApplication):
    def __init__(self, app_uri, options=None):
        self.options = options or {}
        self.app_uri = app_uri
        super().__init__()

    def load_config(self):
        config = {
            key: value
            for key, value in self.options.items()
            if key in self.cfg.settings and value is not None
        }
        for key, value in config.items():
            self.cfg.set(key.lower(), value)


def init_webserver():
    gunicorn.SERVER = ''.join(random_choice(ascii_letters) for _ in range(10))
    opts = {
        'workers': (cpu_count() * 2) + 1,
        'bind': f'{LISTEN_ADDRESS}:{PORT_WEB}',
        'reload': True,
        'loglevel': 'info',
    }

    StandaloneApplication(
        app_uri="app.main:app",
        options=opts
    ).run()
