# 🌅 Hyprsunset Control Script

A lightweight Bash utility to manage screen color temperature in **Hyprland** using the `hyprsunset` command. It is optimized for **Waybar**, providing real-time JSON updates and support for mouse scroll/click interactions.

## ✨ Features

* **Granular Control:** Increase or decrease temperature in steps of 25K.
* **Quick Reset:** Return to a neutral 6000K with a single click.
* **Waybar Ready:** Outputs JSON formatted for custom Waybar modules.
* **Instant Feedback:** Supports POSIX signals (`SIGRTMIN`) for immediate UI updates.

## 📋 Prerequisites

* **Hyprland** (running environment)
* **hyprsunset** (installed and active)
* **Waybar** (for the status bar widget)

## 🚀 Installation

1. Create the script file:
```bash
mkdir -p ~/.config/hypr/scripts
wget -O ~/.config/hypr/scripts/sunset.sh https://raw.githubusercontent.com/Mat1RX/waybar-hyprsunset/refs/heads/main/sunset.sh

```


2. Paste your script code into the file and save it.
3. Make it executable:
```bash
chmod +x ~/.config/hypr/scripts/sunset.sh

```



## ⚙️ Waybar Configuration

To use this script as a widget, add the following to your `config.jsonc`.

**Note:** We use `signal: 10` to ensure the temperature text updates the millisecond you scroll or click.

```jsonc
"custom/sunset": {
    "exec": "~/.config/hypr/scripts/sunset.sh",
    "return-type": "json",
    "interval": "once", 
    "signal": 10,
    "on-scroll-up": "~/.config/hypr/scripts/sunset.sh up && pkill -RTMIN+10 waybar",
    "on-scroll-down": "~/.config/hypr/scripts/sunset.sh down && pkill -RTMIN+10 waybar",
    "on-click": "~/.config/hypr/scripts/sunset.sh reset && pkill -RTMIN+10 waybar",
    "tooltip": false
}

```

### Styling (`style.css`)

The script passes the CSS class `"sunset"`. You can use it to color your icon:

```css
#custom-sunset {
    color: #ffb86c; /* Warm Orange/Yellow */
    margin: 0 5px;
}

```

## ⌨️ Hyprland Keybindings

Add these to your `hyprland.conf` to control the temperature with your keyboard. The `pkill` command ensures your Waybar widget stays in sync with your keypresses:

```ini
# Adjust temperature with Shift + BrightnessDown/Up
bindel = SHIFT, XF86MonBrightnessDown, exec, hyprctl hyprsunset temperature -500 && pkill -RTMIN+10 waybar
bindel = SHIFT, XF86MonBrightnessUp, exec, hyprctl hyprsunset temperature +500 && pkill -RTMIN+10 waybar

# Reset to 6000K
bind = SUPER, Home, exec, ~/.config/hypr/scripts/sunset.sh reset && pkill -RTMIN+10 waybar

```

## 🛠 Manual Usage (CLI)

You can call the script directly from your terminal:

* `sunset.sh up`: Increase temperature (+25K).
* `sunset.sh down`: Decrease temperature (-25K).
* `sunset.sh reset`: Set temperature to 6000K.
* `sunset.sh`: Just outputs the current JSON status.

---
