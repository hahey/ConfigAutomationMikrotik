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

Then try to run:

```
   $ \.initial_config.sh STREET FLOOR TEMPLATE
```

For example,

```
   $ \.initial_config.sh seehausener 9 wap_ac_bridge_static
```

or

```
   $ \.initial_config.sh seehausener 4 wap
```


### To Dos

- readable usage document and motivation, usage limits (24 devices in parallel to 10 batches)
- display full mac address and id pair
- fix the mesh script so that it can connect from the webfig
