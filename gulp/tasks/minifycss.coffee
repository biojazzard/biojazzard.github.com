'use strict'

gulp = require 'gulp'
minifyCss = require 'gulp-minify-css'
size = require 'gulp-size'

handleErrors = require '../util/handleErrors'

gulp.task 'minifycss', ->
  gulp.src global.build.maincss
  .on('error', handleErrors)
  .pipe minifyCss()
  .pipe gulp.dest(global.build.styles)
  .pipe size()
