# demo of portable opi

The startup script will launch phoebus and point it at t03 beamline from anywhere including a non DLS machine on a VPN.

## Prerequisites

Copy up the synoptic to epics-opis service

```bash
# use tab completion of 'epics-opi' to get the pod name
kubectl cp -n hgv27681 opi/t03-beamline.bob epics-opis-7b7cf64697-cmw4z:/usr/share/nginx/html/
```

