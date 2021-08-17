echo "updating existing packages"
sudo yum update -y

echo "install a couple tools that may be helpful for later"
sudo yum install wget -y
sudo yum install unzip -y
sudo yum install lsof -y

echo "installing java 8"
sudo yum install -y java-11-openjdk-devel
sudo update-alternatives --config java
sudo update-alternatives --config javac
echo "java 8 installed and configured"

echo "installing node"
curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum -y install nodejs
echo "node installed"

echo "install Angular"
sudo npm install -g @angular/cli
sudo npm install -g http-server
echo "Angular namespace now functional"

echo "installing maven"
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install --nobest -y apache-maven
echo "maven installed"

echo "installing gradle"
sudo wget https://services.gradle.org/distributions/gradle-6.8.3-bin.zip -P /tmp
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle /tmp/gradle-*.zip
echo "time to create the gradle environment variable, BUT, you may have to input this manually, the script isn't triggering it"
export PATH=$PATH:/opt/gradle/gradle-6.8.3/bin
echo "gradle installed"

echo "installing jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y   
echo "jenkins installed"
#sudo service jenkins start
#echo "jenkins started"

echo "installing docker"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
echo "install the repository"
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
echo "install the engine"
sudo yum install docker-ce --nobest
echo "starting docker"
sudo systemctl start docker
echo "check to see if docker is running"
#sudo docker run hello-world
