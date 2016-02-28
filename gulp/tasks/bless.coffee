'use strict'

gulp = require('gulp')
bless = require('gulp-bless')
_path = require('path')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'bless', ->
  gulp.src [
    'app/assets/css/build.css'
  ]
  .on('error', handleErrors)
  .pipe bless()
  .pipe gulp.dest('app/assets/css/ie')
