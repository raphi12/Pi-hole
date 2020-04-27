#!/bin/bash

#get youtube ad domains from log db
sudo sqlite3 -csv /etc/pihole/pihole-FTL.db "select domain from queries where domain like'%googlevideo%';" >> youtube.unsorted

#sort and remove duplicates
sort -u youtube.unsorted > youtube.sorted

sed '/redir/d; s/[\|^]//g; /mani/d; /^$/d' < youtube.sorted > youtube.hosts

# move file to web directory
mv youtube.hosts /var/www/html/youtube.hosts

# remove not used files
rm youtube.sorted

#update pihole lists
pihole -g

