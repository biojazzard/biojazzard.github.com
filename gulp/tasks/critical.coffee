'use strict'

gulp = require('gulp')
csso = require('gulp-csso')
size = require('gulp-size')
# Direct Outut
critical_generate = require('critical').generate
# Important to pipe OUT
criticalStream = require('critical').stream

gulp.task 'critical', ->
  critical_generate
    inline: true
    base: './'
    src: global.build.url
    css: 'app/assets/css/app.css'
    dest: 'index.html'
    minify: true

### Generate & Inline Critical-path CSS
gulp.task 'critical', ->
  gulp.src [
    global.build.url
  ]
  .pipe criticalStream
    inline: true
    base: './'
    dest: 'index.html'
    css: 'app/assets/css/app.css'
    minify: true
  #.pipe csso()
  .pipe gulp.dest(global.build.styles)
###