lxcexp
======
This is an experiment for running many, many VEs (Virtual Environments) inside Linux containers. Run all as **su**.

## Prerequisites ##
Everything here is tested on Ubuntu 12.04, using version *0.9.0.0~staging~20130619-1813-0ubuntu1~ppa1~precise1* of lxc.
First install the latest version of lxc:

```Shell
sudo add-apt-repository ppa:ubuntu-lxc/daily
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install lxc-dev
```

## Running ##
NEW: added in local network support-- the VEs each get a virtual network interface (veth) that is bridged 
with the veth of every other VE.  Use *veconfig.nonet* to go back to each VE using only the loopback network interface.

1. `lxcexp_createbase.sh` -- Creates the base ubuntu image as /var/lib/lxc/ve0, modified to use 
   a separate APT proxy and run a custom init script. Copies in a custom loopback-only config file.
   NEW: copies *config.network.sh*, a script responsible for adding the virtual interface created for each VE 
   to the bridge vebr.
2. `lxcexp_setup.sh N`    -- Create a 2G tmpfs on /exp, full copies the base image as /exp/vbase,
   copy-on-write clone vbase to ve1, ve2, ..., veN using overlayfs. Will sleep for a period between lxc-start's.
   NEW: creates the bridge vebr
3. `lxcexp_start.sh [S] [E]`    -- Starts the N VEs in the background. After the VEs bring their lo network interface up,
   they will make a number of pings to localhost, and [disabled] poweroff. Optional: S and E are the start and end # of the VEs
   NEW: after the VE starts up its network interface, the script *config.network.sh* runs
4. *`lxcexp_info.sh [S] [E]`     -- Gives the current state of all N VEs, including how many pings they performed.
   Do not use if there are a lot of VEs; it will print several lines to the terminal for each VE.
5. `lxcexp_takedown.sh` -- Destroy the N VEs in the tmpfs forcefully, unmount the tmpfs file system.
   NEW: takes down the bridge brve
6. *`lxcexp_stats.sh [S] [E]`     -- Gives a few key summary statistics of all the VEs.  Very useful.
7. To kill the base VE, run `lxc-destroy -n ve0`

If all else fails, run `killall lxc-start -9`.

Hardcoded things that might be of interest to change:

* To not use the cache when creating the base, add the -F option. Use -S to inject a public SSH key.
* Change the lxcexp.conf file to change the number of pings before shutdown (180 as of writing).


## Results ##

	Disk Usage of VEs: 138M /exp
	Total VEs        : 1000
	180-ping VEs     : 704
	Incomplete VEs   : 0
	No log file VEs  : 296
	704 VEs have a PID

## Future ##
In the future, provide safety in /exp directory by only usig the directories that begin with 've'.
Add `nice`.

Bugs discovered in lxc (perhaps fixed in a later development build):

* lxc-destroy -f does not kill the lxc processes running, though it will remove their file system
* lxc-monitor doesn't work with regular expressions

