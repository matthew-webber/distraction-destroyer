# distraction-destroyer 🕉

🐲 Vanquish the enemies of focus and get back to what matters...

In other words, use this script to:
* block distracting sites by pointing them at the loopback address in your OS's ```/etc/hosts``` file
* unblock / remove sites added to ```/etc/hosts```
* edit the list of sites to block in a minimal .txt file

![dd_demo](https://user-images.githubusercontent.com/37313243/135770532-f3fa0213-f5f9-4ae9-b766-0edd2dd032c4.gif)
 
## Overview

* [Installation](#installation)
* [Create a shortcut](#create-a-shortcut)
* [Using distraction-destroyer (DD)](#using-distraction-destroyer-dd)
* [What it does](#what-it-does)
* [Who it's for](#who-its-for)
* [Philosophy](#philosophy)
* [References](#references)

## Installation

```
cd ~
git clone https://github.com/matthew-webber/distraction-destroyer.git
```

Alternatively, you can install by downloading the project ZIP

1. Navigate to the top of this page and click 'Code' > 'Download ZIP'
2. Save the file as-is in your [home folder](https://nektony.com/blog/mac-home-folder#1)
3. Rename the unzipped project folder as ```distraction-destroyer```.
<img width="389" alt="Project ZIP location" src="https://user-images.githubusercontent.com/37313243/135775500-eb61acd0-5771-448c-92f2-5d13a3b31986.png">

## Create a shortcut

_**Note: after installing, it is highly recommended to create an alias (shortcut) to distraction-destroyer in your ~/.zshrc or ~/.bashrc file.**_

Creating an alias (shortcut) to **distraction-destroyer** will allow you to quickly block sites from anywhere in the terminal (i.e. without being in the project root directory).  You can do so by copy+pasting the below into your terminal.

#### zsh (macOS 10.15 Catalina or later)
```zsh
echo -e "#distraction-destroyer shortcut (https://github.com/matthew-webber/distraction-destroyer)\nalias distraction-destroyer='sudo ~/distraction-destroyer/distraction-destroyer.sh'" >> ~/.zshrc && zsh
```

#### bash (Linux, macOS 10.14 Mojave or earlier)
```bash
echo -e "#distraction-destroyer shortcut (https://github.com/matthew-webber/distraction-destroyer)\nalias distraction-destroyer='sudo ~/distraction-destroyer/distraction-destroyer.sh'" >> ~/.bashrc && bash
```

## Using distraction-destroyer (DD)

_**Before you start:**_ It is recommended that you create an alias to run distraction-destroyer from the terminal without being in the project root.  See [Create a shortcut](#create-a-shortcut) above.

---
### 🙅‍♂️ Blocking sites

* When you run ```distraction-destroyer.sh``` from the Terminal, the script will run automatically.  DD will initiate a short countdown before adding each site listed in ```targets.txt``` to your hosts file and flushing the DNS cache to wrap-up the process.

### 🔓 Unblocking sites

* DD can "resurrect" / unblock sites for you by simply pressing ```r``` during the opening countdown.  Of course, you can always edit your hosts file yourself at ```/etc/hosts``` and remove the lines below the line ```# distraction-destroyer graveyard (blocked sites)```.

### 📝 Editing target sites

* Each target should be listed in the ```targets.txt``` file as "example.com" (i.e. with the domain and top-level domain only) separated by a new line.  No need for 'www' — DD takes care of that for you. 

* Editing targets is easy.  Either:
  * a) press ```e```* during the countdown, or
  * b) change the ```targets.txt``` file using a text editor

\* _(uses **nano** so remember to save your changes by pressing ```ctrl + x``` , ```y```)_

---

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



---

🐲 Stay focused, hero...

---

<details>
<summary id="references">References</summary>
<p>
 
 * ¹ Hosts file (from Wikipedia):

> The hosts file is one of several system facilities that assists in addressing network nodes in a computer network. It is a common part of an operating system's Internet Protocol (IP) implementation, and serves the function of translating human-friendly hostnames into numeric protocol addresses, called IP addresses, that identify and locate a host in an IP network.

* ² <a name="ref2" href="https://en.wikipedia.org/wiki/Localhost">Loopback address</a>

</p>
</details>  
