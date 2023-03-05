#!/bin/bash
#
IP_NW="192.168.56."
#

echo "#-***-#_#-***-#"
i=10
while (($i<20))
do
  echo "export K8SETCD$i="$IP_NW$i""
  ((i++))
done

i=20
while (($i<30))
do
  echo "export K8SKACS$i="$IP_NW$i""
  ((i++))
done

i=50
while (($i<60))
do
  echo export K8SWORKER$i="$IP_NW$i"
  ((i++))
done

i=60
while (($i<70))
do
  echo export K8SLB$i="$IP_NW$i"
  ((i++))
done

echo export SERVICE_CIDR="10.96.0.0/24"
echo export POD_CIDR="10.244.0.0/16"
echo export API_SERVICE="10.244.0.1"
echo export CLUSTERDNS="10.244.0.10"
echo "#-***-#_#-***-#"
exit 0
