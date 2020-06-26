#!/bin/sh
set -e

echo "Building MiniGL library ..."
gcc -c libraries/minigl/minigl.c -o libraries/minigl/minigl.o -I/opt/vc/include

echo "Creating /kappa/services ..."
sudo mkdir -p /kappa/services

echo "Building unplug_splash service ..."
gcc -c services/unplug_splash/main.c -o services/unplug_splash/main.o -Ilibraries/minigl
sudo gcc libraries/minigl/minigl.o services/unplug_splash/main.o -o /bin/unplug_splash -L/opt/vc/lib -lbrcmEGL -lbrcmGLESv2 -lbcm_host -lm

echo "Copying unplug_splash assets ..."
sudo mkdir -p /kappa/services/unplug_splash
sudo cp services/unplug_splash/assets/* /kappa/services/unplug_splash

echo "Building delta_govenor service ..."
gcc -c services/delta_govenor/main.c -o services/delta_govenor/main.o -Ilibraries/minigl
sudo gcc libraries/minigl/minigl.o services/delta_govenor/main.o -o /bin/delta_govenor -L/opt/vc/lib -lbrcmEGL -lbrcmGLESv2 -lbcm_host -lm

echo "Copying delta_govenor assets ..."
sudo mkdir -p /kappa/services/delta_govenor
sudo cp services/delta_govenor/assets/* /kappa/services/delta_govenor

exit 0