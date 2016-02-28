'use strict'

gulp = require('gulp')
sequence = require('run-sequence')

gulp.task 'watch', [
  'setWatch'
  'less'
  'php'
  'php-templates'
  'coffeebr'
  'browserSync'
], ->
  gulp.watch [global.source.templates.app.watch], [
    'php'
    'browserSync:reload'
  ]
  gulp.watch [global.source.templates.app.watch], [
    'php-templates'
    'browserSync:reload'
  ]
  gulp.watch [global.source.styles.app.watch], [
    'less'
    'browserSync:reload'
  ]
  gulp.watch [global.source.scripts.app.watch], [
    'coffeebr'
    'browserSync:reload'
  ]
  return
