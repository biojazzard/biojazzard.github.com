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

gulp.task 'uglifypreconcat', ->
  gulp.src [
    'src/components/FitText.js/jquery.fittext.js',
    'src/components/js-cookie/src/js.cookie.js',
    'src/components/jquery-cookiecuttr/jquery.cookiecuttr.js',
    'src/js/webflow.js'
    'src/js/webflow-ix.js'
    'src/js/webflow-slider.js'
    'src/js/_debouncedresize.js'
    'src/js/_vimeo.js'
    'src/js/index.js'
  ]
  .on('error', handleErrors)
  .pipe uglify(opts)
  .pipe gulp.dest('src/jsmin/')
  .pipe size()
