🐲 Know thy enemies and I shall detroy them

## Getting Started

### Prerequisites

* A Unix-like OS environment (Mac/Linux) w/ administrative privileges

## Using distraction-destroyer (DD)

### Overview

In its current form, DD is just a fun, lightweight solution for blocking time-wasting sites in your web browser by pointing them at the loopback address[²](#ref2) (127.0.0.1) in your OS's ```/etc/hosts``` file which causes them to fail.

* ***Convenient*** - ***edit*** targets or ***unblock*** them from within DD
* ***Automatic*** - DD will do its job automatically and then close — no user input required
* ***Intuitive*** - If a site is already blocked, it will stay blocked.  Same goes for unblocking
* ***Simple*** - DD uses a dead-simple process for blocking sites that has been around forever

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



<!-- 
If your hosts file is not /etc/hosts then change it
If bash isn't /bin/bash then change it
Alternative to: selfcontrolapp.com
Sharing: /r/nosurf /r/productivity /r/ADHD
 -->

### References
 * ¹ Hosts file (from Wikipedia):

> The hosts file is one of several system facilities that assists in addressing network nodes in a computer network. It is a common part of an operating system's Internet Protocol (IP) implementation, and serves the function of translating human-friendly hostnames into numeric protocol addresses, called IP addresses, that identify and locate a host in an IP network.

* ² <a name="ref2" href="https://en.wikipedia.org/wiki/Localhost">Loopback address</a>
