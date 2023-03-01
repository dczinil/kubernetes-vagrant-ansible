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
echo export API_SERVICE="$(echo $SERVICE_CIDR | awk 'BEGIN {FS="."} ; { printf("%s.%s.%s.1", $1, $2, $3) }')"
echo "#-***-#_#-***-#"
exit 0
