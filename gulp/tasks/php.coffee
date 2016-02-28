'use strict'

gulp = require('gulp')
jade = require('gulp-jade-php')
_path = require('path')
marked = require('marked')
htmlhint = require('gulp-htmlhint')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'php', ->
  gulp.src global.source.templates.php.files
  .pipe jade(locals: title: 'OMG THIS IS THE TITLE')
  .on('error', handleErrors)
  #.pipe(htmlhint())
  #.pipe(htmlhint.reporter())
  .pipe gulp.dest('./')

gulp.task 'php-templates', ->
  gulp.src global.source.templates.php.templates
  .pipe jade(locals: title: 'OMG THIS IS THE TITLE')
  .on('error', handleErrors)
  #.pipe(htmlhint())
  #.pipe(htmlhint.reporter())
  .pipe gulp.dest('./php-templates')
