#!/bin/bash
#
IP_NW="192.168.56."
#

echo "#-***-#_#-***-#"
#Var hostname=IP
for ((i=11;i<19;i++));
do
  echo "export K8SETCD$i='$IP_NW$i'"
done
##Print IP in serie
#for ((i=11;i<19;i++));
#do
#  echo -ne $IP_NW$i,
#done
##Print Hostname in serie
#echo
#for ((i=11;i<19;i++));
#do
#  echo -ne 'K8SETCD$i;'
#done
echo "#-***-#_#-***-#"
#Var hostname=IP
for ((i=21;i<29;i++));
do
  echo "export K8SKACS$i='$IP_NW$i'"
done
#Print IP in serie
for ((i=21;i<29;i++));
do
  echo -ne $IP_NW$i,
done
##Print Hostname in serie
#echo
#for ((i=21;i<29;i++));
#do
#  echo -ne 'K8SKACS$i;'
#done
echo "#-***-#_#-***-#"
#Var hostname=IP
for ((i=31;i<59;i++));
do
  echo "export K8SWORKER$i='$IP_NW$i'"
done
##Print IP in serie
#for ((i=31;i<59;i++));
#do
#  echo -ne $IP_NW$i,
#done
#Print Hostname in serie
echo
for ((i=31;i<59;i++));
do
  echo -ne K8SWORKER$i";"
done
echo "#-***-#_#-***-#"
#Var hostname=IP
for ((i=61;i<69;i++));
do
  echo "export K8SLB$i='$IP_NW$i'"
done
##Print IP in serie
#for ((i=20;i<30;i++));
#do
#  echo -ne $IP_NW$i,
#done
##Print Hostname in serie
#echo
#for ((i=20;i<30;i++));
#do
#  echo -ne 'K8SLB$i;'
#done

echo "export SERVICE_CIDR='10.96.0.0/24'"
echo "export POD_CIDR='10.244.0.0/16'"
echo "export API_SERVICE='10.244.0.1'"
echo "export RANGO=$IP_NW"
echo "export CLUSTERDNS='10.244.0.10'"
echo "#-***-#_#-***-#"
exit 0
