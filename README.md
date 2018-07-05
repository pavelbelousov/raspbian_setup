# raspbian_setup
Simple script which writes the Raspbian OS with Wi-Fi and SSH settings to an SD card

Setup on MacOS
--------------
The script uses `pv` utility to show progress bar during copying operation. You can install it using `brew`:
```
brew install pv
```

After downloading the script should be given execution permissions:
```
chmod +x raspbian_setup.sh
```

Wi-Fi settings must be set up as environment variables: WIFI_HOME_SSID, WIFI_HOME_PASS, COUNTRY_CODE.
You can add them in the `.bash_profile` file:
```
nano ~/.bash_profile
```
Add your Wi-Fi settings to the end of the file, for example:
```
WIFI_HOME_SSID=MyAwesomeWiFi
export WIFI_HOME_SSID
WIFI_HOME_PASS=MyAwesomeWiFiPassword
export WIFI_HOME_PASS
COUNTRY_CODE=US
export COUNTRY_CODE
```

Usage on MacOS
-----
Use `diskutil list` command to determine the name of your SD card (not partition!).
For example, SD card is mounted as `disk2` and Raspbian file name is `raspbian.img`:
```
./raspbian_setup.sh disk2 raspbian.img
```
