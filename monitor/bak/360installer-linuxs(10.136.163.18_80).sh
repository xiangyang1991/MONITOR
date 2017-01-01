#!/bin/sh

#日志level
ERROR="ERROR"
INFO="INFO"
WARNING="WARNING"

#function:  写日志函数
Log()
{
	log_level=$1
	msg=$2

	if [ ! -f "/var/log/360safeinst.log" ]; then
		touch /var/log/360safeinst.log
	fi

	local datefmt="`date "+%Y-%m-%d %H:%M:%S"`"
	local log_info="$datefmt $log_level: $msg"
	echo "$log_info" >> /var/log/360safeinst.log
}

#设置全局变量
is_susport_chinese=0
server_ip=""
server_port=""
filename=$0
LINUX_CLIENT=2
LINUX_SERVER=1
argc=$#
arg=$1
SP_FLAG="______" #特殊字符替代空格
save_filepath=""
exc_filepath=""
is_deepin=0
intime="`date '+%s'`"

#本地中英文提示
local_index=0
eval local_chinese$local_index="命令行参数不对,请重新运行脚本"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="输入有误,程序退出,请重新运行"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="您当前系统暂且不支持自动安装部署！"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="保存安装包名称文件失败\(创建\/opt目录失败\)"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="网络异常，请检查网络后重新运行！"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="很抱歉,您当前的系统暂不支持..."
local_index=`expr $local_index + 1`
eval local_chinese$local_index="下载失败"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="正在更新..."
local_index=`expr $local_index + 1`
eval local_chinese$local_index="安装失败！"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="警告:安装包不支持32操作系统!"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="检测不到您当前的类型请手动安装！"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="##当前支持以下linux操作系统:"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="警告:您需要在root用户下运行安装脚本!"
local_index=`expr $local_index + 1`
eval local_chinese$local_index="您已经安装过该程序,执行安装失败!"

local_index=0
eval local_english$local_index="The\ command\ line\ argument\ is\ incorrect.\ Please\ run\ the\ script\ again!"
local_index=`expr $local_index + 1`
eval local_english$local_index="you\ inputed\ error\ arguments,\ and\ the\ program\ exited,\ please\ run\ again!"
local_index=`expr $local_index + 1`
eval local_english$local_index="Your\ current\ system\ does\ not\ be\ supported\ by\ the\ automatic\ installation!"
local_index=`expr $local_index + 1`
eval local_english$local_index="package\ file\ \ be\ incorrectly\ saved\ \(create\ directory\ \/opt\ error\)!"
local_index=`expr $local_index + 1`
eval local_english$local_index="Network\ exception,\ please\ run\ again\ after\ checking\ network\ condition!"
local_index=`expr $local_index + 1`
eval local_english$local_index="Sorry,\ your\ current\ system\ is\ not\ supported..."
local_index=`expr $local_index + 1`
eval local_english$local_index="downloaded\ error!"
local_index=`expr $local_index + 1`
eval local_english$local_index="updating\ now..."
local_index=`expr $local_index + 1`
eval local_english$local_index="installed\ error!"
local_index=`expr $local_index + 1`
eval local_english$local_index="warning:Install\ pack\ does\ not\ support\ 32bit\ system!"
local_index=`expr $local_index + 1`
eval local_english$local_index="cannot\ detect\ your\ system\ type,\ please\ install\ by\ choosing\ index\ number!"
local_index=`expr $local_index + 1`
eval local_english$local_index="##Currently\ the\ following\ Linux\ systems\ could\ be\ supported:"
local_index=`expr $local_index + 1`
eval local_english$local_index="warning:you\ should\ run\ this\ script\ in\ the\ root\ environment"
local_index=`expr $local_index + 1`
eval local_english$local_index="you\ had\ installed\ this\ software,\ and\ installed\ error!"

#本机系统信息记录表, 0 -- "osname", 1 -- "version", 2 -- "release_info"
#Os_Name=(["osname"]="" ["version"]="" ["release_info"]="")
Os_Name_index=0
eval Os_Name$Os_Name_index=""
Os_Name_index=`expr $Os_Name_index + 1`
eval Os_Name$Os_Name_index=""
Os_Name_index=`expr $Os_Name_index + 1`
eval Os_Name$Os_Name_index=""

