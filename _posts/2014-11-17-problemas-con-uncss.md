---
layout: post
title: Problemas con uncss
---

**uncss** ```npm install -g uncss``` promete mucho pero no lo puedo usar por ahora en producción.

# Resumen

No usable en producción salvo en casos concretos.

## 1. Principalmente por este asunto:

[Github:UnCSS ignoring complex selectors #74](https://github.com/giakki/uncss/issues/74)

### Escenario

El documento original contiene:

```html
<div class="menu"></div>
```

Cuando alguien hace lo necesario, el menu se abre: añadiéndole la clase "open".

```coffeescript
$('menu-open-btn').on 'click', ()->
	$('.menu').addClass 'open'
```

Obtenemos:

```html
<div class="menu open"></div>
```

El css sería:

```css
.menu {
  display: none;
}
```

Fail:

```css
// Houston, We've Had a Problem
// UNCSS No lo pilla: >_<
.menu.open {
  display: block;
}
```

Este escenario es representativo de muchos otros. Lo que hace **uncss** poco usable.

### Solución

Si no excedes el uso de selectores complejos, puedes pasar a **uncss** el parametro ```ignore``` con los selectores que conozcas que quieras preservar:

```coffeescript
uncss:
  dist:
    options:
      ignore: [
        '.menu.open'
      ]
    files:
      './_site/build/style.un.css': ['./_site/{,*/}*.html', './_site/theme/{,*/}*.html']
```


## 2. Manejo de errores, es fácil que acabes así:

[Fatal error: missing '{' near line ...](https://github.com/addyosmani/grunt-uncss/issues/34)

El manejo de errores no es más fino de la escena, y peta. Si usas **grunt**, te petará el proceso.



