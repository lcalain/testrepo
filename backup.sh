#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo 'task2 :'
echo "targetDirectory = $targetDirectory"
echo "destinationDirectory = $destinationDirectory"

# [TASK 3]
echo 'task3 :'
currentTS=`date +%s`
echo "currentTS = $currentTS"

# [TASK 4]
echo 'task4 :'
backupFileName="backup-$currentTS.tar.gz"
echo "backupFileName = $backupFileName"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
echo 'task5 :'
origAbsPath=`pwd`
echo "origAbsPath = $origAbsPath"

# [TASK 6]
echo 'task6 :'
cd $destinationDirectory
destAbsPath=`pwd`
echo "destAbsPath = $destAbsPath"

# [TASK 7]
echo 'task7 :'
cd $origAbsPath
echo "After \"cd \$origAbsPath\" we are here : $(pwd)"
cd $targetDirectory
echo "After \"cd \$targetDirectory\" we are here : $(pwd)"

# [TASK 8]
echo 'task8 :'
yesterdayTS=$(($currentTS - 24 * 60 * 60))
echo "yesterdayTS = $yesterdayTS"

declare -a toBackup

echo 'task9 : listing files and directories in the current directory : '
for file in $(ls) # [TASK 9]
do
echo $file
   #[TASK 10]
  if ((`date -r $file +%s` > $yesterdayTS))
  then
     toBackup+=($file) # [TASK 11]
  fi
done
echo 'task10 & 11 showing array "toBackup" which contains files modified in the last 24h : '
echo ${toBackup[@]}

#[TASK 12]
echo 'task12 : the following files will be in backup-$currentTS.tar.gz'
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13]
echo 'task13 : the backup-$currentTS.tar.gz file will be moved in destAbsPath'
mv $backupFileName $destAbsPath
ls $destAbsPath
echo "here is the file in the backup-$currentTS.tar.gz : "
tar -tf "$destAbsPath/$backupFileName"

# Congratulations! You completed the final project for this course!
