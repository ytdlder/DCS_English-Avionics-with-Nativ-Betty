# English avionics with native betty

## HowTo
* after downloading the script, you need to change the first line to you DCS install path
* ingame, under gampelay options, you set "Avionics Language" from the default "Native" to "English"
  * usually you'd then also have the English betty voice
* to still hear the native betty (Russian, Chinese, ...), you start the script once
  * if you start it a 2nd time, it will revert back to default!
* <b>you may see an "external script" warning or some such, where you have to accept running this script!</b>
  * <i>as with every downloaded script, you can and should look through what it does</i>

## What it does
It doesn't replace the file, so even if the file has a different layout from some future update, it will still only change what needs changing (meaning this script should more or less always work!)

It will change this line in the "speech.lua" from:
* return nations.USA

to this line:
* return aircraftNativeCountry[message.sender:getUnit():getTypeName()] or nations.USA

That's it.
