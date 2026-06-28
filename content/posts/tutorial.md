+++
date = '2026-06-28T00:00:00+09:00'
draft = false
title = '如何开放博客 JSON API'
+++

本教程介绍如何让别人通过 API 获取你博客的文章和图片内容。

## 原理

Hugo 博客支持输出 JSON 格式，开启后别人可以直接通过 URL 获取文章数据，不需要任何后端服务器。

## 第一步：开启 JSON 输出

打开 hugo.toml，添加以下配置：

    [outputs]
      home = ["HTML", "RSS", "JSON"]
      section = ["HTML", "RSS", "JSON"]

## 第二步：添加 section JSON 模板

新建文件 layouts/_default/list.json.json，内容：

    {{- $pages := .Pages -}}
    [{{ range $i, $e := $pages }}{{ if $i }},{{ end }}{"title":{{ .Title | jsonify }},"permalink":{{ .Permalink | jsonify }},"content":{{ .Plain | jsonify }},"summary":{{ .Summary | jsonify }}}{{ end }}]

## 第三步：建立图片分类

    hugo new content gallery/图片名.md

文章内容只放图片链接：

    <img src="https://你的域名/images/图片.png" alt="描述">

## 可用的 API 地址

    # 所有内容
    https://你的域名/index.json

    # 所有文章
    https://你的域名/posts/index.json

    # 所有图片
    https://你的域名/gallery/index.json

## 用 Python 调用示例

    import requests

    data = requests.get("https://你的域名/index.json").json()
    for post in data:
        print(post["title"], post["permalink"])