'use strict'

handleErrors = undefined

gulp = require('gulp')
uglify = require('gulp-uglify')
size = require('gulp-size')

handleErrors = require('../util/handleErrors')

opts =
  preserveComments: false
  compress:
    sequences: true
    dead_code: true
    conditionals: true
    booleans: true
    unused: true
    if_return: true
    join_vars: true
    drop_console: true

gulp.task 'uglify', ->
  gulp.src global.build.main
  .on('error', handleErrors)
  .pipe uglify(opts)
  .pipe gulp.dest( global.build.scripts )
  .pipe size()
