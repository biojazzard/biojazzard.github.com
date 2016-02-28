'use strict'

gulp = require('gulp')
less = require('gulp-less')
csso = require('gulp-csso')
size = require('gulp-size')

#autoprefixer = require('gulp-autoprefixer')
#cmq = require('gulp-combine-media-queries')
#gulpif = require('gulp-if')

#browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'less', ->
  gulp.src global.source.styles.app.files
  .pipe less(paths: [ global.source.styles.app.dir ])
  .on('error', handleErrors)
  #.pipe csso()
  .pipe gulp.dest(global.build.styles)
  .pipe size()
