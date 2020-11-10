### Motivation

This script is written to automatically configure many MikroTik routerboards as access point at once per batch. This is a part of the project installing WiFi for refugee homes in Berlin : `Projekt: "WLAN in Unterkünften Geflüchteter"`. I'm participating the project with b2social e.V. and Freifunk Berlin.

### Usage

#### Preparation

First save your password for access points in a file `.auth`.
```
   $ echo <your_password> > .auth
```
The same password file will be used for initializing configuration and updating configuration.

To satisfy the requirements of the configuration scripts in debian-based linux systems:

```
   $ sudo apt install iwconfig iproute2 network-manager openssh-client gettext-base sshpass
```

#### Initial Configuration

Then run:

```
   $ ./initial_config.sh STREET FLOOR TEMPLATE (-i=NUMBER)
```

The identity of each access point will be assigned as `<STREET>-<FLOOR><IDNUM>`. `IDNUM` is a number
starting from `NUMBER` in the `-i` option. If `-i` option is not given, it starts from 1.
`TEMPLATE` is the name of Mikrotiks RouterOS scripts that you can find in the `scripts` folder. The following scripts are provided:

   - `wap`: the configuration for a wAP device with a static IP
   - `wap_ac_bridge`: the configuration for a wAP ac device with a DHCP client
   - `wap_ac_bridge_static`: the configuration for a wAP ac device with a static IP
   - `wap_ac_mesh`: the configuration for a wAP ac device with a DHCP client and a HWMP mesh protocol, 2.4Ghz for client connections and 5Ghz for dynamic wds mesh

For the script configured for static IPs the device with the identity `<STREET>-<FLOOR><IDNUM>` will have an IP address ending with `<IDNUM><FLOOR>`.
This means that you can configure 24 access points (numbering between 1 and 24) at once per `FLOOR` for total 10 `FLOOR`s (numbering between 0 and 9).
`FLOOR` is just the identity of each batch when we are configuring access points per batch - if it has a DHCP client, it doesn't need to be a number.

For example,

```
   $ ./initial_config.sh seehausener 9 wap_ac_bridge_static
```

or

```
   $ ./initial_config.sh seehausener 4 wap
```

Or if the above script was stopped after it had finished configuring first 5 devices and you want to still continue the configuration in the same batch (`FLOOR`).
```
   $ ./initial_config.sh seehausener 4 wap -i=5
```
Currently the script prints out the pair of the identity and the last three octets of the mac address per device during the configuration. One can therefore figure out the new IP address of the device if it is configured with a static IP.

#### Updating configurations

Run:

```
   $ ./update_config.sh TEMPLATE FIRST_THREE_OCTET LAST_OCTET [LAST_OCTET ..]
```

This script will iteratively connect to the list of ip addresses with `<FIRST_THREE_OCTET>.<LAST_OCTET>` and run the `TEMPLATE` script in the `script` folder.

### To Dos

- display full mac address and id pair
- fix the mesh script so that it can connect from the webfig
