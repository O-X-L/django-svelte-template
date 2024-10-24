from pathlib import Path
from os import environ

D1 = 'app'
D2 = 'src'
DEBUG = 'DEV_MODE' in environ

if DEBUG:
    print('RUNNING IN DEV MODE')

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = environ['WEB_SECRET']

INSTALLED_APPS = [
    f'{D1}.apps.ThisAppConfig',
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = f'{D1}.urls'

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / D1 / D2 / 'templates'],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
            'libraries': {
                'svelte': f'{D1}.{D2}.templatetags.svelte',
            },
        },
    },
]

WSGI_APPLICATION = f'{D1}.main.app'


# Database
# https://docs.djangoproject.com/en/5.0/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}


# Password validation
# https://docs.djangoproject.com/en/5.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# WEB BASICS
PORT_WEB = 8080
LISTEN_ADDRESS = '0.0.0.0'
CSRF_TRUSTED_ORIGINS = [
    f'http://{LISTEN_ADDRESS}'
    f'http://{LISTEN_ADDRESS}:{PORT_WEB}'
]

SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
USE_X_FORWARDED_HOST = True

ALLOWED_HOSTS = ['*']
for hostname in environ['WEB_HOSTNAMES'].split(','):
    ALLOWED_HOSTS.append(hostname)
    CSRF_TRUSTED_ORIGINS.extend([
        f'http://{hostname}',
        f'https://{hostname}',
        f'http://{hostname}:{PORT_WEB}',
        f'https://{hostname}:{PORT_WEB}',
    ])

CSRF_ALLOWED_ORIGINS = CSRF_TRUSTED_ORIGINS
CORS_ORIGINS_WHITELIST = CSRF_TRUSTED_ORIGINS

# Internationalization
LANGUAGE_CODE = 'en-us'
USE_I18N = True
USE_L10N = True
USE_TZ = True
TIME_ZONE = 'UTC'

STATIC_ROOT = "/staticfiles"
STATIC_URL = "/static/"
STATICFILES_DIRS = [BASE_DIR / 'static']

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# enable logging of exceptions to console in production
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': 'ERROR',
        },
    },
}
