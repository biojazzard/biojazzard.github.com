---
layout: post
title: Deploy de un sitio web con git
---

*Si usas git para controlar un proyecto, muchas veces querrás que sólo lo alojado en ```dist``` o ```_site``` sea lo publicado en la web.*

Este es el caso si usas [Yeoman](http://yeoman.io/) o [Jekyll](http://jekyllrb.com/), o cualquier otro sistema en el que publiques sobre una carpeta: ```dist```, ```_site``` o como la llames.

# Necesario

Usar ```git subtree```.

# Suponemos

* Contenido a publicar: ```_site```

```
.
├── _includes/
|   ├── footer.html
|   ├── header.html
|   └── posts.html
├── _plugins/
|   ├── asset_url.rb
|   └── image_tag.rb
├── _layouts/
|   ├── default.html
|   ├── page.html
|   └── post.html
├── _posts/
|   ├── 2013-02-11-.md
|   └── 2013-01-31-hello-world.md
├── _site/ --> A PUBLICAR EN LA RAIZ DE LA WEB
├── _config.yml
└── index.html
```

* Branch de trabajo: ```master```

* Branch a publicar: ```dist``` (Se creará al vuelo)

1. Eliminar el directorio ```_site``` del archivo ```.gitignore``` file. Yeoman lo ignora por defecto. OjO.

2. Añade el directorio a git y hacemos ```commit``` a todo.

```bash
git add _site && git commit -m "Initial _site subtree commit"
```

3. Empujamos ```_site``` al **origen** sobre el branch **dist** 

```bash
git subtree push --prefix _site origin dist
```

## Acualizaciones

* ```git commit``` a todo el proyecto y
* ```git subtree push --prefix _site origin dist```

Ya está si usas los hooks, tu sitio se actualizará automáticamente.

## Para leer:

[Deploying a Yeoman Site](http://yeoman.io/learning/deployment.html)
