$Path = "D:\SteamLibrary\steamapps\common\DCSWorld"
# ----------------------------------------------------------------------------------------------------------------

$CheckFile = "$Path\bin\DCS.exe"

if (![System.IO.File]::Exists($CheckFile))
{
	echo "`nPath not valid!`n$Path`n"
    Read-Host -Prompt "Press any key to continue"
    Exit
}

# ----------------------------------------------------------------------------------------------------------------




$FileIn = "$Path\Scripts\Speech\speech.lua"

$Search = "return nations.USA"
$Replace = "return aircraftNativeCountry[message.sender:getUnit():getTypeName()] or nations.USA"

$CheckText = "-- modified by Hotshot"



$FileContent = Get-Content -Raw $FileIn

$RegFind = [System.Text.RegularExpressions.Regex]::new($CheckText, [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($RegFind.Match($FileContent).Success)
{
    Write-Host "`nFile has already been modified.`n"
    Write-Host "`nRestoring Original after pressing ENTER (or close the script to keep the modified)!`n"
    Read-Host -Prompt "Press any key to continue"
    Move-Item -Path "$FileIn.bak" -Destination "$FileIn" -Force
}
<#elseif (Get-ChildItem -Path "$FileIn.bak")
{
    Write-Host "`nWarning, backup file already exists. Skipping...`n"
}#>
else
{
    Copy-Item -Path "$FileIn" -Destination "$FileIn.bak" -Force

    $RegFind = [System.Text.RegularExpressions.Regex]::new($Search, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    $FileContent = $RegFind.Replace($FileContent, $Replace)
    $FileContent = $CheckText + "`n" + $FileContent

    Set-Content -Path $FileIn -Value $FileContent

    Write-Host "`nSuccess: file changed!`n($FileIn)`n"

    #timeout /t 5

    echo "...opening files for comparison...`n"
    Read-Host -Prompt "Press any key to continue"
    explorer "$FileIn"
    explorer "$FileIn.bak"
}
