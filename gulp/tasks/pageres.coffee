'use strict'

gulp = require('gulp')
gulpif = require('gulp-if')
gutil = require('gulp-util')

bundleLogger = require('../util/bundleLogger')
handleErrors = require('../util/handleErrors')

Pageres = require('pageres')

gulp.task 'pageres', ->
  pageres = new Pageres({delay: 4})
  .src('dermoproducts.com', ['480x320', '1024x768', 'iphone 5s'], {crop: true})
  .src('dermoproducts.com', ['1280x1024', '1920x1080'])
  .dest('app/pageres')
  .run()
#.then(() => console.log('done'));