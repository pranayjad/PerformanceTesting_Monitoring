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

\f0\fs29\fsmilli14667 time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Usage -
\f1\fs24 \

\f0\fs29\fsmilli14667 # User as sudouser
\f1\fs24 \

\f0\fs29\fsmilli14667 # ./service_monitoring_nonmesh.sh <process_name> <quantity -optional> <frequency -optional>
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# <process_name> is java process for which monitoring data needs to captured
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# For eg. - tomcat, cwb, mobile, discovery etc.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# <quantity> is the no. of thread dumps to capture. (Optional Parameter) - Defaults to 3 thread dumps unless specified
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0# <frequency> is duration in seconds between each thread dump. (Optional Parameter) - Defaults to one thread dump per 5 sec unless specified
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Modify with your Java installation directory
\f1\fs24 \

\f0\fs29\fsmilli14667 java_dir=/home/sudouser/jdk
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Optionally modify with the output directory for captured data
\f1\fs24 \

\f0\fs29\fsmilli14667 process_name=$1
\f1\fs24 \

\f0\fs29\fsmilli14667 output_dir=/tmp/threaddumps_$(hostname)_$process_name\\_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 output_dir_heap=/tmp/heapdump_$(hostname)_$process_name\\_$time
\f1\fs24 \

\f0\fs29\fsmilli14667 output_dir_jfr=/tmp/jfr_$(hostname)_$process_name\\_$time
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #No of thread dumps to create (Optional Parameter) - Defaults to 3 thread dumps unless specified
\f1\fs24 \

\f0\fs29\fsmilli14667 quantity=$\{2:-3\}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Duration in seconds between each thread dump (Optional Parameter) - Defaults to one thread dump per 5 sec unless specified
\f1\fs24 \

\f0\fs29\fsmilli14667 frequency=$\{3:-5\}
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

\f0\fs29\fsmilli14667 #Unique keyword for tomcat process
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ "$1" == tomcat ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0set catalina $2 $3
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Validate java_dir path
\f1\fs24 \

