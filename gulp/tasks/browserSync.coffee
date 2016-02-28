'use strict'

gulp = require('gulp')
browserSync = require('browser-sync').create()

gulp.task 'browserSync', ->
  browserSync.init
    files: [ global.source.templates.app.watch ]
    proxy: 'localhost/beta.lantegi.com'
    notify: false
  gulp.watch(global.build.scripts).on 'change', browserSync.reload
  #gulp.watch(global.build.styles).on 'change', browserSync.reload
  return

gulp.task 'browserSync:reload', ->
  browserSync.reload()
  return