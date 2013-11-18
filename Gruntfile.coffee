module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')

    coffeelint:
      app: ['test/*.coffee']

    shell:
      build:
        command: "coffee -o ./src/js -c ./src/coffee/"
        options:
          failOnError: true
      push:
        command: "git push origin master"
        options:
          failOnError: true
      publish:
        command: "npm publish ."
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
      watch:
        command: "coffee -w -o ./src/js -c ./src/coffee/*.coffee"
        standardOut: true
        standardError: true
        options:
          failOnError: true
  )

  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask('test',    ['shell:testAllCoffee', 'shell:testAllJs'])
  grunt.registerTask('build',   'shell:build')
  grunt.registerTask('watch',   'shell:watch')
  grunt.registerTask('push',    'shell:push')

  grunt.registerTask('publish', ['build', 'test', 'push', 'shell:publish'])

  grunt.registerTask('default', ['coffeelint', 'test'])
