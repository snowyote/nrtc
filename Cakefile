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
  ", (err, output) ->
    throw err if err
    console.log output

task "build", "compile client-side javascript", ->
  exec "./node_modules/.bin/browserify entry.coffee
   | ./node_modules/.bin/jsmin
    > client.js
  ",
    (err, output) ->
      throw err if err
      console.log output
