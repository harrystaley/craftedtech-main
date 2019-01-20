---
title: "Vagrant Virtualbox Setup"
date: 2019-01-19T11:35:51-06:00
draft: false
---

#What are VirtialBox and Vagrant and what can they do for me?

##VirtualBox
You can use VirtualBox to run an entire sandboxed operating system within your own computer.

##Vagrant
You can use Vagrant to manage a development environment. Through the command line, you can download, install, configure, and run any available OS, do your work inside of it, shut it down, rebuild it on the fly, and more.

##The Dynamic Duo
Through the use of VirtualBox and Vagrant, you can simulate the production environment of your production server. For example, if you’re using Digital Ocean or AWS to run a Virtual Private Server (VPS) in the cloud running your favorite stack (Ubuntu, Python, and MySQL) you can install local versions to have a duplicate enviorment, while keeping your own computer’s software untouched. Thus reducing the incidents of errors resulting from trying to develop code for a production server on an environment that does not match your local machine.

This process can be used for several servers or projects that you are working on at the same time all while the work files are available to your local machine for editing.

#Installation

##1. Install Git

###WINDOWS
- Install Git for Windows

[Download Git for Windows](https://git-scm.com/download/win "Git for windows")

Then during installation steps, select below settings:

    “Use Git from the Windows Command Prompt” with this option you will be able to use Git from both Git Bash and the Windows Command Prompt.
    “Checkout as-is, commit Unix-style line endings”
    "Use MinTTY"
And finish the installation.

###MAC
- Install Homebrew from your terminal
[Homebrew](https://brew.sh/ "Homebrew: The package manager that Apple forgot")

- Install Git form your terminal
{{< highlight bash >}}
brew install git
{{< /highlight >}}

### Linux

Debian based systems such as Ubuntu or Mint
{{< highlight bash >}}
sudo apt install git-all
{{< /highlight >}}

RPM Based Systems such as RHEL or CentOS
{{< highlight bash >}}
sudo dnf install git-all
{{< /highlight >}}

##2. Install VirtualBox
Install the most recent version of VirtualBox.
[Virtualbox Downloads](https://www.virtualbox.org/wiki/Downloads "Virtualbox Downloads")

##3. Install Vagrant
Install the most recent version of Vagrant.
[Vagrant Downloads]( https://www.vagrantup.com/downloads.html "Vagrant Downloads")

##4. Create a new directory for your vagrant instance which will be shared with your host OS that can contain configuration scripts. e.g. Websites, or Work-environments.

{{< highlight bash >}}
mkdir my_new_vagrant_box // creates a directory named "my_new_vagrant_box"
cd my_new_vagrant_box // changes the current directory to "my_new_vagrant_box"
{{< /highlight >}}

##5. Get up and going. 

From the command line, run the following commands to get a base box and start up the VM:
{{< highlight bash >}}
vagrant init bento/ubuntu-18.04
vagrant up
{{< /highlight >}}

NOTE:
All files located in the same folder as your vagrant file will be available for use by the virtual machine in the ```/vagrant``` directory when you login.

In our example files located in the ```my_new_vagrant_box``` directory will be available to the virtual machine as well.

##6. Connect to your new virtual machine.

{{< highlight bash >}}
vagrant ssh
{{< /highlight >}}
You will then presented with a command prompt such as below.

{{< highlight bash >}}
vagrant@vagrant:~$
{{< /highlight >}}

To view the files that are in the folder where you ```vagrantfile``` is located.
{{< highlight bash >}}
cd /vagrant
{{< /highlight >}}

Have fun with your new linux virtual machine.

   
To return to your host machine, run the command:
{{< highlight bash >}}
 exit
{{< /highlight >}}


##Additional Commands
To destroy the VM and remove the binary disk image:
{{< highlight bash >}}
vagrant destroy 
{{< /highlight >}}
NOTE: This command must be run from the directory which contains the Vagrantfile for the box you wish to destroy. It will not remove any of your configuration files. To recreate the machine, use the commands in step 4.


