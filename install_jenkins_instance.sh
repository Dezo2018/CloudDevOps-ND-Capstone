# Step 1 - Update existing packages 
sudo apt-get update

# Step 2 - Install Java
sudo apt install -y default-jdk

# Step 3 - Download Jenkins package. 
# You can go to http://pkg.jenkins.io/debian/ to see the available commands
# First, add a key to your system
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# # Step 4 - Add the following entry in your /etc/apt/sources.list:
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
 
# # Step 5 -Update your local package index
sudo apt-get update

# Step 6 - Install Jenkins
sudo apt-get install -y jenkins

# Step 7 - Start the Jenkins server
sudo systemctl start jenkins

# Step 8 - Enable the service to load during boot
sudo systemctl enable jenkins
sudo systemctl status jenkins

sudo apt install tidy
sudo apt-get install docker.io
sudo usermod -a -G docker ubuntu
sudo systemctl start docker
sudo usermod -a -G docker jenkins


##  aws --version
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip 
# sudo apt-get install unzip 

# unzip awscliv2.zip 
# sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
# aws configure

#curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
#sudo mv /tmp/eksctl /usr/local/bin
# eksctl version

#curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin
#echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile
#kubectl version --short --client


# eksctl create cluster --name capstone --version 1.16 --nodegroup-name standard-workers --node-type t2.medium --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto --region eu-central-1

# eksctl delete cluster --name=cluster


# kubectl get nodes

# get the arn  
# aws sts get-caller-identity --query Arn

# get identity code
# aws sts get-caller-identity --output text --query Account
#aws eks --region eu-central-1 update-kubeconfig --name capstone

# kubectl config use-context arn:aws:iam::643112058200:user/capstone
# kubectl config use-context arn:aws:eks:eu-central-1:643112058200:cluster/capstone
# kubectl get deployments
# kubectl get service/clouddevops-capstone


