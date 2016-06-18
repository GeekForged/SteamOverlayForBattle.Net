# SteamOverlayForBattle.Net
A work-around to enable the Steam overlay with automatic login for Blizzard games.

## Prefixes
* Diablo 3: `battlenet://D3`
* Hearthstone: `battlenet://WTCG`
* Heroes of the Storm: `battlenet://Hero`
* Overwatch: `battlenet://Pro`
* Starcraft 2: `battlenet://S2`
* World of Warcraft: `battlenet://WoW`


## Usage
1. Place the `steam_overlay_battlenet_launcher.ps1` in your game directory.
For example, Overwatch might be something like: `C:\Program Files (x86)\Overwatch\`
1. Edit the `$battlenetLaunchArgument` variable in the `steam_overlay_battlenet_launcher.ps1` file to the prefix for your game, as of right now, it is preset to `battlenet://Pro` for Overwatch.
1. "Add a game" in steam, select "Add a Non-Steam game". Select your game from the applications list.
1. Right click the game you just added to the list, and select properties.
1. Change the  target to the following: `"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -WindowStyle Maximized -File "{Path from step 1}\steam_overlay_battlenet_launcher.ps1"`. Where `{Path from step 1}` is the path from step one.

## What does this do for me?
#### TLDR;
It makes it so that the Steam Overlay, or Steam Big Picture plays nicely with your Blizzard game.

#### Long reason:
In order to set the controller configuration when using the Steam Link, you need to be able to access the Steam Overlay while playing the game. This can be extremely inconvenient if you have to keep exiting the game to test configurations. Why else... Just because, and honestly we (I) don't care to have Battle.Net running on my computer all the time and I am to lazy to log in to the game each time.

## How does it work?
Essentially, we use Windows Power Shell to check the Registry to find out where Battle.Net is located. Once we find it, we check if it is running. If it is not running we then start it, and wait for it to initialize. Once "initialized" we issue the command to start the game, based on the game prefix. We then proceed to kill the Battle.Net process so that it no longer receives a Steam Overlay window(Yes, Steam overlays every window that spawns from it's process).
