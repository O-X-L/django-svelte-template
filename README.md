# Django + Svelte Static

This is a Django + Svelte project template.

It is based on the one of [@rupert-br](https://github.com/rupert-br). See: [Svelte-Django Blog](https://www.rbd-solutions.com/blog/svelte-django/)

But instead of using vite, this template builds the Svelte bundles periodically every few seconds.

This has the benefit that you don't need to add vite support to django and can simply include the static files in your django templates.

Whenever you move to a production setup, you can simply deploy these static files, and you are good to go.

Template example: [index.html](https://github.com/O-X-L/django-svelte-template/blob/main/app/app/templates/index.html)

----

## Directory structure

```bash
├── app
│   ├── app
│   │   ├── migrations
│   │   └──  templates
│   │       └── index.html  # <== django template
│   ├── main/
│   ├── static
│   │   ├── dist  # <== svelte dist (built bundles)
│   │   │   ├── index.css
│   │   │   └── index.js
│   │   └── img
│   └── svelte  # <== svelte project
```

----

## Add a Svelte App

* Add it to the `APPS` array inside `build_svelte.sh`
* Create the app inside another directory in `app/svelte/src/`
* Add the app to `app/svelte/vite.config.ts` (*input*)
* Create the HTML element targeted in `app.ts` via `document.getElementById` in your Django template
* Import the new js/css inside your Django template:

  ```html
  <link href="{% static 'dist/test.css' %}" rel="stylesheet" type="text/css">
  <script src="{% static 'dist/test.js' %}"></script>
  ```

----

## Scripts

* `install.sh` => basic commands to install all dependencies (django/npm/svelte)
* `dev.sh` => run dev server and svelte bundle-updater
  * `build_svelte.sh` => build svelte bundle periodically and move it into the django-static directory
    If you want to add more svelte src-directories, you have to duplicate the last two lines in this script

If you get the error `port is already in use` - you might need to kill an orphaned django process: `pkill -f manage.py`
