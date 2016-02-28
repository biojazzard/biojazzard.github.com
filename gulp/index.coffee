'use strict'

fs = require('fs')
argv = require('yargs').argv
onlyScripts = require('./util/scriptFilter')
onlyJades = require('./util/jadeFilter')

gulp = require('gulp')
jade = require('gulp-jade')
less = require('gulp-less')
_path = require('path')
marked = require('marked')
htmlhint = require('gulp-htmlhint')

tasks = fs.readdirSync('./gulp/tasks/').filter(onlyScripts)

#global.isProduction = if argv.production or argv.prod then true else false

jades = fs.readdirSync('./src/jade/').filter(onlyJades)

#global.isProduction = if argv.production or argv.prod then true else false

###
# SOURCE & BUILD
###

global.isProduction = true

global.source =
  templates:
    php:
      files: 'src/jade/*.jade'
      templates: 'src/jade-templates/*.jade'
      watch: 'src/jade/**/*.jade'
    app:
      watch: [
        'src/jade/**/*.jade'
        'src/jade-templates/**/*.jade'
        'src/less/**/*.less'
        'src/coffee/**/*.coffee'
      ]
  styles:
    app:
      files: [ 'src/less/index.less' ]
      watch: [ 'src/less/**/*.less' ]
      dir: 'css'
  scripts:
    app:
      files: [ 'src/coffee/*.coffee' ]
      watch: [ 'src/coffee/**/*.coffee' ]
      dir: 'js'
    js:
      dir: 'src/js'

global.direct =
  proxy: 'localhost/beta.lantegi.com'
  url: 'http://localhost/beta.lantegi.com/'
  app: '_site'
  main: '_site/assets/js/app.js'
  styles: '_site/assets/css'
  scripts: '_site/assets/js'
  fonts: '_site/assets/fonts'
  templates:
    app: './'
  screens: '_site/screenshots'

global.build =
  proxy: 'localhost/tallerdelsoho.es/alfredo.llanos/_site'
  url: 'http://localhost/tallerdelsoho.es/alfredo.llanos/_site/'
  app: '_site'
  main: '_site/assets/js/app.js'
  maincss: '_site/assets/css/app.css'
  css: '_site/assets/css/index.css'
  styles: '_site/assets/css'
  scripts: '_site/assets/js'
  fonts: '_site/assets/fonts'
  templates:
    app: './'
  screens: '_site/screenshots'

###
# REQUIRE ALL TASKS
###

tasks.forEach (task) ->
  require './tasks/' + task
  return
