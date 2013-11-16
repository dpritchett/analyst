module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')

    coffeelint:
      app: ['app/*.coffee', 'test/*.coffee']

    shell:
      build:
        command: "coffee -w -o ./src/js -c ./src/coffee/"
        options:
          failOnError: true
      testAllCoffee:
        command:     "ls ./test/*.coffee | xargs -n1 coffee"
        options:
          failOnError: true
      testAllJs:
        command:     "ls ./test/*.js | xargs -n1 node"
        options:
          failOnError: true
  )

  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask('test',    ['shell:testAllCoffee', 'shell:testAllJs'])
  grunt.registerTask('build',    ['shell:build'])

  grunt.registerTask('default', ['coffeelint', 'test'])
