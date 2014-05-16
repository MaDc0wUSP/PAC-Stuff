#  Remove all the Java related packages
sudo apt-get update
apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
sudo apt-get -y autoremove

# Purge config files
dpkg -l | grep ^rc | awk '{print($2)}' | xargs sudo apt-get -y purge

# Remove Java config and cache directory
sudo bash -c 'ls -d /home/*/.java' | xargs sudo rm -rf

# Remove manually installed JVMs
sudo rm -rf /usr/lib/jvm/*

# Remove Java entries, if there are still any, from the alternatives
for g in ControlPanel java java_vm javaws jcontrol jexec keytool mozilla-javaplugin.so orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 appletviewer apt extcheck HtmlConverter idlj jar jarsigner javac javadoc javah javap jconsole jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd native2ascii rmic schemagen serialver wsgen wsimport xjc xulrunner-1.9-javaplugin.so; do sudo update-alternatives --remove-all $g; done

# Search for possible remaining Java directories
sudo updatedb
sudo locate -b '\pack200'

# If above lists any output paths, check manually and delete them with rm -rf by hand!