#本地所识别的系统名称
sys_name_index=0
eval sys_name$sys_name_index="centos"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="ubuntu"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="redhat"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="suse"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="deepin"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="neokylin"
sys_name_index=`expr $sys_name_index + 1`
eval sys_name$sys_name_index="fedora"

#function:  判断系统是否支持中文
isSupportChinese()
{
	# ESXi中没有tty指令
	is_esxi=0

    # is esx 4 ?
    if [ -f "/etc/vmware-release" ]; then
    	if [ "`cat /etc/vmware-release 2>/dev/null | awk '{print $2}' | head -n 1`" = "ESX" ]; then
    		is_esxi=1
    	fi
    fi
    
    # is esxi 5 or 6 ? 
    if [ "`uname -a | awk '{print $1}' | head -n 1`" = "VMkernel" ]; then
    	is_esxi=1
    fi

    if [ $is_esxi -eq 1 ]; then
    	return 0
    else
		local byte_command="`locale -a | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' | grep "zh_cn.utf8"`"
		local connect_command="`export | grep LANG | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' | grep "zh_cn"`"
		local tty_content="`tty | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' | grep "tty"`"
		if [ "$tty_content" != "" ]; then
			return 0
		fi

	    if [ "$byte_command" != "" ] && [ "$connect_command" != "" ]; then
	        return 1
	    else
	    	return 0
	    fi   	
    fi 	
}

#function:  系统如果支持中文,就中文输出,否则英文输出
printtext()
{
	if [ $is_susport_chinese -eq 1 ]; then
		# 输出中文信息
		echo $1
	else
		# 输出英文信息
		for index_i in $(seq 0 $local_index)
		do
			eval temp_data=\$local_chinese$index_i
			if [ "$temp_data" = "$1" ]; then
				eval echo "\$local_english$index_i"
				return
			fi
		done		
	fi
}

#function: 获取系统的位数, 1 == 64, 0 == 32
getOsBit()
{
    local bitcontent="`uname -a`"
    if [ "`echo $bitcontent | grep "x86_64"`" != "" ]; then
    	return 1
    fi
    #增加了对i386和i686的检查
    if [ "`echo $bitcontent | grep "x86"`"  != "" ] \
    || [ "`echo $bitcontent | grep "i386"`" != "" ] \
    || [ "`echo $bitcontent | grep "i686"`" != "" ]; then
    	return 0
    fi

    #如果是mips框架，则无法通过上述方法获得系统位数
    if [ "`echo $bitcontent | grep "deepin"`" != "" ]; then
    	is_deepin=1
    fi

    if [ "`echo $bitcontent | grep "mips64"`" != "" ]; then
    	return 1
    else
    	return 0
    fi
}

