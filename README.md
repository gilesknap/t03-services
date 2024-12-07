# t03 IOC Instances and Services

This repository holds the a definition of t03 IOC Instances and services. Each sub folder of the `services` directory contains a helm chart for a specific service or IOC.

# Network Host not Required

This repo runs a PVA and CA gateway service in the cluster. And creates a service that exposes the CA and PVA gateway on ports 9064 and 9065 respectively.

The `opi/lauch-phoebus.sh` script configures phoebus to connect to the gateway services.

# Configuration at DLS

Go look in the dashboard for the IP address of the service called gateways and replace localhost with that IP address in the phoebus configuration `opi/settings.ini`.


# Configuration outside of DLS

This will also work from a VPN outside of DLS.

You will need to run an ssh tunnel as the required ports do not traverse the VPN.

```bash
rm nohup.out
nohup ssh hgv27681@i16-ws001 sleep infinity \
      -L 9065:172.23.168.200:9065  -L 9064:172.23.168.200:9064 &
```

replace:
- hgv27681       - your fedid
- i16-ws001      - any DLS workstation you can ssh to (localhost if you are in DLS)
- 172.23.168.200 - the IP address of the service in the cluster.

This will work even if you are outside of diamond on a VPN.

