'use strict'

gulp = require('gulp')
del = require('del')
_path = require('path')
sequence = require('run-sequence')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'clean', ->
  del [
    '_site/**/*'
    'build'
  ]