\f0\fs29\fsmilli14667 if [ ! $java_dir ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n$\{RED\}Modify java_dir within this script with your Java installation directory$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0exit 1
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Capture process pid
\f1\fs24 \

\f0\fs29\fsmilli14667 process_pid=$($java_dir/bin/jps -lv | grep $1 | awk '\{ print $1 \}')
\f1\fs24 \
\

\f0\fs29\fsmilli14667 pid_count=$(ps -ef |grep $process_pid |grep -v grep |wc -l)
\f1\fs24 \

\f0\fs29\fsmilli14667 if [ $pid_count -ne 1 ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n$\{RED\}PID not captured. Service does not seem to be running or we do not have access to the service process.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n$\{GREEN\}Usage: ./service_monitoring_nonmesh.sh <process_name> <quantity -optional> <frequency -optional>$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0exit 1
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Create Output Directory if it doesn't exist
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ ! -e $output_dir ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0mkdir $output_dir
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 read -p "Do you also want to capture Heap Dump? - Type Y/N : " heap_dump
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Create Output Directory if it doesn't exist
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ "$heap_dump" == Yes || "$heap_dump" ==\'a0 yes || "$heap_dump" ==\'a0 Y || "$heap_dump" ==\'a0 y ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [[ ! -e $output_dir_heap ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0mkdir $output_dir_heap
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 read -p "Do you also want to capture Java Flight Recording? - Types Y/N : " jfr
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #Create Output Directory if it doesn't exist
\f1\fs24 \

\f0\fs29\fsmilli14667 if [[ "$jfr" == Yes || "$jfr" == yes || "$jfr" == Y || "$jfr" == y ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [[ ! -e $output_dir_jfr ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0mkdir $output_dir_jfr
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0read -p "Please specify duration of Java Flight Recording. (For eg. 30s, 5m) : " jfr_duration
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 if [ $# -ne 0 ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0pid=$process_pid
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0# Checks if PID exists
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if ps -p $pid > /dev/null\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0then\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Collecting File Descriptor Count, Top native threads by CPU, Top processes by Memory, Histogram, Heap Dump (if selected), JFR (if selected) and $quantity sample(s) of thread dumps $frequency seconds apart for PID $pid$\{ENDCOLOR\}\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture File Descriptor Count
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "File Descriptor Count for PID $pid is $(ls /proc/$\{pid\}/fd |wc -l)" | tee $output_dir/filedescriptor_count\\#1_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture top command output sorted by Memory
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -b -c -o +%MEM | head -n 27 > $output_dir/top_by_memory\\#1_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0sleep 3
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -b -c -o +%MEM | head -n 27 > $output_dir/top_by_memory\\#2_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n2 samples of Top processes by Memory 3 seconds apart collected at $current_time before taking Thread Dump\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0sleep 1
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_count=0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0count=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture Top Command Output for native threads by cpu before taking Thread Dump
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -Hbn 1 -p $pid |head -n 17 |sed -n '/PID/,/^$/p' > $output_dir/cpu_native\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Generate Histogram via jcmd before taking Thread Dump
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid GC.class_histogram > $output_dir/histo\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 	
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\nTop native threads by CPU and Histogram #$count collected at $current_time before taking Thread Dump\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0# Loop through each thread dump execution
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0while [ $current_count -lt $quantity ]\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0# Generate thread dump via jcmd
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid Thread.print > $output_dir/threaddump\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0# Generate stack trace of top native threads by cpu via jcmd
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid Thread.print |egrep -A 15 -i `top -H -b -n 1 -o +%CPU -p $pid|head -n 17|awk '\{print $1\}'|grep ^[0-9]|xargs printf "|%X" $pid|tr A-Z a-z|sed 's/^|//'` > $output_dir/stack_topthreads\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\nThread dump #$count collected at $current_time\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\nStack trace of top native threads #$count collected at $current_time\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0(( current_count++ ))
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0# Sets a delay only if this isn't the last execution
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0if [ $current_count -lt $quantity ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep $frequency
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0sleep 1
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0count=2
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Generate Histogram via jcmd after Thread Dump
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid GC.class_histogram > $output_dir/histo\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture Top Command Output for native threads by cpu after taking Thread Dump
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -Hbn 1 -p $pid |head -n 17 |sed -n '/PID/,/^$/p' > $output_dir/cpu_native\\#$count\\_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\nTop native threads by CPU and Histogram #$count collected at $current_time after taking Thread Dump\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture top command output sorted by Memory
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -b -c -o +%MEM | head -n 27 > $output_dir/top_by_memory\\#3_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0sleep 3
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time_1=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0top -b -c -o +%MEM | head -n 27 > $output_dir/top_by_memory\\#4_$(hostname)_$process_name\\_$current_time.txt
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n2 samples of Top processes by Memory 3 seconds apart collected at $current_time after taking Thread Dump\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0tar -czf /tmp/threaddumps_$(hostname)_$process_name\\_$time.tar.gz -C $output_dir $(ls $output_dir)
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#tar -czf /tmp/threaddumps_$(hostname)_$process_name\\_$time.tar.gz
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd $output_dir
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Monitoring Data collection complete at path - /tmp/threaddumps_$(hostname)_"$process_name"_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture Heap Dump if user says yes
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$heap_dump" == Yes || "$heap_dump" ==\'a0 yes || "$heap_dump" ==\'a0 Y || "$heap_dump" ==\'a0 y ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\nCapturing Heap Dump at $current_time\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid GC.heap_dump $output_dir_heap/heapdump_$(hostname)_$process_name\\_$current_time.hprof >/dev/null
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0tar -czf /tmp/heapdump_$(hostname)_$process_name\\_$time.tar.gz -C $output_dir_heap $(ls $output_dir_heap)
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0rm -rfd $output_dir_heap
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Heap Dump collection complete at path - /tmp/heapdump_$(hostname)_"$process_name"_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0current_time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Capture Java Flight Recording if user says yes
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$jfr" == Yes || "$jfr" == yes || "$jfr" == Y || "$jfr" == y ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\nJava Flight Recording started. $\{RED\}Please wait $jfr_duration for recording to complete.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0$java_dir/bin/jcmd $pid JFR.start settings=profile path-to-gc-roots=true duration=$jfr_duration filename=$output_dir_jfr/jfr_$(hostname)_$process_name\\_$current_time.jfr >/dev/null
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0sleep $jfr_duration
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0sleep 10
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0#Zipping all files generated
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0tar -czf /tmp/jfr_$(hostname)_$process_name\\_$time.tar.gz -C $output_dir_jfr $(ls $output_dir_jfr)
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0rm -rfd $output_dir_jfr
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Java Flight Recording data captured at path - /tmp/jfr_$(hostname)_"$process_name"_$time.tar.gz$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0printf "\\n$\{RED\}The PID $pid does not exist $\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0exit 1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n$\{RED\}PID not captured. Service does not seem to be running or we do not have access to the service process.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\n$\{GREEN\}Usage: ./service_monitoring_nonmesh.sh <process_name> <quantity -optional> <frequency -optional>$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0exit 1
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\
\
}