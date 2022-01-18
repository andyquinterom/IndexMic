#!/bin/sh

read -p "¿Tiene instalado Docker y OpenJDK? (s/n)?" choice
case "$choice" in 
  s|S ) echo "Continuando...";;
  n|N )
      echo "Por favor instalar Docker y OpenJDK antes de continuar.";
      exit 0;;
  * ) echo "Ingresar sí (s) o no (n).";;
esac

cd /etc/indexmic/

echo "Descargando archivos necesarios de internet..."
wget -O shinyproxy.jar https://www.shinyproxy.io/downloads/shinyproxy-2.6.0.jar

echo "Verificando sumas de hash sha256..."

HASHSUM="33e79a030294dc4dcb61c3030a53d239a964d6aa1122143d854a329c5c7a233b"
HASHSUM_VERIFY=$(sha256sum shinyproxy.jar | grep -o "^[a-z0-9]*")

if [ "$HASHSUM" = "$HASHSUM_VERIFY" ]; then
    echo "¡Sumas de hash verificadas!"
else
    echo "Sumas de hash no son iguales. Validar descarga. Abortando..."
    exit 0
fi

echo "Creando usuario indexmic..."
sudo useradd indexmic
sudo usermod -aG docker indexmic 
sudo chgrp indexmic /etc/indexmic

echo "Creando servicio en systemd..."
sudo cp indexmic.service /etc/systemd/system/indexmic.service
sudo systemctl daemon-reload
sudo systemctl restart indexmic.service
