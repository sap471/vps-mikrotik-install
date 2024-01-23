# Auto Install CHR Mikrotik on VPS

## How to Use

```
curl -fsSL https://raw.githubusercontent.com/joradvoo/vps-mikrotik-install/main/install.sh | sudo bash
```

shutdown manually from vps ui, then turn on it

### Caution !!!
I already test anything to set password on boot, but it can't. so after vps turn on, you must be change the password and user. otherwise you know what will happen :)

Tested : 
- Upcloud (work with autorun script)
- Linode **(NOT WORK)**
- Vultr thanks to [wangzhiyong2019](https://github.com/sap471/vps-mikrotik-install/issues/1)

Not Tester :
- Digital Ocean
