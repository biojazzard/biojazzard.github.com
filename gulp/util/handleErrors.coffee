'use strict'

notify = undefined
__slice__ = [].slice
notify = require('gulp-notify')

module.exports = ->
  args = if 1 <= arguments.length then __slice__.call(arguments, 0) else []
  notify.onError(
    title: 'Compile Error'
    message: '<%= error.message %>').apply this, args
  @emit 'end'
  return
