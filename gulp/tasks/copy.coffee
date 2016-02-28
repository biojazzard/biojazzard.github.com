'use strict'

gulp = require('gulp')
copy = require('gulp-copy')

#_path = require('path')
#sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'copy', ->
  gulp.src [
    './src/components/font-awesome/fonts/*'
  ]
  .pipe copy('_site/assets/fonts', prefix: 4)
