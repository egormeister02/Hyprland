#!/bin/bash

# Проверяем, включен ли Bluetooth
bluetooth_power_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [ "$bluetooth_power_status" == "yes" ]; then
    # Если Bluetooth включен, выключаем его
    echo "Bluetooth is currently ON. Turning it OFF."
    bluetoothctl power off
else
    # Если Bluetooth выключен, включаем его
    echo "Bluetooth is currently OFF. Turning it ON."
    bluetoothctl power on
fi