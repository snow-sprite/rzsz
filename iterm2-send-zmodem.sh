### 
# @Author: your name
 # @Date: 2019-12-11 01:03:06
 # @LastEditTime: 2019-12-11 01:03:21
 # @LastEditors: your name
 # @Description: In User Settings Edit
 # @FilePath: /rzsz/iterm2-send-zmodem.sh
 ###
#!/bin/bash
# Author: Matt Mastracci (matthew@mastracci.com)
# AppleScript from http://stackoverflow.com/questions/4309087/cancel-button-on-osascript-in-a-bash-script
# licensed under cc-wiki with attribution required 
# Remainder of script public domain

#COMMAND=$(which sz)

if [[ -f /opt/homebrew/bin/sz ]]; then
	COMMAND=/opt/homebrew/bin/sz
else
	COMMAND=/usr/local/bin/sz
fi

osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm
if [[ $NAME = "iTerm" ]]; then
    FILE=$(osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
else
    FILE=$(osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
fi
if [[ $FILE = "" ]]; then
    echo Cancelled.
    # Send ZModem cancel
    echo -e \\x18\\x18\\x18\\x18\\x18
    sleep 1
    echo
    echo \# Cancelled transfer
else
    $COMMAND "$FILE" --escape --binary --bufsize 4096
    sleep 1
    echo
    echo \# Received "$FILE"
fi
