#!/bin/sh
. /lib/functions.sh

keysrv="http://setup.guetersloh.freifunk.net"

hostname=$(uci get system.@system[0].hostname)
mac=$(/sbin/ifconfig eth0 | /usr/bin/awk '/HWaddr/ {print $NF;}')

pubkey=$(/etc/init.d/fastd show_key mesh_vpn)

regdone=$(uci get fastdreg.ffgt.regdone)

if [ "$regdone" -ne "1" ]; then
       # Bloody v4/v6 issues ... From an IPv4-only upstream, 
       # the preferred IPv6 AAAA record results in connection errors.
       USEIPV4=1
       USEIPV6=0
       /bin/ping -q -c 3 setup.ipv4.guetersloh.freifunk.net >/dev/null 2>&1
       if [ $? -ne 0 ]; then
                USEIPV4=0
                /bin/ping -q -c 3 setup.guetersloh.freifunk.net >/dev/null 2>&1
                if [ $? -eq 0 ]; then
                        USEIPV6=1
                fi
        fi
        if [ $USEIPV4 -eq 1 ]; then
                IPVXPREFIX="ipv4."
        else
                IPVXPREFIX=""
        fi
        keysrv="http://setup.${IPVXPREFIX}guetersloh.freifunk.net"
        
	reg=$(wget -T15 "$keysrv/fastdreg.php?mac=$mac&key=$pubkey&name=$hostname" -O -)
	if [ "$reg" == "regdone" ]; then
		uci set fastdreg.ffgt.regdone=1
		uci commit
	fi
fi
