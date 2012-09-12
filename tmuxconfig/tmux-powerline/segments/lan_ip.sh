#!/usr/bin/env bash
# Prints the local network IP address for a staticly defined NIC or search for an IP address on all active NICs.

# TODO fix the mac part so it also can search for interfaces like the Linux one can.

lan_ip=$(ipconfig getifaddr en0)
if [ -n "$lan_ip" ]; then

	#echo "Ⓛ ${lan_ip}"
	echo "ⓛ ${lan_ip}"
	exit 0
else
	echo "derr"
  exit 1
fi
