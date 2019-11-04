#!/bin/bash

VAGRANT_DIR=/vagrant
HOME_DIR=~/
HOME_BIN_DIR=$HOME_DIR/bin

download()
{
    local url=$2
    local file=$1
    echo "Downloading $file"
    wget --progress=dot $url >/dev/null 2>&1
}

installPackage()
{
    local packages=$*
    echo "Installing $packages"
    sudo apt-get install -y $packages >/dev/null 2>&1
}

updatePackages()
{
    sudo add-apt-repository ppa:openjdk-r/ppa -y >/dev/null 2>&1
    sudo apt-get update >/dev/null 2>&1
}

installPackages()
{
    updatePackages
    installPackage vim
    installPackage git
    installPackage fish
    installPackage zip
    installPackage unzip
    # dependencies for pyenv
    installPackage make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev ansible
}

createAndMoveToHomeBinDir()
{
    echo "Creating and moving to bin directory"
    mkdir $HOME_BIN_DIR
    cd $HOME_BIN_DIR
}

setDefaultJava()
{
    default_java_version=$1
    echo "Setting jdk $default_java_version globally"
    jenv global $default_java_version
}

installOpenjdk()
{
    version=$1
    echo "Installing openjdk-$version-jdk"
    sudo apt-get install -y openjdk-$version-jdk >/dev/null 2>&1;
    jenv add /usr/lib/jvm/java-$version-openjdk-amd64 >/dev/null 2>&1
}

installScala()
{
    echo "Installing scala"
    download "scala-2.11.6.tgz" "http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz"
    tar -xzvf scala-2.11.6.tgz >/dev/null 2>&1
    rm -rf scala-2.11.6.tgz
}

installGroovy()
{
    echo "Installing groovy"
    sudo apt-get install -y groovy >/dev/null 2>&1
}

installJenv()
{
    echo 'Installing jenv'
    git clone https://github.com/gcuisinier/jenv.git ~/.jenv >/dev/null 2>&1
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
    jenv enable-plugin export >/dev/null 2>&1
}

installPyenv()
{
    echo 'Installing pyenv'
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv >/dev/null 2>&1
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
}

installTfenv()
{
    echo 'Installing tfenv'
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv >/dev/null 2>&1
    export PATH="$HOME/.tfenv/bin:$PATH"
}


installEnvManagers()
{
    installJenv
    installPyenv
    installTfenv
}

createBashrcAndBashProfile()
{
    echo "Creating .bashrc and .bash_profile"
    cat $VAGRANT_DIR/bashrc.template > $HOME_DIR/.bashrc
    source $HOME_DIR/.bashrc
    cat $VAGRANT_DIR/bash_profile.template > $HOME_DIR/.bash_profile
    source $HOME_DIR/.bash_profile
}

installPython()
{
    python_version=$1
    echo "Installing python $python_version"
    pyenv install $python_version >/dev/null 2>&1
}

setDefaultPython()
{
    default_python_version=$1
    echo "Setting python $default_python_version globally"
    pyenv global $default_python_version
}

installPipPackage()
{
	pip_package=$1
	echo "Installing Pip3 package(s): $pip_package"
	pip3 install -q $pip_package
}

installPipPackages()
{
	installPipPackage pandas
	installPipPackage seaborn
	installPipPackage boto3
	installPipPcakage pyspark
	installPipPackage scikit-learn
	installPipPackage tensorflow
	installPipPackage keras
	installPipPackage jupyterlab
	installPipPackage dbt
}

installTerraform()
{
    terraform_version=$1
    echo "Installing terraform $terraform_version"
    tfenv install $terraform_version  >/dev/null 2>&1
}

installPacker()
{
    packer_version=$1
    echo "Installing packer $packer_version"
    download "packer_${packer_version}_linux_amd64.zip" "https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip"
    unzip packer_${packer_version}_linux_amd64.zip >/dev/null 2>&1
    rm -rf packer_${packer_version}_linux_amd64.zip
}


installMaven()
{
    echo "Installing maven"
    sudo apt-get install -y maven >/dev/null 2>&1
    jenv enable-plugin maven >/dev/null 2>&1
}

installSBT()
{
    echo "Installing sbt"
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list >/dev/null 2>&1
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823>/dev/null 2>&1
    sudo apt-get update >/dev/null 2>&1
    sudo apt-get install sbt >/dev/null 2>&1
    jenv enable-plugin sbt >/dev/null 2>&1
}

installGradle()
{
    echo "Installing gradle"
    download "gradle-5.0-bin.zip" "https://services.gradle.org/distributions/gradle-5.0-bin.zip"
    unzip gradle-5.0-bin.zip >/dev/null 2>&1
    rm gradle-5.0-bin.zip
}

installDocker()
{
    echo "Installing docker"
    curl https://download.docker.com/linux/ubuntu/gpg 2>&1 | sudo apt-key add - >/dev/null 2>&1
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update >/dev/null 2>&1
    sudo apt-get install -y docker-ce >/dev/null 2>&1
    sudo usermod -aG docker vagrant
}

installMongo()
{
    echo "Installing mongodb"
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 >/dev/null 2>&1
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list >/dev/null 2>&1
    sudo apt-get update >/dev/null 2>&1
    sudo apt-get install -y mongodb-org >/dev/null 2>&1
    echo "mongodb-org hold" | sudo dpkg --set-selections
    echo "mongodb-org-server hold" | sudo dpkg --set-selections
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections
}

installAWSCLI()
{
    echo "Installing awscli"
    sudo apt-get install -y python-pip python3-pip >/dev/null 2>&1
    sudo su -c 'pip install awscli --upgrade --user' vagrant >/dev/null 2>&1
}

provision() {
    createAndMoveToHomeBinDir
    installPackages
    installEnvManagers
    installOpenjdk "8"
    #installOpenjdk "9"
    #installOpenjdk "10"
    installOpenjdk "11"
    setDefaultJava "11"
    installMaven
    createBashrcAndBashProfile
    #installPython "2.7.7"
    #installDocker
    installAWSCLI
    installTerraform "0.12.13"
    #installPacker "1.0.0"
    installPython "3.7.5"
    setDefaultPython "3.7.5"
    installPipPackages
    #installMongo
    installGroovy
    installGradle
    installScala
    installSBT
}

if [ ! -f "/var/vagrant_provision" ]; then
    sudo touch /var/vagrant_provision
    provision
else
    echo "Machine already provisioned. Run 'vagrant destroy' and 'vagrant up' to re-create."
fi
