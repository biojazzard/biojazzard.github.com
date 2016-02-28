'use strict'

gulp = require('gulp')
coffee = require('gulp-coffee')
_path = require('path')
sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'coffee', ->
  gulp.src global.source.scripts.app.files
  .on('error', handleErrors)
  .pipe coffee
    bare: true
    compress: true
  .pipe gulp.dest(global.source.scripts.js.dir)

gulp.task 'coffeebr', (cb)->
  sequence ['coffee'], ['browserify'], cb
