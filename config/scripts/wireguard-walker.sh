#!/usr/bin/env bash
# ==============================================
# WireGuard Menu Script (Bash + Walker + Hidden Password + NixOS Safe)
# ==============================================

declare -A servers

# --- Configure your WireGuard servers here
servers[/home/mees/.config/wireguard/mg0.conf]="mg0"
#servers[two]="Server Two"

# --- Helper: resolve walker command safely (NixOS friendly)
# --- Ask for sudo password via Walker (hidden input)
ask_password() {
    local password
    password=$(echo "" | eval "walker --dmenu --inputonly --nohints \
        -p 'Enter password' -t secret\
        --height 80 --width 350")
    echo "$password"
}

# --- Disconnect from all servers
disconnect_all() {
    local password="$1"
    for disconnect_server in "${!servers[@]}"; do
        echo "$password" | sudo -S wg-quick down "$disconnect_server" &>/dev/null
    done
}

# --- Main logic
        declare -a menu
        title="WireGuard Tunnel"

        # Detect current connection
        for server in "${!servers[@]}"; do
            if ip address show dev "$server" &>/dev/null; then
                title="Connected to ${servers[$server]}"
            else
                menu+=("${servers[$server]}")
            fi
        done

        # Build menu
        menu_list=""
        for item in "${menu[@]}"; do
            menu_list+="$item\n"
        done
        menu_list+="Disconnect\n"
        # Display main selection menu
        selection=$(echo -e "$menu_list" | eval "walker --dmenu --nohints -p \"$title\" --height 10 --width 40")

        if [ "$selection" == "Disconnect" ]; then
            password=$(ask_password)
            disconnect_all "$password"
            notify-send "WireGuard Tunnel" "Disconnected from all servers"
            unset password
        elif [ -n "$selection" ]; then
            password=$(ask_password)
            for server in "${!servers[@]}"; do
                if [[ "${servers[$server]}" == "$selection" ]]; then
                    disconnect_all "$password"
                    echo "$password" | sudo -S wg-quick up "$server"
                    notify-send "WireGuard Tunnel" "Connected to $selection"
                    unset password
                    break
                fi
            done
        fi
  unset password
