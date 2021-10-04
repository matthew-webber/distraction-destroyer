# distraction-destroyer 🕉

🐲 Vanquish the enemies of focus and get back to what matters...

In other words, use this script to:
* block distracting sites by pointing them at the loopback address in your OS's ```/etc/hosts``` file
* unblock / remove sites added to ```/etc/hosts```
* edit the list of sites to block in a minimal .txt file

<p align="center"><img src="https://user-images.githubusercontent.com/37313243/135770532-f3fa0213-f5f9-4ae9-b766-0edd2dd032c4.gif"></p>
 
## Overview

* [Installation](#installation)
* [Create a shortcut](#create-a-shortcut)
* [Using distraction-destroyer (DD)](#using-distraction-destroyer-dd)
* [What it does](#what-it-does)
* [Who it's for](#who-its-for)
* [Philosophy](#philosophy)
* [Install WSL for Windows](#install-wsl-for-windows)
* [References](#references)

## Installation
### 🖥 Mac/Linux
```bash
cd ~
git clone https://github.com/matthew-webber/distraction-destroyer.git
# ...

sudo ./distraction-destroyer/distraction-destroyer.sh
```

Alternatively, you can install by downloading the project ZIP

1. Navigate to the top of this page and click 'Code' > 'Download ZIP'
2. Save the file as-is in your [home folder](https://nektony.com/blog/mac-home-folder#1)
3. Rename the unzipped project folder as ```distraction-destroyer```.
<p align="center"><img width="389" alt="Project ZIP location" src="https://user-images.githubusercontent.com/37313243/135775500-eb61acd0-5771-448c-92f2-5d13a3b31986.png"></p>

### 💾 Windows - _**requires [WSL 1 / WSL 2](https://docs.microsoft.com/en-us/windows/wsl/about)**_

**If WSL is installed**, open one of the below **as administrator**:
* _Command Prompt_
* _Powershell_
* _Windows Terminal_ (bonus: emoji support 👍)
```bash
bash # will start the Bash terminal
cd ~
git clone https://github.com/matthew-webber/distraction-destroyer.git
# ...

sudo ./distraction-destroyer/distraction-destroyer.sh
```

**If WSL is _not_ installed**, see ["Install WSL for Windows"](#install-wsl-for-windows)

## Create a shortcut

_**Note: after installing, it is highly recommended to create an alias (shortcut) to distraction-destroyer in your ~/.zshrc or ~/.bashrc file.**_

Creating an alias (shortcut) to **distraction-destroyer** will allow you to quickly block sites from anywhere in the terminal (i.e. without being in the project root directory).  You can do so by copy+pasting the below into your terminal.

#### zsh (_macOS 10.15 Catalina or later_)
```zsh
echo -e "#distraction-destroyer shortcut (https://github.com/matthew-webber/distraction-destroyer)\nalias distraction-destroyer='sudo ~/distraction-destroyer/distraction-destroyer.sh'" >> ~/.zshrc && zsh
```

#### bash (_macOS 10.14 Mojave or earlier, Linux, Windows WSL 1 / WSL 2_)
```bash
echo -e "#distraction-destroyer shortcut (https://github.com/matthew-webber/distraction-destroyer)\nalias distraction-destroyer='sudo ~/distraction-destroyer/distraction-destroyer.sh'" >> ~/.bashrc && bash
```

## Using distraction-destroyer (DD)

_**Before you start:**_ It is recommended that you create an alias to run distraction-destroyer from the terminal without being in the project root.  See [Create a shortcut](#create-a-shortcut) above.

_**To run DD after installation**_:
```bash
# No alias/shortcut
sudo ./distraction-destroyer/distraction-destroyer.sh

# Shortcut/alias
sudo distraction-destroyer
```

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

In its current form, DD is just a fun, lightweight solution for blocking time-wasting sites in your web browser by pointing them at the loopback address[¹](#ref1) (127.0.0.1) in your OS's ```/etc/hosts``` file which causes them to fail.[²](#ref2)

* ***Convenient*** - ***edit*** targets or ***unblock*** them from within DD
* ***Automatic*** - DD will do its job automatically and then close — no user input required
* ***Intuitive*** - If a site is already blocked, it will stay blocked.  Same goes for unblocking
* ***Simple*** - DD uses a dead-simple process for blocking sites that has been around forever

## Who it's for

DD is designed to be a simple tool for computer users of all backgrounds who like to get shit done.  Sufferers of ADD/ADHD, students, professionals, or anyone who falls victim to mindless web-browsing when they get stuck in their work may find this project useful.

## Philosophy

DD can be considered an alternative to popular "blocking apps" like the ironically named [SelfControl](https://github.com/SelfControlApp/selfcontrol) but with respect towards a user's autonomy.  DD won't stop you from going around it or undoing your changes (but it might give you a hard time!)

The goal is to simply block the **initial** attempt to visit a trouble site in the hopes that your dopamine-hungry brain "snaps out of it" before you get sucked into mindless browsing.  If you actually need to visit the site, just [unblock](#what-it-does) it.

## Install WSL for Windows
You can use DD by installing the "Windows Subsystem for Linux" (WSL) which allows you to run Linux commands and interact with the Windows OS.  While setup is a bit tedious and includes system resource overhead, the benefit is in knowing that running Linux for Windows is a safe, native solution supported by Microsoft.  

The below are simplified instructions for installing the minimum amount of Linux (WSL 1) required to run DD along with a Linux Distro (the most popular distro in this case, Ubuntu).<a href="#shortcut-install">†</a>  Full instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install)

1. In the "Turn Windows features on or off" (Control Panel\Programs\Programs and Features) window, enable "Windows Subsystem for Linux"
2. Reboot
3. Install and run "Ubuntu" (or any other Linux distro) from the Microsoft Store app and create your username and password
4. Close Ubuntu

🎉 Congrats!  You've installed WSL! 🎉 

🐲 Now back to [installing DD for Windows](#installation)...

---

<p id="shortcut-install"><em>† If you have the space on your machine, don't care about minimal installs, or just want the easy way: open Powershell as administrator and run the below which will install all of the above in addition to the "Virtual Machine Platform" (WSL2)</em></p>

```
wsl --install
```

---

🐲 Stay focused, hero...

---

<details>
 <summary id="references">References</summary>
<p>
 
¹ <a id="ref1" href="https://en.wikipedia.org/wiki/Localhost">Loopback address</a> (Wikipedia)
 
² <a id="ref2" href="https://en.wikipedia.org/wiki/Hosts_(file)#Extended_applications">Blocking internet resources</a> (ibid.)
</p>
</details>  
