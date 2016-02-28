'use strict'

gulp = require('gulp')
sequence = require('run-sequence')

scripts = [
  'coffee'
  'browserify'
  'uglify'
]

styles = [
  'less'
  'concatcss'
  'minifycss'
]

if global.isProduction
  gulp.task 'build', (cb)->
    console.log '1unes is in production'
    sequence ['clean'], ['jekyll'], ['coffee'], ['browserify'], ['concat'], ['uglify'], ['less'], ['concatcss'], ['minifycss'], ['copy'], cb
else
  gulp.task 'build', (cb)->
    console.log '1unes is in dev'
    sequence ['clean'], ['jekyll'], ['coffee'], ['browserify'], ['concat'], ['uglify'], ['less'], ['concatcss'], ['minifycss'], ['copy'], cb
