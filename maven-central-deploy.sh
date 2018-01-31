#!/bin/bash
# Deploy maven artefact in current directory into Maven central repository 
# using maven-release-plugin goals

read -p "Really deploy to maven cetral repository  (yes/no)? "

if ( [ "$REPLY" == "yes" ] ) then
  read -p "Enter SSH key-file name: " sshkeyfile
  ssh-add ~/.ssh/$sshkeyfile
  ssh-add -l
  read -p "Enter GPG keyname: " gpgkeynm
  read -p "Enter key alias sign JAR/APK: " jkeyalias
  read -p "Enter pass-phrase to sign JAR/APK: " jpassw
  mvn -Darguments="-Prelease -Dandroid.release=true -Dgpgkeyname=$gpgkeynm -Dsignalias=$jkeyalias -Dsignpass='$jpassw'" release:clean release:prepare release:perform -B -e | tee maven-central-deploy.log
  ssh-add -D
else
  echo 'Exit without deploy'
fi

