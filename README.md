## Create workstation for java, scala, groovy and python developers

### Pre-requisites
Following tools should be installed on your host OS
* virtual box
* vagrant
* git
* `~/projects` code repositories cloned here will be mounted to `/vagrant/home/projects`
* clone [developer-workstation-setup-using-vagrant](git@github.com:rajanpatil/developer-workstation-setup-using-vagrant.git)

### How to setup
* Once pre-requisites are met, you can checkout or copy this repository on your host OS.
* Go to this repository with `gitbash` and run `vagrant up` command. This activity is one time and might take 10 to 15 mins.
* Once setup is finished, you can ssh into your guest with `vagrant ssh` command.

### How to re-create

You already have vagrant box setup and now there are some changes to the provision list, in this scenario it's recommended to re-create the vagrant box. 

Following steps will guide you through re-create:
* Destroy the existing vagrant box with command `vagrant destroy`, it will ask you to confirm `default: Are you sure you want to destroy the default VM? [y/N]`, type y and enter.
* Create vagrant box again, `vagrant up`

### Useful vagrant commands
* Validates Vagrantfile: `vagrant validate`
* State of the machines Vagrant is managing: `vagrant status` 
* Creates and configures guest machines according to your Vagrantfile: `vatrant up`
* SSH into a running Vagrant machine: `vagrant ssh`
* Destory guest machine: `vagrant destroy`

  For more information please visit [vagrant docs](https://www.vagrantup.com/docs/cli/)

### Following tools are installed and configured

* jdk
  * openjdk-8-jdk
  * openjdk-9-jdk
  * openjdk-10-jdk
  * openjdk-11-jdk
* scala [scala-2.11.6.tgz](http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz)
* groovy
* git
* vim
* fish
* zip
* unzip
* build tools
  * mvn
  * gradle
  * sbt
* mongodb
* docker
* packer
* terraform
* environment managers
  * [jenv](https://github.com/gcuisinier/jenv.git)
  * [pyenv](https://github.com/yyuu/pyenv.git)
  * [tfenv](https://github.com/tfutils/tfenv.git)
* Port forwarding 
  * http ```8080 (host) -> 8080 (guest)```
  * https ```443 (host) -> 443 (guest)```
* Current host directory mounted in guest
   * ```<<vagrant project repo>> ->/vagrant```
   * ```~/projects -> /home/vagrant/projects``` (clone code repositories in `~/projects`)
   
### How to change disk size

The default disk size for the given image is 10GB, follow below steps if you want to change the disk size.

* Install plugin on your host vagrant plugin install vagrant-disksize
* Uncomment `config.disksize.size = '50GB'` line in Vagrantfile and change the disk size.
* Create/re-create vagrant machine.

### Resources
* [vagrant](https://www.vagrantup.com/intro/index.html)
* [jenv](https://github.com/gcuisinier/jenv)
* [pyenv](https://github.com/pyenv/pyenv)
* [tfenv](https://github.com/tfutils/tfenv.git)

