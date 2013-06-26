lxcexp
======
This is an experiment for running many, many VEs (Virtual Environments) inside Linux containers. Run all as **su**.

## Prerequisites ##
Everything here is tested on Ubuntu 12.04.
First install the latest version of lxc:

```Shell
sudo add-apt-repository ppa:ubuntu-lxc/daily
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install lxc-dev
```

## Running ##

1. `lxcexp_createbase.sh` -- Creates the base ubuntu image, modified to use 
   a separate APT proxy and run a custom init script. Copies in custom loopback-only config file.
2. `lxcexp_setup.sh N`    -- Create a 2G tmpfs on /exp, copy-on-write clone the base VE into 
   ve1, ve2, ..., veN using overlayfs. Will sleep for a period between lxc-start's.
3. `lxcexp_start.sh`    -- Starts the N VEs in the background. After the VEs bring their lo network interface up,
   they will make a number of pings to localhost, and poweroff.
4. *`lxcexp_info.sh`     -- Gives the current state of all N VEs, including how many pings they performed.
   Do not use if there are a lot of VEs; it will print several lines to the terminal for each VE.
5. `lxcexp_takedown.sh` -- Destroy the N VEs in the tmpfs forcefully, unmount the tmpfs file system.
6. *`lxcexp_stats.sh`     -- Gives a few key summary statistics of all the VEs.  Very useful.
7. To kill the base VE, run `lxc-destroy -n ve0`

Hardcoded things that might be of interest to change

* To not use the cache when creating the base, add the -F option. Use -S to inject a public SSH key.
* Change the lxcexp.conf file to change the number of pings before shutdown (180 as of writing).

In the future, provide safety in /exp directory by only usig the directories that begin with 've'.

## Results ##
Disk Usage of VEs: 138M /exp
Total VEs        : 1000
180-ping VEs     : 704
Incomplete VEs   : 0
Failed-to-start  : 296

