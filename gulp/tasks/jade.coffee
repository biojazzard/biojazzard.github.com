'use strict'

gulp = require('gulp')
jade = require('gulp-jade')
less = require('gulp-less')
_path = require('path')
marked = require('marked')
htmlhint = require('gulp-htmlhint')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'jade', ->
  gulp.src(global.source.templates.app.files)
  .pipe(jade(pretty: true))
  .on('error', handleErrors)
  .pipe(htmlhint())
  .pipe(htmlhint.reporter())
  .pipe gulp.dest(global.build.app)
