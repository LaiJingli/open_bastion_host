#!/bin/bash
###跳板机 by laijingli2006@126.com at 20151017

log=/backup/log/$(date +%Y%m%d%H%M%S)_$(whoami)_tee_audit.log

function_tiaobanji_login (){
	echo
	echo 登录时间:`date`
	echo
	echo "Hi,`whoami`"
	echo "你已进入内部虚机跳板机，跳板机操作会被严格审计，请不要做与工作无关的事情"
	echo 
	#echo -en "\033[31m\033[01m请输入登录自己虚机的用户名及ip，比如 laijingli@192.168.100.xxx(exit退出跳板机系统):\033[0m"
	echo -en "\033[31m\033[01m请输入登录虚机的ip最后一段（比如登录192.168.100.99，直接输入99即可，exit退出）:\033[0m"
	read input_ssh_user_ip
	### 用户输入合法性检查
	until [ "$input_ssh_user_ip" != "" ] && [ $input_ssh_user_ip -gt 1 ] && [ $input_ssh_user_ip -lt 255 ] \
	   || [ "$input_ssh_user_ip" = "exit" ] ;do
		echo -en "\033[31m\033[01m输入不合法，只能是2-254或者exit,请重新输入:\033[0m"
		read input_ssh_user_ip
	done

	if   [ "$input_ssh_user_ip" = "exit" ];then
		echo 退出登录时间:`date`
		exit
	else
		echo -en "\033[31m\033[01m请输入登录虚机192.168.100.$input_ssh_user_ip的用户名:\033[0m"
		read input_ssh_user_name
		### 用户输入合法性检查
		until [ "$input_ssh_user_name" != "" ] || [ "$input_ssh_user_name" = "exit" ];do
			echo -en "\033[31m\033[01m用户名不能为空，输入exit退出,请重新输入:\033[0m"
			read input_ssh_user_name
		done
		if   [ "$input_ssh_user_name" = "exit" ];then  
			echo 退出登录时间:`date`
			exit
		else
			ssh $input_ssh_user_name@192.168.100.$input_ssh_user_ip
			echo 退出登录时间:`date`
		fi
	fi
}

function_tiaobanji_login |tee  $log
