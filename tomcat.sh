#tomcat run on java so install java
yum install java-11-amazon-corretto -y

#download tomcat from internet all the apache software are available in http://dlcdn.apache.org-->tomcat..->bin
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.57/bin/apache-tomcat-10.1.57.tar.gz

# Extract Tomcat
tar -xvzf apache-tomcat-10.1.57.tar.gz

# Configure Tomcat users
sed -i '/<\/tomcat-users>/i\
<role rolename="manager-gui"/>\
<role rolename="manager-script"/>\
<user username="tomcat" password="root123456" roles="manager-gui,manager-script"/>' \
apache-tomcat-10.1.57/conf/tomcat-users.xml

sed -i '21d' apache-tomcat-10.1.57/webapps/manager/META-INF/context.xml
sed -i '21d' apache-tomcat-10.1.57/webapps/manager/META-INF/context.xml

#start tomcat
sh apache-tomcat-10.1.57/bin/startup.sh

