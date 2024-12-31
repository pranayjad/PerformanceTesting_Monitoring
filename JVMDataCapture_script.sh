{\rtf1\ansi\ansicpg1252\cocoartf2757
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 ArialMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs29\fsmilli14667 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 #!/bin/bash
\f1\fs24 \
\

\f0\fs29\fsmilli14667 version="1.0.0"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 scriptTemplateVersion="1.1.0"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #scriptPath="$( cd "$( dirname "$\{BASH_SOURCE[0]\}" )" && pwd )"
\f1\fs24 \

\f0\fs29\fsmilli14667 scriptName="JVM data capture"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Color Coding
\f1\fs24 \

\f0\fs29\fsmilli14667 RED="\\e[1;31m"
\f1\fs24 \

\f0\fs29\fsmilli14667 GREEN="\\e[1;32m"
\f1\fs24 \

\f0\fs29\fsmilli14667 ENDCOLOR="\\e[0m"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Help \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 #
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 Help()
\f1\fs24 \

\f0\fs29\fsmilli14667 \{
\f1\fs24 \

\f0\fs29\fsmilli14667 echo
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Welcome to $\{scriptName\} - $\{scriptTemplateVersion\} [OPTION]...
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0Following options are available.
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0Options:
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-s\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 mandatory - incident data will be captured for this service.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-c\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - use when service reports sustained high CPU usage.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-m\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - use when memory usage diagnosis is required.
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0Use following custom flags when you do not want to use pre-built diagnosis
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0flags for cpu or memory diagnosis but want your own options.
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0-t\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - number of thread dumps to be generated. defaults to 3.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-f\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - frequency of thread dumps. defaults to 5s.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-b\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - if specified, heap dump will be generated.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-r\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - if specified, java flight recording will start.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-d\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - flight recording duration e.g. 1m, 5m etc. to be specified when -r is used,
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0defaults to 5m i.e. 5 minutes
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-e\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 Exit script with null variables.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-h\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 Display help for this tool and exit.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-v\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 Output version information and exit."
\f1\fs24 \

\f0\fs29\fsmilli14667 echo
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Main program \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 #
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \
\

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # JDCF Function
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 function runJDCF() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0#make sure service name is provided
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [ -z "$_servicename" ];then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0msg "\\n$\{RED\}Service Name is Mandatory!!!$\{ENDCOLOR\}\\n"; safeExit;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0#check if java exists at specified location
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0setup_java
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0#Capture service pid
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0#Unique keyword for tomcat process
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [ "$_servicename" = "tomcat" ];
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0_servicename="catalina"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0_pid=$($java_dir/bin/jps -lv | grep "$_servicename" | awk '\{ print $1 \}')
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [ -z "$_pid" ];then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0msg "\\n$\{RED\}Service does not seem to be running or we do not have access to the service process.$\{ENDCOLOR\}\\n";
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0safeExit;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0#setup pre-requisites
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0setup_JDCF
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0#Collect Diagnostic data for CPU and JFR only options
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [[ $_isCPU == true || $_isJFR == true ]]; then
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\nJava Flight Recording started. $\{GREEN\}Please wait $_jfrdur for recording to complete.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" JFR.start settings=profile path-to-gc-roots=true duration="$_jfrdur" filename="$output_dir_jfr"/jfr_"$(hostname)"_"$_servicename"_"$current_time".jfr >/dev/null
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0i=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0if [[ $_isCPU == true ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0_jfrsleep=10
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0while [ $i -le $(("$_jfrsleep")) ];
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep 30
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0jfr_status=$($java_dir/bin/jcmd "$_pid" JFR.check)
\f1\fs24 \

\f0\fs29\fsmilli14667 	\'a0 \'a0 if eval grep -q "running" <<< "$jfr_status" || grep -q "recordings" <<<"$jfr_status" || grep -q "closed" <<< "$jfr_status" || grep -q "stopped" <<< "$jfr_status"; then
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 printf "\\n$\{GREEN\}Flight Recording Progress - running$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 	\'a0 \'a0 else
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 printf "\\n%s\\n" "$jfr_status"
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 elapsed_time=$((i*30))
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 printf "\\n$\{RED\}Flight Recording Progress - Something went wrong after $elapsed_time seconds. Please check if process is still running.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 	\'a0 \'a0 fi
\f1\fs24 \

\f0\fs29\fsmilli14667 	((i++))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0sleep 10
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0tar -czf /tmp/jfr_"$(hostname)"_"$_servicename"_"$time".tar.gz --absolute-names "$output_dir_jfr"\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0rm -rfd "$output_dir_jfr"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Java Flight Recording captured at path - /tmp/jfr_$(hostname)_""$_servicename""_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0if [[ $_isCustomThread == true ]]; then #collect Thread dumps only
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ $_isCPU == false\'a0 ]]; then #collect only when _isCPU == false. Because if true, JFR will have thread dumps.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0count=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Collecting $_threadcnt thread dumps $_threadfreq seconds apart for PID - $_pid $\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0# Loop through each thread dump execution
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0while [ $count -le "$_threadcnt" ]\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 	\'a0 current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 	\'a0 $java_dir/bin/jcmd "$_pid" Thread.print > "$output_dir"/threaddump\\#"$count"_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# Generate stack trace of top native threads by cpu via jcmd
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" Thread.print |grep -E -A 15 -i "$(top -H -b -n 1 -o +%CPU -p "$_pid"|head -n 17|awk '\{print $1\}'|grep '^[0-9]'|xargs printf "|%X" "$_pid"|tr A-Z a-z|sed 's/^|//')" > "$output_dir"/stack_topthreads\\#"$count"_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Thread dump # $count collected at $current_time$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Stack trace of top native threads # $count collected at $current_time$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep "$_threadfreq"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0tar -czf /tmp/threaddumps_"$(hostname)"_"$_servicename"_"$time".tar.gz --absolute-names "$output_dir"\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd "$output_dir"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Thread dumps collected at path - /tmp/threaddumps_$(hostname)_""$_servicename""_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\nPlease Check JFRs for thread dumps.\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0if [[ $_isMem == true || $_isHeapDump == true ]]; then #collect heapdumps, also collect heap stats for 1 minute
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Capturing Heap Summary Stats and Finalization Information at $current_time.Please wait for 1 minute.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0count=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0loopcount=12
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0while [ $count -le "$loopcount" ]\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" GC.heap_info >> "$output_dir_heap"/heapstats_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" GC.finalizer_info >> "$output_dir_heap"/heapstats_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep 5
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Heap summary statistics are collected.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Capturing Heap Dump at $current_time$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" GC.heap_dump "$output_dir_heap"/heapdump_"$(hostname)"_"$_servicename"_"$current_time".hprof >/dev/null
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0tar -czf /tmp/heapdump_"$(hostname)"_"$_servicename"_"$time".tar.gz --absolute-names "$output_dir_heap"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0rm -rfd "$output_dir_heap"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Heap Dump collection complete at path - /tmp/heapdump_$(hostname)_""$_servicename""_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0if [[ $_isCustomThread == false && $_isCPU == false && $_isMem == false && $_isJFR == false && $_isHeapDump == false ]]; then\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#collect Histograms/Native Heap Summary and Threadumps only
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0output_dir=/tmp/threaddumps_$(hostname)_"$_servicename"_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ ! -e $output_dir ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0mkdir "$output_dir"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0count=1
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Collecting Default $_threadcnt thread dumps $_threadfreq seconds apart for PID - $_pid$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0# Loop through each thread dump execution
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0while [ $count -le "$_threadcnt" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" Thread.print > "$output_dir"/threaddump\\#"$count"_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# Generate stack trace of top native threads by cpu via jcmd
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd "$_pid" Thread.print |grep -E -A 15 -i "$(top -H -b -n 1 -o +%CPU -p "$_pid"|head -n 17|awk '\{print $1\}'|grep '^[0-9]'|xargs printf "|%X" "$_pid"|tr A-Z a-z|sed 's/^|//')" > "$output_dir"/stack_topthreads\\#"$count"_"$(hostname)"_"$_servicename"_"$current_time".txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Thread dump # $count collected at $current_time$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Stack trace of top native threads # $count collected at $current_time$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep "$_threadfreq"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0tar -czf /tmp/threaddumps_"$(hostname)"_"$_servicename"_"$time".tar.gz --absolute-names "$output_dir"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd "$output_dir"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Thread dumps collected at path - /tmp/threaddumps_$(hostname)_""$_servicename""_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #\'a0 echo "hello $_servicename - $_threadcnt - $_threadfreq - $_isHeapDump $_isJFR - $_jfrdur $_isCPU - $_isMem - "
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Helper Functions
\f1\fs24 \
\

\f0\fs29\fsmilli14667 setup_java()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 # Java installation directory as per our deployments
\f1\fs24 \

\f0\fs29\fsmilli14667 java_dir=/home/fusionops/jdk
\f1\fs24 \
\

\f0\fs29\fsmilli14667 if [ ! -d $java_dir ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0msg "\\n$\{RED\}No JAVA found. Expecting /home/fusions/jdk! $\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \

\f0\fs29\fsmilli14667 setup_JDCF()\{
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #JFR Duration
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ $_isJFR == true ]];\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [[ -z $\{_jfrdur::-1\} ]];then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0msg "Invalid value for JFR duration. Example: 10m for 10 minute."
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [[ $\{_jfrdur::-1\} -gt 30 ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0msg "Restricting JFR Recording duration to 30 Minutes and Proceeed!"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0_jfrdur="30m"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0_jfrsleep=$(("$\{_jfrdur::-1\}"*2))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Setup Output Directories as per command line options
\f1\fs24 \

\f0\fs29\fsmilli14667 time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ $_isCPU == true || $_isJFR == true ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0output_dir_jfr=/tmp/jfr_$(hostname)_$_servicename\\_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0if [[ ! -e $output_dir_jfr ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0mkdir "$output_dir_jfr"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ $_isCustomThread == true ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0output_dir=/tmp/threaddumps_$(hostname)_$_servicename\\_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0if [[ ! -e $output_dir ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0mkdir "$output_dir"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ $_isMem == true || $_isHeapDump == true ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0output_dir_heap=/tmp/heapdump_$(hostname)_$_servicename\\_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0if [[ ! -e $output_dir_heap ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0mkdir "$output_dir_heap"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 msg() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "$\{1-\}" 1>&2;
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function safeExit()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0echo
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0echo "Something went wrong. Safely Exiting..." 1>&2;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0echo
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0cleanup
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function die() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "$*" 1>&2 ; safeExit;
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function is_dir()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0[ -d "$1" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function cleanup() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0for file in /tmp/*threaddumps*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [ -e "$file" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd /tmp/*threaddumps*\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0break
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0for file in /tmp/*heapdump*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [ -e "$file" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd /tmp/*heapdump*\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0break
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0for file in /tmp/*jfr*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [ -e "$file" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd /tmp/*jfr*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0break
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0msg "Exited with Cleanup!"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0echo
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0exit 1;
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Set variables
\f1\fs24 \

\f0\fs29\fsmilli14667 _servicename=""
\f1\fs24 \

\f0\fs29\fsmilli14667 _threadcnt=3
\f1\fs24 \

\f0\fs29\fsmilli14667 _threadfreq=5
\f1\fs24 \

\f0\fs29\fsmilli14667 _isCustomThread=false
\f1\fs24 \

\f0\fs29\fsmilli14667 _isHeapDump=false
\f1\fs24 \

\f0\fs29\fsmilli14667 _isJFR=false
\f1\fs24 \

\f0\fs29\fsmilli14667 _jfrdur="5m"
\f1\fs24 \

\f0\fs29\fsmilli14667 _isCPU=false
\f1\fs24 \

\f0\fs29\fsmilli14667 _isMem=false
\f1\fs24 \
\

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Process the input options. Add options as needed.\'a0 \'a0 \'a0 \'a0 #
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Get the options
\f1\fs24 \

\f0\fs29\fsmilli14667 while getopts ":hs:t:f:rd:bcmv" option; do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0case $option in
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0h) # display Help
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0Help
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exit;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0s) #Enter Service Name
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_servicename=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0t) #Enter thread
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_threadcnt=$OPTARG;_isCustomThread=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0f) #Enter frequency of thread dumps
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_threadfreq=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0b) #Whether Heapdump is needed
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_isHeapDump=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0r) #Whether java flight recording is needed
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_isJFR=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0d) #Enter JFR Duration
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_jfrdur=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0c) #Enter CPU Group Option
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_isCPU=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0m) #Enter Memory Group Option
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0_isMem=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0v) #Check Version
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "$(basename "$0") $\{version\}"; safeExit ;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\\?) # Invalid option
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "$\{RED\}Error: Invalid option$\{ENDCOLOR\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exit;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0esac
\f1\fs24 \

\f0\fs29\fsmilli14667 done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #tmpDir="/tmp/$\{scriptName\}.$RANDOM.$RANDOM.$RANDOM.$$"
\f1\fs24 \

\f0\fs29\fsmilli14667 #(umask 077 && mkdir "$\{tmpDir\}") || \{
\f1\fs24 \

\f0\fs29\fsmilli14667 #\'a0 die "Could not create temporary directory! Exiting."
\f1\fs24 \

\f0\fs29\fsmilli14667 #\}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 trap safeExit EXIT INT TERM
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Exit on error.
\f1\fs24 \

\f0\fs29\fsmilli14667 set -o errexit
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Run in debug mode, if set
\f1\fs24 \

\f0\fs29\fsmilli14667 #if [ "$\{debug\}" == "1" ]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 #\'a0 set -x
\f1\fs24 \

\f0\fs29\fsmilli14667 #fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Exit on empty variable
\f1\fs24 \

\f0\fs29\fsmilli14667 #if [ "$\{strict\}" == "1" ]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 #\'a0 set -o nounset
\f1\fs24 \

\f0\fs29\fsmilli14667 #fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Call JDCF Script
\f1\fs24 \

\f0\fs29\fsmilli14667 runJDCF
\f1\fs24 \
\
\
}