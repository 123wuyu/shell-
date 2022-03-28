#!/usr/bin/env bash


# 备份
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 获取系统发行版本
version=`cat /etc/redhat-release | awk '{print substr($4,1,1)}'`
printf "\n获取系统版本成功：${version}\n"

if [ ${version} == 7 ]; then
  wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo || curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
  let flag=$?
elif [ ${version} == 6 ]; then
  wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo || curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
  let flag=$?
else
 printf "\n版本不支持，替换 yum repo 失败\n"
fi

if [ ${flag} -eq 0 ]; then
  # 更新缓存
  yum clean all
  yum makecache
  printf "\n替换 yum repo 源结束\n"
else
  printf "\n网络故障，请稍后重试\n"
  exit 1
fi


