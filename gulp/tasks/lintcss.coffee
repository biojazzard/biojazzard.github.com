'use strict'

gulp = undefined
handleErrors = undefined

gulp = require('gulp')
csslint = require('gulp-csslint')
gutil = require('gulp-util')

handleErrors = require('../util/handleErrors')

gulp.task 'lintcss', ->
  gulp.src [
    'app/assets/css/index.css'
  ]
  .on('error', handleErrors)
  .pipe csslint('csslintrc.json')
  .pipe csslint.reporter(customReporter)
  return

customReporter = (file) ->
  gutil.log gutil.colors.cyan(file.csslint.errorCount) + ' errors in ' + gutil.colors.magenta(file.path)
  file.csslint.results.forEach (result) ->
    gutil.log result.error.message + ' on line ' + result.error.line
    return
  return
