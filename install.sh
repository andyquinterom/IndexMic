#!/bin/sh

read -p "¿Su distribción utiliza RPM (1) o DEB (2)?" pm
case $pm in
    [1]* )
        wget -O shinyproxy.rpm https://www.shinyproxy.io/downloads/shinyproxy_2.5.0_x86_64.rpm;
        sudo dpkg -i shinyproxy.deb;;
    [2]* )
        wget -O shinyproxy.deb https://www.shinyproxy.io/downloads/shinyproxy_2.5.0_amd64.deb;
        sudo rpm -i shinyproxy.rpm;;
    * ) echo "Por favor ingrese 1 o 2."; exit 0;;
esac

sudo cp shinyproxy/application.yml /etc/shinyproxy/application.yml
sudo cp -R shinyproxy/templates /etc/shinyproxy/

sudo systemctl enable shinyproxy

echo "Utilice 'systemctl start shinyproxy' para correr IndexMic."
