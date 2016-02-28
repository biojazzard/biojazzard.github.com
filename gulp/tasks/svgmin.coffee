'use strict'

gulp = require('gulp')
svgmin = require('gulp-svgmin')
_path = require('path')
sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'svgmin', ->
  gulp.src 'src/svg/*.svg'
  .on('error', handleErrors)
  .pipe svgmin
    js2svg:
      pretty: false
  .pipe gulp.dest('app/assets/svg/')
