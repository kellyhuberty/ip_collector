#! /bin/sh
# mysql-collect.sh
#(c) 2015 Kelly Huberty.
# Store to text file then to MySQL Database
ifconfig eth1 up
tcpdump -i eth1 -n -q -e | grep IPv4 | awk -F "[:, >]" {'print $24 " " $27 " " $22'} | awk -F "[. ]" '{
                if ($11 == "")
                print "\""$1"."$2"."$3"."$4"\",\"\",\""$5"."$6"."$7"."$8"\",\"\","$9
                else
                print "\""$1"."$2"."$3"."$4"\",\""$5"\",\""$6"."$7"."$8"."$9"\",\""$10"\","$11
               }' > /tmp/collect-eth1.txt &
tail -f /tmp/collect-eth1.txt | awk '{print " INSERT INTO IpCollector.packets (source, source_port, destination, destination_port, pack_size , packet_count) VALUES ("$line", 1) ON DUPLICATE KEY UPDATE packet_count = packet_count + 1, SET pack_size = pack_size + VALUES(pack_size);"}' | mysql -h 127.0.0.1 -u YourDataBaseName -YourDataBasePassword &


