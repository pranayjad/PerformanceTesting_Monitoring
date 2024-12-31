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

\f0\fs29\fsmilli14667 scriptName="SQL Data Capture"
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

\f0\fs29\fsmilli14667 \'a0\'a0-s\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 required\'a0 - This RDS instance will collect diagnostic data.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-p\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Port that the MySQL service listens on; if omitted, 3306 is used by default.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-u\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 required\'a0 - Database user id; defaults to SQL_user. Is required if another user is used.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-k\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 required\'a0 - Password; defaults to SQL_user's password. Is required if another user is used.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-d\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Database name; if omitted, INFORMATION SCHEMA is used by default.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-q\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Use when long running query diagnostics, which run for 1 minute, are needed.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-l\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Use when deadlock diagnostics are needed.
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0Use following custom flags when you do not want to use pre-built diagnosis
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0flags for cpu or memory diagnosis but want your own options.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-o\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Output directory. Output is written to "/tmp/" if it is not provided.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-h\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Display this tool's help, then quit.
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0-v\'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 \'a0 optional\'a0 - Outputs version information, then quit."
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

\f0\fs29\fsmilli14667 # SQL Function
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 function runSQL() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 #make sure service name is provided
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ -z "$servicename" || -z "$mysql_user" || -z "$mysql_password" || -z "$mysql_database" ]];then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0msg "\\n$\{RED\}One of the mandatory fields are missing!!!$\{ENDCOLOR\}\\n"; safeExit;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0#Check if SQL Client exists at specified location
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0setup_sql
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0setup_SQL
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$isLongQuery" == true\'a0 ]]; then
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#echo "Inside Long Query..."
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0query_file="$(mktemp)"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo\'a0 "select p.ID,p.user,p.HOST, p.info as query_text,p.time,substring(p.info,-50,48) as running_req_id" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0"from" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 \'a0 \'a0 "information_schema.PROCESSLIST p" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0"where" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 	 \'a0 \'a0 \'a0 \'a0 \'a0 "p.ID in (select it.trx_mysql_thread_id from information_schema.INNODB_TRX it)" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 		\'a0 \'a0 \'a0 \'a0 "and p.info is not null and INSTR(p.info, 'SQLTAG') > 0;" > "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\nCalling Function...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exec_long_query "$\{query_file\}" -t
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo "$\{exec_long_query_result\}" >> "$output_dir"/long_running_$time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0rm "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0rm "$output_dir"/long_running_queries_*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#rm "$\{query_file1\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Long running query details captured in - "$output_dir"/long_running_$time.txt$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$isDeadlock" == true\'a0 ]]; then
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#echo "Inside Deadlock Identification Query..."
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0query_file="$(mktemp)"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo\'a0 "show engine innodb status;" > "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0time=$(date "+%Y.%m.%d-%H.%M.%S")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\nCalling Function...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exec_deadlock_query "$\{query_file\}" -t
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo "$\{exec_deadlock_query_result\}" >> "$output_dir"/deadlock_$time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0rm "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#rm "$\{query_file1\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Deadlock details captured in - "$output_dir"/deadlock_$time.txt$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n################################################################################################################\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ "$isLongQuery" != true && "$isDeadlock" != true ]]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0msg "\\n$\{RED\}No option selected. Please select at least one option for diagnosis.$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 #SQL Category Functions
\f1\fs24 \
\

\f0\fs29\fsmilli14667 exec_long_query() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\nInside Function...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0local query_file=$(cat "$1")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0local opts="$2"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0#source mysql.sh
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0temp_Config
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0count=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0loopcount=12
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0while [ $count -le "$loopcount" ]\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#printf "\\nInside Loop...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Long running query capture in progress...$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exec_long_query_result=$(
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#$sqlPath/mysql --defaults-file="$\{tmpcnf\}" "$opts" -e "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mysql --defaults-file="$\{tmpcnf\}" "$opts" -e "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0)
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo "$\{exec_long_query_result\}" >> "$output_dir"/long_running_queries_$time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep 5
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0rm "$\{tmpcnf\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 exec_deadlock_query() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "\\nInside Function...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0local query_file=$(cat "$1")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0local opts="$2"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0#source mysql.sh
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0temp_Config
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0count=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0loopcount=1
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0while [ $count -le "$loopcount" ]\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#printf "\\nInside Loop...\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "\\n$\{GREEN\}Deadlock capture in progress...$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0exec_deadlock_query_result=$(
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#$sqlPath/mysql --defaults-file="$\{tmpcnf\}" "$opts" -e "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mysql --defaults-file="$\{tmpcnf\}" "$opts" -e "$\{query_file\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0)
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0#echo "$\{exec_deadlock_query_result\}" >> "$output_dir"/deadlock_queries_$time.txt
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0(( count++ ))
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0sleep 5
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0rm "$\{tmpcnf\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function setup_SQL()\{
\f1\fs24 \
\
\

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0output_dir=/"$base_dir"/SQL
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [[ ! -e $output_dir ]]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mkdir "$output_dir"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\
\
\

\f0\fs29\fsmilli14667 #Helper Functions
\f1\fs24 \
\

\f0\fs29\fsmilli14667 setup_sql()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if ! command -v mysql >/dev/null 2>&1; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0msg "\\n$\{RED\}SQL Client path not set/found. Expecting /usr/local/mysql-<version>/bin $\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0temp_Config
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \'a0\'a0# Use the mysql command to check if the user has access to the database
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0result=$(mysql --defaults-file="$\{tmpcnf\}" -e "SELECT 1 from dual;")
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0# Check if the mysql command returned an error message
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0if [ $? -ne 0 ]; then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0# The user does not have access to the database
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0msg "\\n$\{RED\}Error: User - SQL_user does not have access to the database$\{ENDCOLOR\}\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0safeExit
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0else
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0# The user has access to the database
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0msg "\\nUser has access to the database\\n"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0fi
\f1\fs24 \
\

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 temp_Config()\{
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0tmpcnf="$(mktemp)"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0chmod 600 "$\{tmpcnf\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0printf "%s\\n" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"[client]" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"user=$\{mysql_user\}" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"password=$\{mysql_password\}" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"host=$\{servicename\}" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"port=$\{port\}" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0"database=$\{mysql_database\}" \\
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0> "$\{tmpcnf\}"
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 function msg() \{
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
\

\f0\fs29\fsmilli14667 function cleanup() \{
\f1\fs24 \

\f0\fs29\fsmilli14667 #Remove SQL Directory $base_dir
\f1\fs24 \

\f0\fs29\fsmilli14667 for file in $base_dir/*SQL*
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0do
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0if [ -e "$file" ]
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0then
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0rm -rfd $base_dir/*SQL*\'a0
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0fi
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0done
\f1\fs24 \
\

\f0\fs29\fsmilli14667 echo "Cleanup complete!"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo
\f1\fs24 \

\f0\fs29\fsmilli14667 exit 1;
\f1\fs24 \

\f0\fs29\fsmilli14667 \}
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Set variables
\f1\fs24 \

\f0\fs29\fsmilli14667 servicename=""
\f1\fs24 \

\f0\fs29\fsmilli14667 port="3306"
\f1\fs24 \

\f0\fs29\fsmilli14667 isLongQuery=false
\f1\fs24 \

\f0\fs29\fsmilli14667 isDeadlock=false
\f1\fs24 \

\f0\fs29\fsmilli14667 lqdur="5m"
\f1\fs24 \

\f0\fs29\fsmilli14667 mysql_user="SQL_user"
\f1\fs24 \

\f0\fs29\fsmilli14667 #mysql_password="PwSCaAF@\{.Om[oHLTP4n"
\f1\fs24 \

\f0\fs29\fsmilli14667 mysql_password=`cat /Users/rajatverma/mysql_pass.txt`
\f1\fs24 \

\f0\fs29\fsmilli14667 mysql_database="INFORMATION_SCHEMA"
\f1\fs24 \

\f0\fs29\fsmilli14667 base_dir="tmp"
\f1\fs24 \
\
\

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Process the input options. Add options as needed.\'a0 \'a0 \'a0 \'a0 #
\f1\fs24 \

\f0\fs29\fsmilli14667 ############################################################
\f1\fs24 \

\f0\fs29\fsmilli14667 # Get the options
\f1\fs24 \

\f0\fs29\fsmilli14667 while getopts ":hs:p:u:k:d:o:qlv" option; do
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

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0servicename=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0p) #Enter Service Port
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0port=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0u) #Enter Database Username
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mysql_user=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0k) #Enter Database user Password
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mysql_password=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0d) #Enter Database Name
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0mysql_database=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0o) #Enter output directory to store results
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0base_dir=$OPTARG;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0q) #Enter Long Running Queries Group
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0isLongQuery=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0l) #Enter Deadlock Group
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0isDeadlock=true;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0v) #Check Version
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0printf "$(basename "$0") $\{version\}"; exit 0 ;;
\f1\fs24 \

\f0\fs29\fsmilli14667 \'a0\'a0\'a0\'a0\'a0\'a0*) # Invalid option
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
\

\f0\fs29\fsmilli14667 #trap safeExit EXIT INT TERM
\f1\fs24 \
\

\f0\fs29\fsmilli14667 # Exit on error.
\f1\fs24 \

\f0\fs29\fsmilli14667 set -o errexit
\f1\fs24 \
\
\
\

\f0\fs29\fsmilli14667 # Call SQL Script
\f1\fs24 \

\f0\fs29\fsmilli14667 runSQL
\f1\fs24 \
\
\
}