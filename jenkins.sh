# STEP-1: Installing Git and Maven
yum install git maven -y

# STEP-2: Repo Information (jenkins.io --> download -- > redhat)
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# STEP-3: Download Java 17 and Jenkins
sudo yum install java-17-amazon-corretto -y
yum install jenkins -y

# STEP-4: Increase /tmp size to 2G (permanent change)
sudo mount -o remount,size=2G /tmp
if ! grep -q "tmpfs /tmp tmpfs" /etc/fstab; then
    echo "tmpfs /tmp tmpfs rw,nosuid,nodev,size=2G 0 0" | sudo tee -a /etc/fstab
else
    sudo sed -i 's|tmpfs /tmp tmpfs .*|tmpfs /tmp tmpfs rw,nosuid,nodev,size=2G 0 0|' /etc/fstab
fi

# STEP-5: Start and check the JENKINS Status
systemctl start jenkins.service
systemctl status jenkins.service

# STEP-6: Auto-Start Jenkins
chkconfig jenkins on
