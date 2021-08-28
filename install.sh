#!/bin/sh

read -p "¿Su distribción utiliza RPM (1) o DEB (2)?" pm
case $pm in
    [1]* )
        wget -O shinyproxy.rpm https://www.shinyproxy.io/downloads/shinyproxy_2.5.0_x86_64.rpm;
        sudo rpm -i shinyproxy.rpm;;
    [2]* )
        wget -O shinyproxy.deb https://www.shinyproxy.io/downloads/shinyproxy_2.5.0_amd64.deb;
        sudo dpkg -i shinyproxy.deb;;
    * ) echo "Por favor ingrese 1 o 2."; exit 0;;
esac

sudo cp shinyproxy/application.yml /etc/shinyproxy/application.yml
sudo cp -R shinyproxy/templates /etc/shinyproxy/

read -p "¿Desea activar el servicio con systemd? sí (s)/ no (n)" yn
case $yn in
    [Ss]* )
        sudo systemctl enable shinyproxy;;
    [Nn]* )
        echo "Utilice 'systemctl enable shinyproxy' para correr IndexMic.";;
    * ) echo "Por favor ingrese sí (s) o no (n)."; exit 0;;
esac

read -p "¿Desea iniciar el servicio con systemd? sí (s)/ no (n)" yn
case $yn in
    [Ss]* )
        sudo systemctl start shinyproxy;;
    [Nn]* )
        echo "Utilice 'systemctl start shinyproxy' para correr IndexMic.";;
    * ) echo "Por favor ingrese sí (s) o no (n)."; exit 0;;
esac

