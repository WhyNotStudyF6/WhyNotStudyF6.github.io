+++
date = '2026-06-28T00:00:00+09:00'
draft = false
title = '如何免费搭建个人博客'
+++

本教程教你使用 Hugo + GitHub Pages 搭建个人博客，完全免费，电脑不用一直开着别人也能访问。

## 第一步：安装 Git

去 https://git-scm.com/download/win 下载 64-bit 版本，一路默认安装。

安装完重新打开 cmd，验证：

    git --version

显示版本号说明安装成功。

## 第二步：安装 Hugo

去 https://github.com/gohugoio/hugo/releases/latest 下载 hugo_extended_windows_amd64.zip。

解压后把 hugo.exe 放到 D:\soft\hugo\，然后把 D:\soft\hugo 添加到系统环境变量 Path。

验证：

    hugo version

## 第三步：建站

    D:
    cd D:\soft
    hugo new site myblog
    cd myblog
    git init
    git remote add origin https://github.com/你的用户名/你的用户名.github.io.git

## 第四步：安装主题

    git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

## 第五步：配置站点

打开 hugo.toml，替换成：

    baseURL = "https://你的用户名.github.io/"
    title = "我的博客"
    theme = "PaperMod"

    [outputs]
      home = ["HTML", "RSS", "JSON"]
      section = ["HTML", "RSS", "JSON"]

## 第六步：写第一篇文章

    hugo new content posts/first.md

打开文件，把 draft = true 改成 draft = false，写上内容保存。

## 第七步：部署到 GitHub

新建仓库名为 你的用户名.github.io，然后：

    git add .
    git commit -m "first commit"
    git push -u origin master

去仓库 Settings → Actions → General → Workflow permissions 选读写权限保存。

在 .github/workflows/deploy.yml 添加自动构建配置，推送后 GitHub 自动构建发布。

最后 Settings → Pages → Branch 选 gh-pages 保存。

等 1~2 分钟访问 https://你的用户名.github.io 即可看到博客。

## 发布新文章

每次发文章只需三步：

    1.hugo new content posts/文章名.md
    2.# 编辑文章内容，把 draft = false
    3.新建"D:\soft\myblog\push.bat",文件内容如下
chcp 65001
@echo off
cd /d D:\soft\myblog
git add .
set /p msg=输入提交说明: 
git commit -m "%msg%"
git push
pause

cmd打开目录
D:\soft\myblog>
输入push.bat即可推送修改内容至gith