---
title: "Building a Hugo Blog "
date: 2019-01-10T09:06:29-06:00
draft: true
---
##Overview
This tutorial is written from the perspective that you are building a local blogging for push later to your server and give you the flexability to test locally and write your blog posts on the remote server as well if you prefer.

### Required Technologies
1. Homebrew
2. Git
3. NGINX
4. HUGO
5. Let's Encrypt

### Steps
1. Install HUGO Locally (OSX) 
2. Install and setup Git Locally
3. Server Setup
	a. Firewall Settings
	b. Setup HUGO
	c. Setup NGINX

## 1. Install Hugo Locally (OSX)
You are installing HUGO locally so that you can write your blog posts locally as well as test your site using the local hugo web server.

### Install Homebrew

{{< higthlight bash >}}
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
{{< /highlight >}}

### Install HUGO

{{< highlight bash >}}
brew install hugo
{{< /highlight >}}

At this point everything should be set up for hugo in your path.

Next lets test it in your terminal.
{{< highlight bash >}}
hugo version
{{< /highlight >}}

you should see something simmilar to below.
{{< highlight bash >}}
Hugo Static Site Generator v0.53/extended darwin/amd64 BuildDate: unknown
{{< /highlight>}}

Ok now that you have HUGO installed locally we can start setting thigns up locally.

Next we are going to set up our basic page and settings.


## 2. Git Setup


## 3. Server Setup

### a. Firewall Settings

### b. Setup HUGO

### c. setup NGINX

## References

[Homebrew Website](https://brew.sh/ "Homebrew Website")

[HUGO Website - Installation](https://gohugo.io/getting-started/installing/ "Hugo Website - Installation")

[Digital Ocean HUGO Tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-hugo-a-static-site-generator-on-ubuntu-14-04 "Digital Ocean Hugo Tutorial")
