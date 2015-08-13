IP Collector
========

A small script to intercept incoming network traffic and record it in a mysql database.

##Schema##
I haven't provided the mysql build script because I am lazy. I will do it later.
The schema structure requires:

* `source` - source ip  
* `source_port` - source port 
* `destination` - destination ip
* `destination_port` - destination port 
* `pack_size` - size of the latest packet if constrained. Size of the packet if not.
* `packet_count` - if constrained, count of all the packets.

##I recommend...##
* Define a mysql constraint on ip (both incoming and outgoing), unless seeing every network packet is necessary.
* For the love of god, only put this on a local database. Recording to an external db will create a condition where you're recoding every transaction both to the db and incoming/outgoing traffic. It's just bad, and your server could melt in the rack/On your desk.

##Also##
* For every transaction, you're going to see two entries: one for all the packets coming in, one for all the packets going out.
* Don't get paranoid if you don't recognize every ip. I've noticed in practice that much of the unrecognized packets are ntp connections.
* If you can't rationally justify the connection, and your machine is pretty isolated, then get paranoid.


##License##
Just [do whatever the fuck you want](http://www.wtfpl.net)...
(c) 2015 Kelly Huberty