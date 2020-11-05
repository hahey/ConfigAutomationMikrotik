### Usage

#### Initial Configuration

First save your password in a file `.auth`.
```
   $ echo <your_password> > .auth
```

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

- getting the starting idnum as an optional input parameter
- add requirement installation in readme - sshpass iwlist etc.
- readable usage document and motivation, usage limits (24 devices in parallel to 10 batches)
- display full mac address and id pair
- fix script for the WAP AC device using the mesh protocol
