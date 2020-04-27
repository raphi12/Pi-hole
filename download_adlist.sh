#!/bin/sh
# download adblock lists
curl -s -L https://easylist-downloads.adblockplus.org/easylist.txt https://easylist-downloads.adblockplus.org/malwaredomains_full.txt https://easylist-downloads.adblockplus.org/easylistgermany.txt https://easylist-downloads.adblockplus.org/easyprivacy.tpl https://easylist-downloads.adblockplus.org/antiadblockfilters.txt https://easylist-downloads.adblockplus.org/liste_fr.txt > adblock.unsorted

# look for:  ||domain.tld^
sort -u adblock.unsorted | grep ^\|\|.*\^$ | grep -v \/ > adblock.sorted

# remove extra chars
sed 's/[\|^]//g' < adblock.sorted > adblock.hosts

# remove files we no longer need
rm adblock.unsorted adblock.sorted
mv adblock.hosts /var/www/html/
pihole -g

