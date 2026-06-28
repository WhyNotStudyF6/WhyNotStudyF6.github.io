+++
date = '2026-06-28T00:00:00+09:00'
draft = false
url = '/wfvh/02-json-api/'
title = '2.如何开放博客 JSON API'
weight = 2
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

## 第三步：建立图片列表

在 static/ 下新建 images.json，列出所有图片路径：

    [
      "/images/dish.png",
      "/images/pjzi.png"
    ]

以后新增图片只需在这个文件里加一行。

## 第四步：部署 FastAPI 到 Render

新建 main.py：

    import requests
    import random
    from fastapi import FastAPI

    app = FastAPI()

    POSTS_JSON = "https://你的域名/wfvh/index.json"
    IMAGES_JSON = "https://你的域名/images.json"

    @app.get("/api/wfvh")
    def get_posts():
        return requests.get(POSTS_JSON).json()

    @app.get("/api/wfvh/random")
    def get_random_post():
        data = requests.get(POSTS_JSON).json()
        return random.choice(data)

    @app.get("/api/images")
    def get_images():
        return requests.get(IMAGES_JSON).json()

    @app.get("/api/images/random")
    def get_random_image():
        data = requests.get(IMAGES_JSON).json()
        return {"url": "https://你的域名" + random.choice(data)}

推送到 GitHub，Render 连接仓库自动部署。

## 可用的 API 地址

    GET /api/wfvh              ← 所有文章
    GET /api/wfvh/random       ← 随机一篇
    GET /api/images            ← 所有图片
    GET /api/images/random     ← 随机一张图片

## 使用方法

用浏览器直接访问：

    https://myapi-u160.onrender.com/api/wfvh
    https://myapi-u160.onrender.com/api/wfvh/random
    https://myapi-u160.onrender.com/api/images
    https://myapi-u160.onrender.com/api/images/random

用 Python 调用：

    import requests

    # 获取所有文章
    posts = requests.get("https://myapi-u160.onrender.com/api/wfvh").json()

    # 随机一篇文章
    post = requests.get("https://myapi-u160.onrender.com/api/wfvh/random").json()

    # 随机一张图片
    image = requests.get("https://myapi-u160.onrender.com/api/images/random").json()
    print(image["url"])