{exec} = require "child_process"

REPORTER = "spec"

task "test", "run tests", ->
  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/test_helper.coffee
    --colors
    --recursive
  ", (err, output) ->
    console.log output
    throw err if err

task "build", "compile client-side javascript", ->
  exec "./node_modules/.bin/browserify client.coffee
   | ./node_modules/.bin/jsmin
    > client.js
  ",
    (err, output) ->
      throw err if err
