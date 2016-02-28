'use strict'

path = require('path')

module.exports = (name) ->
  /(\.(jade)$)/i.test path.extname(name)
