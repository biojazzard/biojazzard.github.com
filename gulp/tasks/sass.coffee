'use strict'

gulp = require('gulp')
sass = require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
cmq = require('gulp-combine-media-queries')
csso = require('gulp-csso')
size = require('gulp-size')
gulpif = require('gulp-if')

browserSync = require('browser-sync')

handleErrors = require('../util/handleErrors')

gulp.task 'sass', ->
  dest = './public/css'
  gulp.src('./public/scss/app.{scss,sass}').pipe(sass(
    precision: 7
    outputStyle: 'nested'))
  .on('error', handleErrors)
  .pipe(autoprefixer())
  .pipe(gulpif(global.isProduction, cmq(log: true)))
  .pipe(csso())
  .pipe(gulp.dest(dest))
  .pipe(browserSync.reload(stream: true))
  .pipe size()
