#!/bin/sh

# 跳转至当前目录
cd `dirname $0`

# 程序备份根目录
program_base="`pwd`/bak-program"
echo "program backup base dir： ${program_base}"

# 创建本次备份文件夹、设置备份目录变量
mkdir -p ${program_base}/$(date +%Y%m%d-%H%M%S)/ && bak_dir="$_"
echo "backup dir : ${bak_dir}"
echo ""

echo "=============================================================================="
echo "backup program files start!"
echo "=============================================================================="

# 备份函数
function doBackup(){
	 echo "coping ${1} !"

	 cp ${1} ${bak_dir}

	 echo "copied ${1} !"
}

# 遍历待备份文件
for x in ` awk '{print $1}' program.txt `  
{  
	 doBackup $x  
}  

echo "backup to ${bak_dir} ok!"
echo ""

# 清理历史文件
echo "=============================================================================="
echo "clear program files start!"
echo "=============================================================================="

echo "file list:"
find $program_base -mtime +30 -name "*.*" 

echo "remove files..."
find $program_base -mtime +30 -name "*.*" -exec rm -rf {} \;

echo "clear files ok!"

