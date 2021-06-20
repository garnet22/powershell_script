$Name = "RunOBS" #Name of the task

$destination_path = "C:\$Env:Username\AppData\Roaming\obs-studio" #destination of obs user config 
$files_config_path= "C:"   #path where are the configs located
$ps_path = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" #Powershell path

$script_path = "C:\run.ps1"   #bat script path

$STPrin = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Remote Desktop Users"   #the group to which all rdp users will be added whose will be writtend by OBS


#Add schedule with 2 triggers (connect to session and logon)

$StateChangeTrigger = Get-CimClass `
    -Namespace Root/Microsoft/Windows/TaskScheduler `
    -ClassName MSFT_TaskSessionStateChangeTrigger

$T1 = New-ScheduledTaskTrigger -AtLogOn
$T2 = New-CimInstance `
    -CimClass $StateChangeTrigger `
    -Property @{StateChange = 3} `
    -ClientOnly

$Sta = New-ScheduledTaskAction -Execute $ps_path -Argument $script_path
$STSet = New-ScheduledTaskSettingsSet
Register-ScheduledTask $Name -Trigger $T1,$T2 -Action $Sta -Principal $STPrin -Settings $STSet 


# Move configs to folder

if (!(Test-Path -path $destination_path)) {New-Item $destination_path -Type Directory}
Copy-Item "$files_config_path\global.ini" -Destination $Destination_path
Copy-Item "$files_config_path\basic" -Destination $destination_path -recurse -Force
