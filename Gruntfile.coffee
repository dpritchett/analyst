module.exports = (grunt) ->
  grunt.initConfig \
    shell:
      testAll:
        command:     "ls ./test/*.coffee | xargs -n1 coffee"
        options:
          stdout:      true
          failOnError: true

  grunt.loadNpmTasks('grunt-shell')

  grunt.registerTask('default', ['shell:testAll'])
