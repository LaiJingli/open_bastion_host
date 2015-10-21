#!/bin/bash
### 一键添加跳板机用户，并初始化用户，批量添加多个用户时，多个用户之间以空格分隔
### coding by laijingli2006@126.com at 20151019

#users="laijingli"
users=""
user_group=tiaobanji
default_pass=321
for user in $users ; do echo $user;useradd $user;echo $default_pass|passwd --stdin $user;chage -d 0 $user;usermod -G $user_group $user;done



