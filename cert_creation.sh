#!/bin/bash

# By Krh3rtz 2018

# This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
 
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Generación de certificados SSL con duración de 1 año.

ruta='/etc/apache2/ssl';

# Verificando instalación de OpenSSL
aptitude install openssl;

echo -e "[*] Ingresa el FQDN para generar los certificados: \n";
read cert ;

echo -e "[*] Ingresa una ruta para almacenar las llaves (ruta por defecto $ruta): \n";
read ruta;

mkdir -p $ruta;
cd $ruta;

echo -e "[*] Generando los certificados. Ingrese la información necesaria.\n";
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $cert.key;
chmod 600 $cert.key ;
openssl req -new -key $cert.key -out $cert.csr;
openssl x509 -req -days 365 -in $cert.csr -signkey $cert.key -out $cert.crt;

echo -e "[+] Los certificados $cert han sido creados dentro del directorio $ruta\n";
ls -al $ruta
exit 0;
