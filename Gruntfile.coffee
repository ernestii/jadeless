#global module:false

module.exports = (grunt) ->

# Project configuration.
  grunt.initConfig

    meta:
      version: '0.1.0',
      banner: '/*!\n * Salsa Beats - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * http://sapphiriq.ru/\n' +
        ' * Copyright (c) <%= grunt.template.today("yyyy") %>\n */\n'

    clean:
      build: ['build']
      release: ['release']

    copy:
      build:
        files:
          'build/img/': 'src/img/**'
          'build/js/':  'src/vendor/js/**'
# 'build/css/': 'src/vendor/css/**'
      release:
        files:
          'release/': 'build/**'

    pug:
      build:
        options:
          pretty: true
        files: grunt.file.expandMapping(["src/*.pug"], "build",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/src/, '').replace(/\.pug/, ".html")
        )


    coffee:
      build:
        files: grunt.file.expandMapping(["src/coffee/**/*.coffee"], "build/js/",
          rename: (destBase, destPath) ->
            destBase + destPath.replace(/src\/coffee/, '').replace(/\.coffee$/, ".js")
        )

    less:
      build:
        options:
          compress: false

        files:
          "build/css/style.css": "src/less/style.less"

      release:
        options:
          compress: true

        files:
          "release/css/style.css": "src/less/style.less"

    bower:
      build:
        dest: "build/js/plugins/"
        options:
          expand: true


# lint: {
#   files: ['grunt.js', 'src/**/*.js', 'test/**/*.js']
# },

# qunit: {
#   files: ['test/**/*.html']
# },

    watch:
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee:build']

      less:
        files: ['src/less/**/*.less']
        tasks: 'less:build'

      pug:
        files: ['src/pug/**/*.pug']
        tasks: 'jade:build'

      js:
        files: ['src/vendor/js/**/*.js']
        tasks: 'copy:build'

      css:
        files: ['src/vendor/css/**/*.css']
        tasks: 'copy:build'

      img:
        files: ['src/img/**/*']
        tasks: 'copy:build'

# jshint: {
#   options: {
#     curly: true,
#     eqeqeq: true,
#     immed: true,
#     latedef: true,
#     newcap: true,
#     noarg: true,
#     sub: true,
#     undef: true,
#     boss: true,
#     eqnull: true,
#     browser: true
#   },
#   globals: {
#     jQuery: true
#   }
# },

    concat:
      dist:
        options:
          banner: '<%= meta.banner %>'
        src:  'release/js/app.js'
        dest: 'release/js/app.js'

    uglify:
      app:
        options:
          banner: '<%= meta.banner %>'
        files:
          'release/js/app.js': ['<%= concat.dist.dest %>']


  grunt.loadNpmTasks 'grunt-contrib-pug'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.loadNpmTasks 'grunt-bower'

  # Default task.
  grunt.registerTask 'default', ['copy:build', 'pug', 'coffee', 'less:build', 'bower']
  grunt.registerTask 'build',   'default'

  grunt.registerTask 'release', ['build', 'copy:release', 'less:release', 'concat', 'uglify']

  connect = require 'connect'

  grunt.registerTask "server", "Start a custom static web server.", ->
    grunt.log.writeln "Starting static web server in \"build\" on port 8080."
    connect(connect.static("build")).listen 8080
    grunt.task.run('default')
    grunt.task.run('watch')