'use strict'

gulp = require 'gulp'
jekyll = require 'gulp-jekyll'

#_path = require 'path'
#sequence = require 'run-sequence'

browserSync = require 'browser-sync'

handleErrors = require('../util/handleErrors')

gulp.task 'jekyll', ->
  process.env.JEKYLL_ENV = 'production'
  gulp.src [
    './index.html'
  ]
  .pipe jekyll
    source: './'
    destination: './_site/'