+++
date = "2015-01-22 18:21:31+00:00"
title = "Finding the device name of the root partition"
type = "post"
+++

I thought this could be useful for someone trying to figure out the device name that a certain directory belongs to. In this example I am using /

<!--more-->

```bash
ROOT_PART=$(echo /dev/$(lsblk -P | grep -i "mountpoint=\"/\"" | awk '{print $1}' | cut -d "=" -f2 | sed -e 's/^"//' -e 's/"$//'))
```
If lsblk isn't available for some reason you can also use df and awk:

```bash
ROOT_PART=$(df / | awk '/^\/dev/ {print $1}')
```