#function: 根据当前安装脚本文件的名称，获得ip和端口号
getServerIpAndPort()
{
    local temp_filename=${filename#*(}
	local ip_and_port=${temp_filename%)*}
	server_ip=${ip_and_port%_*}
	server_port=${ip_and_port##*_}
}

#function: 根据文件名称判断客户端类型
getClientType()
{
	if [ "`echo $filename | grep "linuxc"`" ]; then
		return ${LINUX_CLIENT}
	elif [ "`echo $filename | grep "linuxs"`" ]; then
		return ${LINUX_SERVER}
	else
		return -1
	fi
}

#function: 根据客户端类型，得到主界面显示的系统数组
init_supported_os_matrix()
{
	array_len=0
	if [ $1 -eq ${LINUX_SERVER} ]; then
		eval osType_array$array_len="ubuntu"; eval min_array$array_len="10"; eval max_array$array_len="14"
		eval pkg_array$array_len="360safe-ubuntu.deb"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="centos"; eval min_array$array_len="5";  eval max_array$array_len="5"
		eval pkg_array$array_len="360safe-centos.rpm";  array_len=`expr $array_len + 1`
		eval osType_array$array_len="centos"; eval min_array$array_len="6";  eval max_array$array_len="7"
		eval pkg_array$array_len="360safe-centos.rpm";  array_len=`expr $array_len + 1`
		eval osType_array$array_len="redhat"; eval min_array$array_len="5";  eval max_array$array_len="5"
		eval pkg_array$array_len="360safe-centos.rpm";  array_len=`expr $array_len + 1`
		eval osType_array$array_len="redhat"; eval min_array$array_len="6";  eval max_array$array_len="7"
		eval pkg_array$array_len="360safe-centos.rpm";  array_len=`expr $array_len + 1`
		eval osType_array$array_len="suse";   eval min_array$array_len="11"; eval max_array$array_len="12"
		eval pkg_array$array_len="360safe-centos.rpm";  array_len=`expr $array_len + 1`
		eval osType_array$array_len="h3c";    eval min_array$array_len="2";  eval max_array$array_len="3"
		eval pkg_array$array_len="360safe-ubuntu.deb"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="VMware\ ESX";  eval min_array$array_len="4";  eval max_array$array_len="4"
		eval pkg_array$array_len="360safe-centos.rpm"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="VMware\ ESXi"; eval min_array$array_len="5";  eval max_array$array_len="5"
		eval pkg_array$array_len="360safe-esxi5.tar"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="VMware\ ESXi"; eval min_array$array_len="6";  eval max_array$array_len="6"
		eval pkg_array$array_len="360safe-esxi5.tar"
	elif [ $1 -eq ${LINUX_CLIENT} ]; then
		eval osType_array$array_len="Neokylin_server\ v6u5"; eval min_array$array_len=""; eval max_array$array_len=""
		eval pkg_array$array_len="360safe-for-linuxclient-neokylin_advanceserver_mipsel-v6u5.rpm"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="Neokylin_desktop\ v6";  eval min_array$array_len=""; eval max_array$array_len=""
		eval pkg_array$array_len="360safe-for-linuxclient-neokylin_desktop_mipsel-v6.rpm"; array_len=`expr $array_len + 1`		
		eval osType_array$array_len="deepin\ 2015";          eval min_array$array_len=""; eval max_array$array_len=""
		eval pkg_array$array_len="360safe-for-linuxclient-deepin_mipsel-201501.deb"; array_len=`expr $array_len + 1`
		eval osType_array$array_len="Neokylin_desktop\ v7";  eval min_array$array_len=""; eval max_array$array_len=""
		eval pkg_array$array_len="360safe-for-linuxclient-neokylin_desktop_mipsel-v7.rpm"		
	else
		#未处理
		return
	fi
}


#function:  H3C系统
isH3c()
{
	if [ ! -f "/etc/h3c_cas_cvk-version" ]; then
		osname_version="_"
	else
		# 此处{print $2}和python的{print $3}不同
		local version_info="`cat /etc/h3c_cas_cvk-version 2>/dev/null | awk '{print $2}' | head -n 1`"
		local version="`expr substr "$version_info" 2 1`"
		if [ "$version" = "2" ] || [ "$version" = "3" ]; then
			osname_version="h3c_$version"
		else
			printtext "警告:不支持当前h3c系统！"
			exit 1
		fi
	fi
}

#function:  ESXi系统
isEsxi()
{
    # is esx 4 ?
    if [ -f "/etc/vmware-release" ]; then
    	local osname="`cat /etc/vmware-release 2>/dev/null | awk '{print $2}' | head -n 1`"
    	local version_info="`cat /etc/vmware-release 2>/dev/null | awk '{print $3}' | head -n 1`"
    	local version="${version_info:0:1}"
    	if [ "$osname" = "ESX" ] && [ "$version" = "4" ]; then
    		osname_version="VMware?ESX_$version"
    		return
    	fi
    fi
    
    # is esxi 5 or 6 ? 
    local osname="`uname -a | awk '{print $1}' | head -n 1`"
	if [ "$osname" = "VMkernel" ]; then
		local version_info="`uname -a | awk '{print $3}' | head -n 1`"
		local version="${version_info:0:1}"
		if [ "$version" = "5" -o "$version" = "6" ]; then
			osname_version="VMware?ESXi_$version"
			return
		fi
	fi

    osname_version="_"
}

#function: 从系统文件中获取系统名称,得到系统的名称和发行版本号
getOsInfo()
{
	local list_etc_file="/etc/"
	local index_idx=0

	#检测顺序先"*-release$"文件，再"^isuue*"文件
	# 添加"-release$"文件
	for item in `ls $list_etc_file | grep -i "release"`
	do
		if [ ! -d "$list_etc_file/$item" ]; then
			local tempfilename="`echo $item | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
			if [ "`echo "$tempfilename" | grep "\-release$"`" != "" -a "$item" != "os-release" ]; then
				eval searchfileDict$index_idx="$item"
				index_idx=`expr $index_idx + 1`
			fi
		fi
	done

	# 添加和"^issue*"相关的文件，查找文件有所增加
	for item in `ls $list_etc_file | grep -i "issue"`
	do
		if [ ! -d "$list_etc_file/$item" ]; then
			local tempfilename="`echo $item | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
			if [ "`echo "$tempfilename" | grep "^issue"`" != "" ]; then
				eval searchfileDict$index_idx="$item"
				index_idx=`expr $index_idx + 1`
			fi
		fi
	done

	index_idx=`expr $index_idx - 1`
	for index_i in $(seq 0 $index_idx)
	do
		eval item="\$searchfileDict$index_i"
		local file_text="`cat "$list_etc_file$item" | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
		local is_ok=0
		for index_j in $(seq 0 $sys_name_index)
		do
			eval os_item="\$sys_name$index_j"
			local is_redhat=0
			if [ "$os_item" = "redhat" ] && [ "`echo "$file_text" | grep "red"`" != "" ] && [ "`echo "$file_text" | grep "hat"`" != "" ]; then
				is_redhat=1
			fi
			if [ "`echo "$file_text" | grep "$os_item"`" != "" ] || [ $is_redhat -eq 1 ]; then
				# 得到系统名称
				is_ok=1
				eval Os_Name0="$os_item"
				file_text="`echo $file_text | sed 's/ /'$SP_FLAG'/g'`"
				file_text="`echo $file_text | sed 's/\\\n/ /g'`"
				index_k=0
				for file_text_temp in $file_text
				do
					eval list_release_text$index_k="'$file_text_temp'"
					index_k=`expr $index_k + 1`
				done
				index_k=`expr $index_k - 1`
				eval temp_release_info="\$list_release_text0"
				temp_release_info="`echo $temp_release_info | sed 's/'$SP_FLAG'/ /g'`"
				# 如分析issue文件和一些redhat-release文件
				local temp_release_info_lower="`echo $temp_release_info | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
				if [ "`echo $temp_release_info_lower | grep $os_item`" != "" ] || [ $is_redhat -eq 1 ]; then
					eval Os_Name2="'$temp_release_info'"
					eval release_info_temp="\$Os_Name2"
					for temp_version in $release_info_temp
					do
						local temp_version_domain="`echo $temp_version | sed 's/\.//g'`"
						if [ "`echo $temp_version_domain | sed 's/[0-9]//g'`" = "" ]; then
							eval Os_Name1="$temp_version"
							break;
						fi
					done
				else
					eval Os_Name1=""
					eval Os_Name2=""
				fi
				break
			fi
		done
		eval tempOsName1="\$Os_Name1"
		eval tempOsName2="\$Os_Name2"
		if [ "$tempOsName1" = "" ] || [ "$tempOsName2" = "" ]; then
			continue;
		fi
		if [ $is_ok -eq 1 ]; then
			break
		fi
	done
}

#function: 得到系统的名称，由具体名称和发行版本号组成
getOsName()
{
	#得到系统的名称和发行版本号
	getOsInfo

	eval temposname="\$Os_Name0"
	eval ostype="\$Os_Name2"
	if [ "$temposname" != "" ]; then
        #如果是麒麟系统,则需要判断是否为server版本，还是桌面版本
        local osname_temp="`echo $temposname | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
		if [ "$osname_temp" = "neokylin" ]; then
			ostype_temp="`echo $ostype | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
			if [ "`echo "$ostype_temp" | grep "server"`" != "" ]; then
				temposname=$temposname"_server"
			else
				temposname=$temposname"_desktop"
			fi
		fi
		osname="$temposname"
		return		
	fi
}

#function: 得到系统的全版本号
getOsAllVersion()
{
	# python版本使用了platform模块
	# 参考getOsInfo中Os_Name["version"]
	eval version="\$Os_Name1"
}

#function:  自动检测系统类型，并显示
showAutoCheckOs()
{
	# is H3C System?
	osname_version=""
	isH3c
	osname=${osname_version%_*}
	version=${osname_version##*_}
	if [ "$osname" = "" ] && [ "$version" = "" ]; then
		# is ESX/ESXi Systerm?
		isEsxi
		if [ "$osname_version" != "_" ]; then
			osname="${osname_version%_*}"
			osname=${osname/'?'/' '}	
			version="${osname_version##*_}"
		fi
		if [ "$osname" = "" ] || [ "$version" = "" ]; then
			getOsName
			getOsAllVersion
		fi
	fi

	if [ "$osname" = "" ]; then
		printtext "检测不到您当前的类型请手动安装！"
	else
		Log $INFO "您当前的系统类型为：$osname"
		if [ $is_susport_chinese -eq 1 ]; then
			echo "您当前的系统类型为：$osname $version"
		else
			echo "Your current system type is:$osname $version"
		fi
	fi
}

#function:  主菜单显示
main_menu_show()
{
    echo "#######################Installation steps ###########################"
    printtext "##当前支持以下linux操作系统:"
    for idx in $(seq 0 $array_len)
    do
    	eval osname="\$osType_array$idx"
    	eval min_version="\$min_array$idx"
    	eval max_version="\$max_array$idx"
    	if [ "$idx" -ge "9" ]; then
	    	if [ "$min_version" = "$max_version" ]; then
	    		echo "## `expr $idx + 1`: ${osname} ${min_version} "
	    	else
	    		echo "## `expr $idx + 1`: ${osname} ${min_version}-${max_version} "
	    	fi
	    else
	    	if [ "$min_version" = "$max_version" ]; then
	    		echo "## `expr $idx + 1`:  ${osname} ${min_version} "
	    	else
	    		echo "## `expr $idx + 1`:  ${osname} ${min_version}-${max_version} "
	    	fi
	    fi

    done
    echo "#####################################################################" 

    showAutoCheckOs
    if [ $is_susport_chinese -eq 1 ]; then
    	echo "按回车，即开始下载安装linux终端;"
    	echo "如操作系统识别错误,请您输入列表中对应的数字,按回车即可下载："
    	read choose_content
    else
    	echo ".Please straightly press 'Enter' key, you can download and install the linux client;"
    	echo " if your system type will be incorrectly identified, you should input the numbers in the table and press 'enter' key!"
    	read choose_content
    fi
}

#function: 得到系统发行大版本号
getOsVersion()
{
	eval version="\$Os_Name1"
	version="${version%%.*}"
}

#function: 自动安装,主界面上的索引号
getautoType()
{
	# is H3C System?
	osname_version=""
	isH3c
	osname=${osname_version%_*}
	version=${osname_version##*_}

	if [ "$osname" = "" ] && [ "$version" = "" ]; then
		# is ESX/ESXi Systerm?
		isEsxi
		if [ "$osname_version" != "_" ]; then
			osname="${osname_version%_*}"
			osname=${osname/'?'/' '}
			version="${osname_version##*_}"
		fi
		
		if [ "$osname" = "" ] || [ "$version" = "" ]; then
			getOsName
			getOsVersion
		fi
	fi
	Log $INFO "系统为$osname"
	Log $INFO "版本为$version"

	#得到当前的索引
	for i in $(seq 0 $array_len)
	do
		eval os_name_info="\$osType_array$i"
		eval os_min_version="\$min_array$i"
		eval os_max_version="\$max_array$i"
		#国产卫士自动安装不匹配版本信息,也提取不到
		if [ "$os_min_version" = "" ] && [ "$os_max_version" = "" ]; then
			local os_name_upper="`echo $os_name_info | sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/'`"
			local osname_upper="`echo $osname | sed 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/'`"
			if [ "`echo "$os_name_upper" | grep "$osname_upper"`" != "" ]; then
				Log $INFO "国产卫士  -  得到了主界面索引"
				if [ "$osname" = "neokylin_desktop" ] && [ "$version" = "7" ]; then
					choose_content=`expr $i + 3`
					return
				else
					choose_content=`expr $i + 1`
					return
				fi
			fi
		fi
		#linux　server版本匹配
		if [ "$os_name_info" = "$osname" ] && [ ${#version} -le ${#os_max_version} ]; then
			if [ ${#version} -lt ${#os_max_version} ]; then
				version="0$version"
			fi
			if [ "$version" \< "$os_max_version" -o "$version" = "$os_max_version" ] && \
				[ "$version" \> "$os_min_version" -o "$version" = "$os_min_version" ]; then
				Log $INFO "linux server  -  得到了主界面索引"
				choose_content=`expr $i + 1`
				return
			fi
		fi
	done
	Log $INFO "自动安装没有得到主界面上的索引号"
	choose_content=-1
}

#function: 得到系统的cpu架构
getMachine()
{
	local machine_content="`uname -a`"
	if [ "`echo "$machine_content" | grep "x86"`" != "" ]; then
		Machine_Arc="x86"
	elif [ "`echo "$machine_content" | grep "mips"`" != "" ]; then
		Machine_Arc="mips"
	fi
}

#function: 获取本地的下载的安装包名称,
getLoaclPkg()
{
	eval pkgname="\$pkg_array`expr $idx - 1`"
	eval osTyep_typename="\$osType_array`expr $idx - 1`"
	local pkg_osname="`echo $osTyep_typename | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`"
	local Machine_Arc=""
	getMachine

	# 将版本"5"与版本"6"进行区分
	if [ "`echo "$pkg_osname" | grep "neokylin_server"`" != "" ] && [ "$Machine_Arc" = "x86" ]; then
		if [ "$version" = "5" ]; then
			pkgname="360safe-centos.rpm"
		else
			pkgname="360safe-centos.rpm"
		fi
	fi
	pkg=$pkgname
}

#function: 执行文件路径
getSaveDir()
{
	if [ -d "/vmfs/volumes" ]; then
		excutefilepath="/vmfs/volumes/datastore1/"
	else
		excutefilepath="/opt/"
	fi
}

#function: 将安装包和ip以及端口号进行拼接,格式：文件名(10.1.1.1_80).后缀名, 用来保存到本地中
renameFileName()
{
	local l_oldname=${newname%.*}
	local r_oldname=${newname##*.}
	local new_name="$l_oldname(${server_ip}_$server_port).$r_oldname"

	#执行的文件
	local excutefilepath=""
	getSaveDir
	# 此处修改了运行文件名称
	exc_filepath="${excutefilepath}${intime}${l_oldname}.${r_oldname}"

	renamed_name="$new_name"
}

#function: 将安装包的名称写入到文件中
savePkgName()
{
	if [ ! -d "/opt" ]; then
		mkdir "/opt"
	fi
	cat /dev/null > "/opt/pkgname.txt"
	echo "pkgname=\"$1\"" >> "/opt/pkgname.txt"
	if [ $client_type -eq $LINUX_CLIENT ]; then
		echo "type=2" >> "/opt/pkgname.txt"
	fi
}

#function: 得到下载路径信息，根据操作系统的位数
geturl()
{
	local idx=$choose_content
	local pkg=""
	getLoaclPkg
	if [ "$pkg" != "" ]; then
		Log $INFO "server_ip:$server_ip"
		Log $INFO "server_port:$server_port"
		local url_part="http://$server_ip:$server_port/download/setup_linux/"
		if [ $get_Os_Bit -eq 0 ] || [ $is_deepin -eq 1 ] \
		|| [ "$osname" = "neokylin_desktop" -a "$version" = "6" ]; then
			local lname=${pkg%.*}
			local rname=${pkg##*.}
			newname="$lname-x86.$rname"
			local renamed_name=""
			renameFileName
			savePkgName $renamed_name
			local excutefilepath
			getSaveDir	
			save_filepath="${excutefilepath}${renamed_name}"
			url="${url_part}${newname}"
			return
		elif [ $get_Os_Bit -eq 1 ]; then
			local lname=${pkg%.*}
			local rname=${pkg##*.}
			newname="$lname-x64.$rname"
			local renamed_name=""
			renameFileName
			savePkgName $renamed_name
			local excutefilepath
			getSaveDir	
			save_filepath="${excutefilepath}${renamed_name}"
			url="${url_part}${newname}"
			return			
		else
			url=""
			return
		fi
	else
		url=""
	fi
}

#function: 判断url是否可以访问
getNetStateCode()
{
    url_ok=1
}


#function: 下载安装包
downloadfile()
{
	local url=""
	#这里就不那啥了，直接用choose_content
	geturl
	local excutefilepath=""
	getSaveDir
	if [ ! -d "$excutefilepath" ]; then
		Log $INFO "save_dirpath文件夹失败"
		mkdir "$excutefilepath"
	fi
	#下载文件
	if [ "$url" != "" ]; then
		Log $INFO "下载的url：$url"
		echo $url
		local url_ok=0
		# 判断网络是否畅通
		getNetStateCode $url
		if [ $url_ok -eq 0 ]; then
			printtext "网络异常，请检查网络后重新运行！"
			return 0
		fi

		# is esx 4 ? 不支持wget
    	if [ "$osname" = "VMware\ ESX" ] && [ "$version" = "4" ]; then
			echo ""
			curl -o "${excutefilepath}${intime}${newname}" $url
			echo ""
			return 1
    	fi

	    # is esxi 5 or 6 ? wget参数不支持-t
		if [ "$osname" = "VMware\ ESXi" ] && [ "$version" = "5" -o "$version" = "6" ]; then
			echo ""
			wget -O "${excutefilepath}${intime}${newname}" $url
			echo ""
			return 1
		fi

		# others 暂未发现wget下缺陷
		echo ""
		wget -t 3 -O "${excutefilepath}${intime}${newname}" $url
		echo ""
		return 1

	else
		Log $ERROR "url无效"
		printtext "很抱歉,您当前的系统暂不支持..."
		return 0
	fi
}

#function: 判断程序是否之前已经安装
isInstall()
{
	local testpath=""
	if [ $client_type -eq $LINUX_CLIENT ]; then
		testpath="/opt/360safeforcnos"
	else
		testpath="/opt/360safe"
	fi
	if [ ! -d "$testpath" ]; then
		return 0
	else
		return 1
	fi
}

#function:  执行下载后的安装包
executeSetup()
{
    #根据文件的后缀名来区分应该执行的命令
    local expand_name=${exc_filepath##*.}
    echo $exc_filepath
    if [ "$expand_name" = "deb" ]; then
    	printtext "正在更新..."
    	Log $INFO "执行deb包安装"
    	local command_pre="dpkg -i "
    	local command_name="$command_pre$exc_filepath"
    	echo $command_name
    	$command_name
    	if [ $? -ne 0 ]; then
    		Log $ERROR "执行安装包失败"
    		printtext "安装失败！"
    	fi
    elif [ "$expand_name" = "rpm" ]; then
    	printtext "正在更新..."
    	Log $INFO "执行rpm包安装"
    	local command_pre="rpm -U "
    	local command="$command_pre$exc_filepath"
    	$command
    	if [ $? -ne 0 ]; then
    		Log $ERROR "执行安装包失败"
    		printtext "安装失败！"
    	fi
    elif [ "$expand_name" = "tar" ]; then
	 	printtext "正在更新..."
		Log $INFO "执行tar包安装" 
		local command_pre="tar -xf "
		local excutefilepath=""
		getSaveDir
		local command="$command_pre$exc_filepath -C $excutefilepath"
		echo "$command"
		$command
    	if [ $? -ne 0 ]; then
    		Log $ERROR "执行安装包失败"
    		printtext "安装失败！"
    	fi		
    	local curdir="`pwd`"
    	cd $excutefilepath
    	command="sh ${excutefilepath}install.sh ${excutefilepath} ${server_ip} ${server_port}"
    	echo $command
    	$command
    	if [ $? -ne 0 ]; then
    		Log $ERROR "执行安装包失败"
    		printtext "安装失败！"
    	fi	
    	cd $curdir   	
    else
    	Log $ERROR "安装失败"
    	printtext "安装失败！"
    fi
}

#function: 安装完成后清理数据，包括pkgname， deb的包
removeData()
{
	rm /opt/pkgname.txt
	local excutefilepath=""
	getSaveDir
	if [ -f "${excutefilepath}360autostart.vib" ]; then
		rm ${excutefilepath}360autostart.vib
	fi
	if [ -f "${excutefilepath}360safe-for-esxi-x64.tar.gz" ]; then
		rm ${excutefilepath}360safe-for-esxi-x64.tar.gz
	fi
	if [ -f "${excutefilepath}install.sh" ]; then
		rm ${excutefilepath}install.sh
	fi		
	echo " rm $exc_filepath "
	rm $exc_filepath
}

#function:  主函数
run()
{

	isSupportChinese
	local is_susport_chinese=$?

	# 判断当前用户是否为root,分为esx系列和其它
	sys_is_exsi=0

    # is esx 4 ?
    if [ -f "/etc/vmware-release" ]; then
    	if [ "`cat /etc/vmware-release 2>/dev/null | awk '{print $2}' | head -n 1`" = "ESX" ]; then
    		sys_is_exsi=1
			#判断当前用户是否为root
			if [ "$USER" != "root" ]; then
		        printtext "警告:您需要在root用户下运行安装脚本!"
		        exit 1
			fi
    	fi
    fi
    # is esxi 5 or 6 ? 
    if [ "`uname -a | awk '{print $1}' | head -n 1`" = "VMkernel" ]; then
    	sys_is_exsi=1
		#判断当前用户是否为root
		if [ "$USER" != "root" ]; then
	        printtext "警告:您需要在root用户下运行安装脚本!"
	        exit 1
		fi
    fi
    # other systems 判断当前用户是否为root
    if [ $sys_is_exsi -eq 0 ]; then
		if [ `id -u` -ne 0 ]; then
	        printtext "警告:您需要在root用户下运行安装脚本!"
	        exit 1
		fi
	fi

	#判断操作系统位数
	getOsBit
	local get_Os_Bit=$?
	if [ $get_Os_Bit -eq 0 ]; then
		printtext "警告:安装包不支持32操作系统!"
		exit 1
	fi

	#获取ip和端口
	getServerIpAndPort

    #获取终端类型
	getClientType
	local client_type=$?

    #初始化终端主菜单
    init_supported_os_matrix ${client_type}

    #命令行参数分类
    local choose_content=""
    if [ $argc -gt 1 ]; then
    	printtext "命令行参数不对,请重新运行脚本"
    	exit 1
    elif [ $argc -eq 1 ]; then
    	#带命令行参数执行，计数从1开始
	    if [ -z $(echo $arg | sed -e 's/[0-9]//g') ]; then
	    	#判断数值大小
	    	if [ $arg -gt `expr $array_len + 1` ] || [ $arg -le 0 ]; then
				printtext "命令行参数不对,请重新运行脚本"
				exit 1
	    	else
	    		choose_content=$arg
	    	fi	    	
		else
			printtext "命令行参数不对,请重新运行脚本"
			exit 1
		fi  
	else
		#不带命令行参数执行
		main_menu_show
		local support_nums=$array_len
		if [ "$choose_content" = "" ]; then #自动下载
			Log $INFO "自动下载"
			getautoType
		#判断输入的数字范围，以及是否为整型
		elif [ -z $(echo $choose_content | sed -e 's/[0-9]//g') ]; then
			if [ $choose_content -le `expr $support_nums + 1` -a $choose_content -ge 1 ]; then
				Log $INFO "手动下载"
			else #选择异常
				Log $ERROR "输入有误"
				printtext "输入有误,程序退出,请重新运行"
				exit 1
			fi
		else
			Log $ERROR "输入有误"
			printtext "输入有误,程序退出,请重新运行"
			exit 1					
		fi
	fi
	if [ $choose_content -eq -1 ]; then
		printtext "您当前系统暂且不支持自动安装部署！"
		exit 1
	fi
	local bdown=0
	downloadfile
	bdown=$?
	if [ $bdown -eq 1 ]; then
		Log $INFO "更新开始"
		local is_Install=0
		isInstall
		is_Install=$?
		if [ $is_Install -eq 0 ]; then
			executeSetup
		else
			printtext "您已经安装过该程序,执行安装失败!"
		fi
	fi
	removeData
	exit 1
}

run