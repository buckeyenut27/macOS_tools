###Box Tools Install and Proxy Settings

###Install Box Tools

#!/bin/sh
curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15" -L https://e3.boxcdn.net/box-installers/boxedit/mac/currentrelease/BoxToolsInstaller.dmg > /Users/Shared/BoxToolsInstaller.dmg
hdiutil attach /Users/Shared/BoxToolsInstaller.dmg
open -g "/Volumes/Box Tools Installer/Install Box Tools.app"
hdiutil detach /Volumes/Box Tools Installer/
rm -rf /Users/Shared/BoxToolsInstaller.dmg
exit 0

###Proxy Settings
$BypassURL=127.0.0.1
networksetup -setproxybypassdomains "Display Ethernet" "$BypassURL"
networksetup -setproxybypassdomains "Thunderbolt Ethernet" "$BypassURL"
networksetup -setproxybypassdomains "Wi-Fi" "$BypassURL"