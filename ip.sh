#!/bin/bash

# Array mit Netzwerkadaptern
network_adapters=($(ip addr show | awk '/^[0-9]+:/ {print substr($2, 1, length($2)-1)}'))

# Header
printf "| %-18s | %-15s | %-17s | %-20s |\n" "IP-Adresse" "Netzwerkadapter" "MAC-Adresse" "Hostname"
printf "|%-20s|%-17s|%-19s|%-22s|\n" "--------------------" "-----------------" "-------------------" "---------------------"

# Schleife über alle Netzwerkadapter
for adapter in "${network_adapters[@]}"
do
    # IP-Adresse
    ip_address=$(ip addr show dev "$adapter" | awk '/inet / {print $2}')

    # Überprüfen, ob die IP-Adresse leer ist
    if [ -z "$ip_address" ]; then
        ip_address=""
    fi

    # MAC-Adresse
    mac_address=$(ifconfig "$adapter" | grep -Eo '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}')

    # Hostname
    hostname=$(hostname)

    # Ausgabe
    printf "| %-18s | %-15s | %-17s | %-20s |\n" "$ip_address" "$adapter" "$mac_address" "$hostname"
done

