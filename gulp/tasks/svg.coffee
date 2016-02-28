'use strict'

gulp = require('gulp')
imagemin = require('gulp-imagemin')
_path = require('path')
sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'svg', ->
  gulp.src 'src/svg/**/*.{svg}'
  .on('error', handleErrors)
  .pipe imagemin
    svgoPlugins: [{removeViewBox: false}]
  .pipe gulp.dest('app/assets/svg/')
