'use strict'

gulp = require('gulp')
browserify = require('browserify')
coffee = require('gulp-coffee')
rename = require('gulp-rename')
_path = require('path')

source = require('vinyl-source-stream')

handleErrors = require('../util/handleErrors')

#the core bundle for our application
gulp.task 'browserify', ->
  browserify('src/js/index.js')
  .bundle()
  .pipe source('app.js')
  .pipe gulp.dest(global.build.scripts)
