nrtc
======

Node Realtime Chess is a game you can play with people on the inter-net.  It's kinda like chess but you can move a bunch of pieces at once

This is the 'game server', you set it up and it can host multiple games.  A site that will coordinate/allocate those games is coming in the near future.  Hurrrf

Example
-------

You start it up like so:

    bash-3.2$ npm install
    (huge barfy npm output elided)
    bash-3.2$ node_modules/.bin/coffee app.coffee
       info  - socket.io started
    Listening at http://localhost:3000/index.html?slot_id=512bb1b2f92338e95e000001
    Listening at http://localhost:3000/index.html?slot_id=512bb1b2f92338e95e000002
    Listening at http://localhost:3000/index.html?slot_id=512bb1b2f92338e95e000003
    Listening at http://localhost:3000/index.html?slot_id=512bb1b2f92338e95e000004

Then you open one of those urls and have one of your friends open the
same one (after replacing localhost obv).  Wham, you're playing Node
Real Time Chess.  Feels great don't it.

Tests
-----

    cake test
