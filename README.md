# rocketchat_auto_update
tight autoupgrade Rocket Chat Script

Added Option Check and Update
## Setup the script
Pre Script use you need to change the Rocketchat URL to your URL on Line 6.

The script needs the be run as root!

## Call the script with

before you use the script you need to make it executable

`chmod +x rocketchat.sh`

`./rocketupdate.sh check`
or
`./rocketupdate.sh update`


## FAQ

-- Rocketchat is not starting after upgrade:
check the status of rocketchat there might be an error like "Browserslist: caniuse-lite is outdated. Please run next command `npm update`"

Just do the `npm update` and then restart rocketchat via `systemctl restart rocketchat`
