'use strict'

gulp = require('gulp')
gulpif = require('gulp-if')
gutil = require('gulp-util')

bundleLogger = require('../util/bundleLogger')
handleErrors = require('../util/handleErrors')

localScreenshots = require('gulp-local-screenshots');

gulp.task 'screenshots', ->
  gulp.src('./').pipe localScreenshots(
    path: './'
    host: 'localhost'
    port: '80'
    server: false
    folder: 'screenshots'
    width: [
      '1600'
      '1000'
      '480'
      '320'
    ])
  .pipe gulp.dest(global.build.screens)