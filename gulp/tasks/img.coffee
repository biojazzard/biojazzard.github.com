'use strict'

gulp = require('gulp')
imagemin = require('gulp-imagemin')
_path = require('path')
sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'img', ->
  gulp.src 'src/img/**/*.{png,jpg, gif}'
  .on('error', handleErrors)
  .pipe imagemin
    progressive: true
    interlaced: true
  .pipe gulp.dest('app/assets/img/')
