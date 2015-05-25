+++
date = "2014-09-18 04:18:47+00:00"
title = "Raspberry Pi WiFi Setup"
type = "post"
+++

I just recently ordered a Raspberry Pi Model B+ (yay!) and ordered an Edimax EW-7811Un WiFi dongle to go with it. Here's how to set it up on Raspbian.

<!--more-->

	
1. Make your ```/etc/network/interfaces``` look like this:

	```bash
	auto lo

	iface lo inet loopback
	iface eth0 inet dhcp

	allow-hotplug wlan0
	iface wlan0 inet manual
	wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
	iface default inet dhcp
	```
	
2. Make your ```/etc/wpa_supplicant/wpa_supplicant.conf``` look like this:

	```bash
	ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
	update_config=1

	network={
	ssid="whyfi"
	psk="yourpassword"
	}
	```
	
3. ```sudo ifdown wlan0```

4. ```sudo ifup wlan```


This assumes everything will work for you the way it did for me. My network is a WPA2-Personal network and only setting said and psk with wpa_supplicant did the job.
