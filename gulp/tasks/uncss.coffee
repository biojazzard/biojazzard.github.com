gulp = require('gulp')
uncss = require('gulp-uncss')
size = require('gulp-size')
gulpif = require('gulp-if')
handleErrors = require('../util/handleErrors')

gulp.task 'uncss', ->
  dest = 'app/assets/css/'
  gulp.src('app/assets/css/build.css')
  .pipe(uncss(
    html: [
      'http://localhost/1un.es/'
      'http://localhost/1un.es/es/proyectos/'
    ]
    ignore: [
      /zen/
      /document/
      /modal/
      /settings/
      /button/
      /btn/
      /toggle/
      /menu/
      /owl-carousel/
      /dropdown/
      /ace/
      /editor/
      /sr/
      /form/
      /di/
      /not/
    ]))
  .on('error', handleErrors)
  .pipe gulp.dest(dest)
  .pipe size()
