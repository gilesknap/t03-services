# t03 IOC Instances and Services

This repository holds the a definition of t03 IOC Instances and services. Each sub folder of the `services` directory contains a helm chart for a specific service or IOC.

These services are running in giles' namespace on pollux: hgv27681

# Network Host not Required

This repo runs a PVA and CA gateway service in the cluster. And creates a service that exposes the CA and PVA gateway on ports 9064 and 9065 respectively.

The `opi/lauch-phoebus.sh` script configures phoebus to connect to the gateway services.

# Configuration outside of DLS

This will also work from a VPN outside of DLS.

You will need to run an ssh tunnel as the required ports do not traverse the VPN. Run this in a separate terminal and leave it running. If you have ssh keys setup you can run this in the background with "nohup command_below &".

```bash
ssh YOUR FED_ID@YOUR_WORKSTATION sleep infinity \
    -L 9065:172.23.168.200:9065  -L 9064:172.23.168.200:9064 &
```

Tell the phoebus launcher that you are using a tunnel:

```bash
TUNNEL=1 ./opi/launch-phoebus.sh
```

