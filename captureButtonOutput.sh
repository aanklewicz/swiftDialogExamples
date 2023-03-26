#!/bin/zsh

#Written by Trevor Sysock (@BigMacAdmin on Slack)

#Example script: How to capture button output and make actions based on the results

/usr/local/bin/dialog \
--title "Example Script" \
--message "This is an example of how to capture the exit code of a script, and then take action based on what button the user clicked." \
--icon "SF=bolt.circle color1=pink color2=blue" \
--button1text "Primary button exits 0" \
--button2text "Cancel button exits 2" \
--infobuttontext "Info button exits 3" \
--quitkey k \
#The --quitkey flag maps a custom key to exit the Dialog window. 
#Without this, CMD+Q exits with code 0, which can be confused with a button 1 click.
#With a quit key, CMD+k in this example, the exit code will be 10
#This may be fixed in future versions of swiftDialog https://github.com/bartreardon/swiftDialog/issues/180

#Very important that this part comes immediately after the dialog command
dialogResults=$?

echo "Dialog exited with the following code: $dialogResults"

if [ "$dialogResults" = 0 ]; then
    echo "Do the things you want when button1 is clicked"
elif [ "$dialogResults" = 2 ]; then
    echo "Do the things you want when button2 is clicked"
elif [ "$dialogResults" = 3 ]; then
    echo "Do the things you want when button3 (info button) is clicked"
elif [ "$dialogResults" = 10 ]; then
    echo "Do the things you want when the user used the quitkey combination"
else
    echo "Dialog exited with an unexpected code."
    echo "Could be an error in the dialog command"
    echo "Could be the process killed somehow."
    echo "Exit with an error code."
    exit "$dialogResults"
fi
