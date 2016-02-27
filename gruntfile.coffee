module.exports = (grunt) ->
  
  # Load all NPM grunt tasks
  require('matchdep').filterAll('grunt-*').forEach grunt.loadNpmTasks
  
  # Project configuration
  grunt.initConfig
    meta:
      scripts: ['./src/js/*.js']
      lib: ['./src/js/**/*.js']
      styles: [
        './src/less/*.less'
      ]
      html: ['./_site/index.html']

    # Combine JS modules using Browserify
    browserify:
      options:
        debug: true
        #transform: ['deglobalify']

      debug:
        src: ['./debug/main.js']
        dest: './debug/app.js'
        #options:
          #debug: true
          #transform: ['deglobalify']

      build:
        src: ['./build/main.js']
        dest: './build/app.js'
        #options:
        #   transform: ['deglobalify']

    # uncss
    uncss:
      dist:
        options:
          ignore: [
            'svg'
            '.logo #dot-a'
            '#dot-a'
            '.nav-container'
            '.top-bar'
            '.overlay-bar'
            '.offscreen-menu'
            '.drop-shadow'
            '.offscreen-container'
            '.reveal-nav'
            '.main-container.reveal-nav'
            '.nav-sticky'
            '.nav-sticky.top-bar'
            '.nav-sticky.overlay-bar'
            '.nav-sticky.offscreen-menu'
            '.nav-sticky.drop-shadow'
            '.nav-sticky.logo'
            '.offscreen-container'
            '.offscreen-container.reveal-nav'
            '.offscreen-menu'
            '.offscreen-menu.reveal-nav'
            '.popover-content'
          ]
        files:
          './_site/build/style.un.css': ['./_site/{,*/}*.html', './_site/theme/{,*/}*.html']
          #'./_site/build/style.un.css': ['./_site/theme/']

    processhtml:
      options:
        data:
          message: 'Hola!'
      dist:
        files: [
          expand: true
          cwd: './_site/' # Src matches are relative to this path.
          src: ['{,*/}*.html', '**/{,*/}*.html']
          dest: './_site/'
          ext: '.min.html'
        ]

    htmlmin: # Task
      dist: # Target
        options: # Target options
          removeComments: true
          collapseWhitespace: true

        files: [
          expand: true
          cwd: './_site/' # Src matches are relative to this path.
          src: ['{,*/}*.min.html', '**/{,*/}*.min.html']
          dest: './_site/'
          ext: '.html'
        ]

        # files: # Dictionary of files
        #   './_site/index.min.html': ['./_site/index.html'] # 'destination': 'source'

    # Compile Sass files to CSS
    compass:
      options:
        require: 'compass-inuit'
        sassDir: 'sass'

      debug:
        options:
          cssDir: 'debug'
          
          # For source maps
          debugInfo: true
          outputStyle: 'expanded'

      build:
        options:
          cssDir: './build'

    # LESS

    less:
      debug:
        src: ['./src/less/index.less']
        dest: './debug/index.css'
        options:
          compile: true

      build:
        src: ['./src/less/index.less']
        dest: './build/index.css'
        options:
          compile: true
          compress: false


    csslint:
      strict:
        options:
          import: 2
      src: './build/style.css'

    # Concatenate files
    concat:
      debug_js:
        src: ['./debug/app.min.js', './src/js/lib/*.js']
        dest: './debug/build.js'

      build_js:
        src: ['./build/app.min.js', './src/js/lib/*.js']
        dest: './build/build.min.js'

      debug_css:
        src: ['./src/css/*.css', './debug/index.css']
        dest: './debug/style.css'

      build_css:
        src: ['./src/css/*.css', './build/index.css']
        dest: './build/style.css'
    
    # Minify CSS files
    cssmin:
      build:
        files:
          './_site/build/style.un.min.css': [ './_site/build/style.un.css' ]

    coffee:
      debug:
        files:
          './debug/main.js': [ './src/coffee/main.coffee', './src/coffee/**/*.coffee'] # compile and concat into single file

      build:
        files:
          './build/main.js': [ './src/coffee/main.coffee', './src/coffee/**/*.coffee'] # compile and concat into single file

    # Minify JS files
    uglify:
      debug:
        files:
          './debug/app.min.js': ['./debug/app.js']

      build:
        files:
          './build/app.min.js': ['./build/app.js']
    
    # Watch files for changes
    watch:

      coffee:
        files: ['src/coffee/{,*/}*.coffee', 'src/coffee/**/{,*/}*.coffee']
        tasks: ['scripts']

      scripts:
        files: ['<%= meta.scripts %>']
        tasks: ['browserify:debug']
      
      styles:
        files: ['src/less/{,*/}*.less', 'src/less/**/{,*/}*.less']
        tasks: [
          'less:debug'
          'concat:debug_css'
        ]
    
    # Clean target directories
    clean:
      debug: ['debug']
      all: [
        './_site/'
        './debug/'
        './build/'
      ]
      site: [
        './_site/debug/'
        './_site/src/'
        './_site/Gruntfile.coffee'
      ]

    imagemin:
      dynamic:
        files: [
          expand: true
          cwd: './img/'
          src: ['**/*.{png,jpg,gif}']
          dest: './_site/img/'
        ]
    
    # Run Jekyll commands
    jekyll:
      server:
        options:
          serve: true
          # Add the --watch flag, i.e. rebuild on file changes
          watch: true

      build:
        options:
          serve: false

    perfbudget:
      default:
        options:
          url: 'http://localhost:4000/'

    pagespeed:
      options:
        nokey: true
        url: 'http://localhost:4000/'
  
  # Compile JS & CSS, run watch to recompile on change
  grunt.registerTask 'debug', ->
    
    # Rebuild './debug'
    grunt.task.run [
      'clean:debug'
      'less:debug'
      'concat:debug_css'
      'coffee:debug'
      'browserify:debug'
      'uglify:debug'
      'concat:debug_js'
    ]
    
    # Watch for changes
    grunt.task.run 'watch'
  
  # Alias to `grunt jekyll:server`
  grunt.registerTask 'server', 'jekyll:server'

  grunt.registerTask 'scripts',   ['coffee:debug', 'browserify:debug', 'uglify:debug', 'concat:debug_js'] #Concatenar //Miniminzar //Concatenar minimizados
  
  # Run Jekyll build with environment set to production
  grunt.registerTask 'jekyll-production', ->
    grunt.log.writeln 'Setting environment variable JEKYLL_ENV=production'
    process.env.JEKYLL_ENV = 'production'
    grunt.task.run 'jekyll:build'
  
  # Compile and minify JS & CSS, run Jekyll build for production 
  grunt.registerTask 'build', [
    'clean:all'
    'less:build'
    'concat:build_css'
    'coffee:build'
    'browserify:build'
    'uglify'
    'concat:build_js'
    #'csslint'
    'jekyll-production'
    'uncss'
    'processhtml'
    'htmlmin'
    'cssmin'
    'imagemin'
    'clean:site'
  ]
  grunt.registerTask 'test', [
    'jekyll:server',
    'perfbudget'
  ]
  grunt.registerTask 'img', ['imagemin']
  grunt.registerTask 'default', ['debug']
