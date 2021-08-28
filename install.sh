#!/bin/sh

read -p "¿Tiene instalado Docker y OpenJDK? (s/n)?" choice
case "$choice" in 
  s|S ) echo "Continuando...";;
  n|N )
      echo "Por favor instalar Docker y OpenJDK antes de continuar.";
      exit 0;;
  * ) echo "Ingresar sí (s) o no (n).";;
esac

echo "Descargando archivos necesarios de internet..."
wget -O indexmic/shinyproxy.jar https://www.shinyproxy.io/downloads/shinyproxy-2.5.0.jar

echo "Verificando sumas de hash sha256..."

HASHSUM="9edf2b6806cb9667504515dedfeb6ae089f1ff0980b993d28a1e0d447878f928"
HASHSUM_VERIFY=$(sha256sum indexmic/shinyproxy.jar | grep -o "^[a-z0-9]*")

if [ "$HASHSUM" = "$HASHSUM_VERIFY" ]; then
    echo "¡Sumas de hash verificadas!"
else
    echo "Sumas de hash no son iguales. Validar descarga. Abortando..."
    exit 0
fi

echo "Copiando archivos..."
if test -f "/etc/indexmic/application.yml"; then
  read -p "Ya existe una configuración para IndexMic, ¿desea reemplazarla? (s/n)" overwrite
  case "$overwrite" in 
    s|S )
      echo "Se reemplazará la configuración.";
      sudo cp -Ri ./indexmic /etc/;;
    n|N )
      echo "No se reemplazará, continuando con instalación.";
      sudo cp -R ./indexmic/templates /etc/indexmic/;
      sudo cp ./indexmic/shinyproxy.jar /etc/indexmic/shinyproxy.jar;;
    * ) echo "Ingresar sí (s) o no (n).";;
  esac
fi

echo "Creando usuario indexmic..."
sudo useradd indexmic
sudo usermod -aG docker indexmic 
sudo chgrp indexmic /etc/indexmic


echo "Creando servicio en systemd..."
sudo cp indexmic.service /etc/systemd/system/indexmic.service
sudo systemctl daemon-reload
sudo systemctl restart indexmic.service
