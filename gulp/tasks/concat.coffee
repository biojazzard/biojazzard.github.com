'use strict'

gulp = require('gulp')
concat = require('gulp-concat')
_path = require('path')

stripCssComments = require('gulp-strip-css-comments');

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'concat', ->
  gulp.src [
    '_site/assets/js/app.js'
    'src/js/lib/twitterFetcher_v12_min.js'
  ]
  .on('error', handleErrors)
  .pipe concat(path: 'app.js')
  .pipe gulp.dest(global.build.scripts)

gulp.task 'concatcss', ->
  gulp.src [
    global.build.css
    'node_modules/animate.css/animate.css'
  ]
  .on('error', handleErrors)
  .pipe concat(path: 'app.css')
  #.pipe stripCssComments()
  .pipe gulp.dest(global.build.styles)

