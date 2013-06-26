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
   ve1, ve2, ..., veN using overlayfs.
3. `lxcexp_start.sh N`    -- Starts the N VEs in the background. After the VEs bring their lo network interface up,
   they will make a number of pings to localhost, and poweroff.
4. `lxcexp_info.sh N`     -- Gives the current state of all N VEs, including how many pings they performed.
5. `lxcexp_takedown.sh N` -- Destroy the N VEs in the tmpfs forcefully, unmount the tmpfs file system.
6. To kill the base VE, run `lxc-destroy -n ve0`

Hardcoded things that might be of interest to change

* To not use the cache when creating the base, add the -F option. Use -S to inject a public SSH key.
* Change the lxcexp.conf file to change the number of pings before shutdown (180 as of writing).

In the future, look into getting the names of the VE instances by doing an `ls /exp` instead of taking a 
command-line argument.