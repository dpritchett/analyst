module.exports = (grunt) ->
  grunt.initConfig \
    shell:
      testAllCoffee:
        command:     "ls ./test/*.coffee | xargs -n1 coffee"
        options:
          failOnError: true
      testAllJs:
        command:     "ls ./test/*.js | xargs -n1 node"
        options:
          failOnError: true

  grunt.loadNpmTasks('grunt-shell')

  grunt.registerTask('test',    ['shell:testAllCoffee', 'shell:testAllJs'])
  grunt.registerTask('test',    ['shell:testAllCoffee', 'shell:testAllJs'])

  grunt.registerTask('default', ['test'])
