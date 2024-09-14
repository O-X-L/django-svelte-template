# Django + Svelte Static

This is a Django + Svelte project template.

It is based on the one of [@rupert-br](https://github.com/rupert-br). See: [Svelte-Django Blog](https://www.rbd-solutions.com/blog/svelte-django/)

But instead of using vite, this template builds the Svelte bundles periodically every few seconds.

This has the benefit that you don't need to add vite support to django and can simply include the static files in your django templates.

Whenever you move to a production setup, you can simply deploy these static files, and you are good to go.

Template example: [index.html](https://github.com/O-X-L/django-svelte-template/blob/main/app/app/templates/index.html)

----

## Directory structure

This template would use templates-specific Svelte-bundles. This is a personal preference. You can - of course - use a single one for all of them. 

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
│   └── svelte
│       └── index  # <== svelte src
```

----

## Scripts

* `install.sh` => basic commands to install all dependencies (django/npm/svelte)
* `dev.sh` => run dev server and svelte bundle-updater
  * `build_svelte.sh` => build svelte bundle periodically and move it into the django-static directory
    If you want to add more svelte src-directories, you have to duplicate the last two lines in this script

If you get the error `port is already in use` - you might need to kill an orphaned django process: `pkill -f manage.py`
