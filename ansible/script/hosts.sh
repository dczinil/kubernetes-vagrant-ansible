#!/bin/bash
#
IP_NW="192.168.56."
#

i=10
while (($i<20))
do
  echo export K8S-ETCD-$i=$IP_NW$i 
  ((i++))
done


i=20
while (($i<30))
do
  echo export K8S-KAPI-$i=$IP_NW$i 
  ((i++))
done

i=30
while (($i<40))
do
  echo export K8S-KCM-$i=$IP_NW$i 
  ((i++))
done

i=40
while (($i<50))
do
  echo export K8S-KSC-$i=$IP_NW$i 
  ((i++))
done

i=50
while (($i<60))
do
  echo export K8S-WORKER-$i=$IP_NW$i 
  ((i++))
done

i=60
while (($i<70))
do
  echo export K8S-LB-$i=$IP_NW$i 
  ((i++))
done

export SERVICE_CIDR=10.96.0.0/24
export API_SERVICE=$(echo $SERVICE_CIDR | awk 'BEGIN {FS="."} ; { printf("%s.%s.%s.1", $1, $2, $3) }')
