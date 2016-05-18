#!/bin/bash
 
while :
do
source pingconfig 
 
while read line
do
> ${TMP}
echo "ping: ${PACKETTIMES} - ${INTERVAL} - ${PACKETSIZE} $line"
ping -c ${PACKETTIMES} -i ${INTERVAL} -s ${PACKETSIZE} $line >> ${TMP}
DELAY=`grep rtt ${TMP} | awk '{print$4}' |awk -F "/" '{print$1"/"$2"/"$3}'`
LOST=`grep loss ${TMP} |awk -F "%" '{print$1"%"}'|awk '{print $NF}' `
DATE=`date +"%Y-%m-%d %H:%M:%S"`
if  [  -z "${DELAY}"  ]
then
DELAY=none
fi
echo "################################################"
echo "${DATE} ${HOSTIP} > ${line}  the min/avg/max is ${DELAY} and  packets lost ${LOST}"
echo "################################################" >> ${OUTPUT}${line}
echo "${DATE} ${HOSTIP} > ${line}  the min/avg/max is ${DELAY} and  packets lost ${LOST}" >> ${OUTPUT}${line}
rm -rf ${TMP}
done<${IPFILE}
 
sleep ${sTIME}
done
