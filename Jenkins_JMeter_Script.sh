{\rtf1\ansi\ansicpg1252\cocoartf2757
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 ArialMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww34000\viewh18540\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs29\fsmilli14667 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 #!/bin/bash
\f1\fs24 \

\f0\fs29\fsmilli14667 #Color Coding
\f1\fs24 \

\f0\fs29\fsmilli14667 RED="\\e[1;31m"
\f1\fs24 \

\f0\fs29\fsmilli14667 GREEN="\\e[1;32m"
\f1\fs24 \

\f0\fs29\fsmilli14667 ENDCOLOR="\\e[0m"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Test Script SCP Function
\f1\fs24 \

\f0\fs29\fsmilli14667 testscript_scp()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0	ssh fusionops@$1 rm -Rf /tmp/$2
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	scp -r $2 fusionops@$1:/tmp/
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	ssh fusionops@$1 chmod +x /tmp/$2
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0echo -e "\\n$\{GREEN\}------------------------------ Test script and data transfered to $1 -------------------------------$\{ENDCOLOR\}\\n";
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Test Script RM Function
\f1\fs24 \

\f0\fs29\fsmilli14667 testscript_rm()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 	ssh fusionops@$1 rm -Rf /tmp/$2
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Start JMeter Server Function
\f1\fs24 \

\f0\fs29\fsmilli14667 start_server()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 	ssh fusionops@$1 "nohup /usr/local/jmeter/apache-jmeter-5.6.3/bin/jmeter-server &"
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 echo -e "\\n$\{RED\}------------------------------ Module(s) under test - $\{Module\} -----------------------------$\{ENDCOLOR\}\\n"\'a0
\f1\fs24 \
\

\f0\fs29\fsmilli14667 IFS=','
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Reading the split string into array - module array
\f1\fs24 \

\f0\fs29\fsmilli14667 read -ra Module_arr <<< "$\{Module\}"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Reading the split string into array - Slave m/c array
\f1\fs24 \

\f0\fs29\fsmilli14667 read -ra Machine_arr <<< "$\{Slaves\}"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 len=$\{#Module_arr[@]\}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 len_mc=$\{#Machine_arr[@]\}
\f1\fs24 \
\
\

\f0\fs29\fsmilli14667 for (( i=0; i<$\{len\}; i++ ));
\f1\fs24 \

\f0\fs29\fsmilli14667 do\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	ScriptName="ABC_meshv2_$\{Module_arr[i]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0Basedir="/tmp/$\{Module_arr[i]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0ResultName="$\{Module_arr[i]\}_$\{TestType\}_$\{ReleaseVersion\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	testscript_scp "$\{Controller\}" "$\{Module_arr[$\{i\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0loadgenerators=""
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	for (( j=0; j<$\{len_mc\}; j++ ));
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0	
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0	testscript_scp "$\{Machine_arr[$\{j\}]\}" "$\{Module_arr[$\{i\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#start_server "$\{Machine_arr[$\{j\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0if [[ "$\{j\}" > 0 ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0	loadgenerators="$loadgenerators,$\{Machine_arr[$\{j\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0	loadgenerators="$\{Machine_arr[$\{j\}]\}"\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	#Invoke Jmeter Instance
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0echo -e "\\n$\{GREEN\}------------------------------ $\{Module_arr[$\{i\}]\} test is started -------------------------------$\{ENDCOLOR\}\\n";
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	InfluxdbUrl="http://$\{Controller\}:8086/write?db=$\{influxdb_database\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$\{len_mc\}" > 0 ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0	ssh fusionops@$\{Controller\} /usr/local/jmeter/apache-jmeter-5.6.3/bin/jmeter -n -t /tmp/$\{Module_arr[$\{i\}]\}/$\{ScriptName\}.jmx -R"$\{loadgenerators\}" -GBasedir=$\{Basedir\} -GMeasurement=$\{Module_arr[$\{i\}]\} -GTestType=$\{TestType\} -GReleaseVersion=$\{ReleaseVersion\} -GDatabase="$\{influxdb_database\}" -GInfluxdbUrl="$\{InfluxdbUrl\}" -l /tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}.jtl -e -o /tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}_HtmlReport
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0ssh fusionops@$\{Controller\} /usr/local/jmeter/apache-jmeter-5.6.3/bin/jmeter -n -t /tmp/$\{Module_arr[$\{i\}]\}/$\{ScriptName\}.jmx -JBasedir=$\{Basedir\} -JMeasurement=$\{Module_arr[$\{i\}]\} -JTestType=$\{TestType\} -JReleaseVersion=$\{ReleaseVersion\} -JDatabase=$\{influxdb_database\} -JInfluxdbUrl=$\{InfluxdbUrl\} -l /tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}.jtl -e -o /tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}_HtmlReport
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	
\f1\fs24 \

\f0\fs29\fsmilli14667 	scp fusionops@$\{Controller\}:/tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}.jtl ./$\{ResultName\}.jtl
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	scp -r fusionops@$\{Controller\}:/tmp/$\{Module_arr[$\{i\}]\}/$\{ResultName\}_HtmlReport ./$\{ResultName\}_HtmlReport
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0testscript_rm "$\{Controller\}" "$\{Module_arr[$\{i\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 	for (( j=0; j<$\{len_mc\}; j++ ));
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0	testscript_rm "$\{Machine_arr[$\{j\}]\}" "$\{Module_arr[$\{i\}]\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 		
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	echo -e "\\n$\{GREEN\}------------------------------ $\{Module_arr[$\{i\}]\} test is completed -------------------------------$\{ENDCOLOR\}\\n";
\f1\fs24 \
\

\f0\fs29\fsmilli14667 	sleep 1m
\f1\fs24 \

\f0\fs29\fsmilli14667 done
\f1\fs24 \
\
}