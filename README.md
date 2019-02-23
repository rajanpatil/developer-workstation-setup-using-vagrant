## Create workstation for java, scala, groovy and python developers

#### Pre-requisites
Following tools should be installed on your host OS
* virtual box
* vagrant
* git
* `~/projects` code repositories cloned here will be mounted to `/vagrant/home/projects`
* clone [developer-workstation-setup-using-vagrant](git@github.com:rajanpatil/developer-workstation-setup-using-vagrant.git)

## How to setup
* Once pre-requisites are met, you can checkout or copy this repository on your host OS.
* Go to this repository with `gitbash` and run `vagrant up` command. This activity is one time and might take 10 to 15 mins.
* Once setup is finished, you can ssh into your guest with `vagrant ssh` command.

### Useful vagrant commands
* Validates Vagrantfile: `vagrant validate`
* State of the machines Vagrant is managing: `vagrant status` 
* Creates and configures guest machines according to your Vagrantfile: `vatrant up`
* SSH into a running Vagrant machine: `vagrant ssh`
* Destory guest machine: `vagrant destroy`

  For more information please visit [vagrant docs](https://www.vagrantup.com/docs/cli/)


#### Following tools are installed and configured

* jdk
  * openjdk-8-jdk
  * openjdk-9-jdk
  * openjdk-10-jdk
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
* environment managers
  * [jenv](https://github.com/gcuisinier/jenv.git)
  * [pyenv](https://github.com/yyuu/pyenv.git)
* Port forwarding 
  * http ```8080 (host) -> 8080 (guest)```
  * https ```443 (host) -> 443 (guest)```
* Current host directory mounted in guest
   * ```<<vagrant project repo>> ->/vagrant```
   * ```~/projects -> /home/vagrant/projects``` (clone code repositories in `~/projects`)

### Resources
For more information please visit 
* [vagrant](https://www.vagrantup.com/intro/index.html)
* [jenv](https://github.com/gcuisinier/jenv)
* [pyenv](https://github.com/pyenv/pyenv)

