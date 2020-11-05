### Usage

The current script is using the default network interface as `wlp1s0`. If you are using another one in your computer please replace the command `sudo iwlist wlp1s0 scan` in `ssidconnect.sh` with your default network interface. (Its automatic recognition is in future todo.) You can figure out your wifi interface by `ip link show`.

First save your password in a file `.auth`.
```
   $ echo <your_password> > .auth
```

```
   $ \.ssidconnect.sh STREET FLOOR TEMPLATE
```

For example,

```
   $ \.ssidconnect.sh seehausener 9 wap_ac_bridge_static
```

or

```
   $ \.ssidconnect.sh seehausener 4 wap
```

### To Dos

- rename shell script
- getting the starting idnum as an optional input parameter
- detecting default network interface and change in the code
- readable usage document and motivation, usage limits (24 devices in parallel to 10 batches)
- display full mac address and id pair
- fix script for the WAP AC device using the mesh protocol
