# Black-Hole-Macro
The purpose of this programm is automate the button presses of the Starpact Wizard build in Diablo 3.
# Install
Start the autohotkey script "WizComboBlackHole.ahk" first.

![ahk](https://i.imgur.com/SRirnBb.png)

Make sure its running as administrator.

![run ahk as admin](https://i.imgur.com/lRTs7bZ.png)


Start the ThToAhk Program.

![ThToAhk](https://i.imgur.com/IDUNVQa.png)

To do this you need to open the ThToAhk.sln file with [Microsoft Visual Studio](https://visualstudio.microsoft.com/)

![ThToAhk sln](https://i.imgur.com/AD6Sv01.png)

and press F5

![ThToAhk F5](https://i.imgur.com/1Ha8Aq8.png)

Make sure its running as administrator by starting visual studio as administrator.

![ThToAhk admin](https://i.imgur.com/Lo9G5Ad.png)


Start Turbohud with the ThToAhkAdapter.cs file.

Make a new folder named "Zy" in *Your Turbohud Path*\plugins\Zy and place the "ThToAhkAdapter.cs" File into the folder, then start Turbo hud.

If everything is working it should look like this:

![ahk](https://i.imgur.com/qbSRqHe.png)

![ThToAhk](https://i.imgur.com/xOV8DCy.png)


# Usage
Set your skills to the following:

![skills](https://i.imgur.com/j9ygT5c.png)

Hold down 5 to run the macro.

Press 6 to adjust the coe timer (once per rift floor and on death).

Press 7 for small adjustments to the coe timer (in case of lag).

Press 8 to toggle the macro on or off.

# Troubleshooting
The way the macro works is that Turbo Hud sends the COE timer to "ThToAhk" via a TCP Client.

The data then gets send to the Autohotkey file via Memory mapping.

![transfer](https://i.imgur.com/dbC48fN.png)

To see that each program is doing each party we are gonna look at them through [Process Explorer](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer).

1. Turbohud connection to ThToAhk

Start Process Explorer and look for TurboHUD.exe

![Process Explorer](https://i.imgur.com/rxisBrq.png)

Click on Properties and TCP/IP, it should look like this:

![Process Explorer thud](https://i.imgur.com/A2QHQ31.png)

Look for dotnet.exe, click on proerties and TCP/IP.

It should look like this:

![Process Explorer ThToAhk properties](https://i.imgur.com/eAgnQg2.png)


If there is no TCP connection:
Make sure Turbo hud is running as administrator.

Make sure ThToAhk is running as administrator (Process name is dotnet.exe), by running Visual Studio as administrator.

Make sure your firewall isnt blocking the communication (its on port 2206).

2. ThToAhk connection to Autohotkey

Look for dotnet.exe, scroll down in the lower window and search for sections, it should look like this:

![ThToAhk Section](https://i.imgur.com/A2QHQ31.png)

Look for AutoHotkey.exe, scroll down in the lower window and search for sections, it should look like this:

![Ahk Section](https://i.imgur.com/sngDEKW.png)


If there is no section named \BaseNamedObjects\ThToAhk:

Make sure ThToAhk and Autohotkey are running as administrator.
