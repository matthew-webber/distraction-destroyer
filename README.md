# distraction-destroyer 🕉

🐲 Vanquish the enemies of focus and get back to what matters...

(in other words, quickly block/unblock/edit distracting sites by pointing them at the loopback address in your OS's ```/etc/hosts``` file)

![dd_demo](https://user-images.githubusercontent.com/37313243/135770532-f3fa0213-f5f9-4ae9-b766-0edd2dd032c4.gif)

* 
* 
## Overview

* [Installation]
* [Using distraction-destroyer (DD)]
* [What it does]
* [Who it's for]
* [Philosophy]


```bash
# Example hosts file

# default stuff
...

# distraction-destroyer's graveyard (blocked sites)
127.0.0.1 facebook.com
127.0.0.1 www.facebook.com
127.0.0.1 reddit.com
127.0.0.1 www.reddit.com
```

## Using distraction-destroyer (DD)

### Blocking sites

1. run distraction-destroyer using ```sudo```
2. after a short countdown, dd runs automatically and blocks all sites listed in ```targets.txt```

### Unblocking sites

dd can "resurrect" / unblock sites for you by simply pressing ```r``` during the opening countdown, or you can always edit your ```/etc/hosts``` file yourself and remove the lines below ```#Distraction-Destroyer graveyard```

### Editing target sites

Each target should be listed in the ```targets.txt``` file as "example.com" (i.e. with the domain and top-level domain only) separated by a new line.

Editing targets is easy.  Either:
* a) change the ```targets.txt``` file using a text editor, or
* b) press ```e``` during the countdown* 

** (uses **nano** so remember to save your changes by pressing ```ctrl + x``` , ```y```)*

## What it does

In its current form, DD is just a fun, lightweight solution for blocking time-wasting sites in your web browser by pointing them at the loopback address[²](#ref2) (127.0.0.1) in your OS's ```/etc/hosts``` file which causes them to fail.

* ***Convenient*** - ***edit*** targets or ***unblock*** them from within DD
* ***Automatic*** - DD will do its job automatically and then close — no user input required
* ***Intuitive*** - If a site is already blocked, it will stay blocked.  Same goes for unblocking
* ***Simple*** - DD uses a dead-simple process for blocking sites that has been around forever

## Who it's for

DD is designed to be a simple tool for computer users of all backgrounds who like to get shit done.  Sufferers of ADD/ADHD, students, professionals, or anyone who falls victim to mindless web-browsing when they get stuck in their work may find this project useful.

## Philosophy

DD can be considered an alternative to popular "blocking apps" like the ironically named [SelfControl](https://github.com/SelfControlApp/selfcontrol) but with respect towards a user's autonomy.  DD won't stop you from going around it or undoing your changes (but it might give you a hard time!)

The goal is to simply block the **initial** attempt to visit a trouble site in the hopes that your dopamine-hungry brain "snaps out of it" before you get sucked into mindless browsing.  If you actually need to visit the site, just [unblock](#unblocking-sites) it.

<!-- 
If your hosts file is not /etc/hosts then change it
If bash isn't /bin/bash then change it
Sharing: /r/nosurf /r/productivity /r/ADHD
 -->

### References
 * ¹ Hosts file (from Wikipedia):

> The hosts file is one of several system facilities that assists in addressing network nodes in a computer network. It is a common part of an operating system's Internet Protocol (IP) implementation, and serves the function of translating human-friendly hostnames into numeric protocol addresses, called IP addresses, that identify and locate a host in an IP network.

* ² <a name="ref2" href="https://en.wikipedia.org/wiki/Localhost">Loopback address</a>
