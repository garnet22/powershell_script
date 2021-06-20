$Name = "killOBS" #where are the configs located
$script_path = 'C:\exit.ps1' # #ps1(kill obs in session) script path
$ps_path = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" #Powershell path

$STPrin = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Remote Desktop Users"  #the group to which all rdp users will be added whose will be writtend by OBS


#Add schedule close OBS when user disconnected (after logoff - OBS close automatically)

$StateChangeTrigger = Get-CimClass `
    -Namespace Root/Microsoft/Windows/TaskScheduler `
    -ClassName MSFT_TaskSessionStateChangeTrigger

$T1 = New-CimInstance `
    -CimClass $StateChangeTrigger `
    -Property @{StateChange = 4} `
    -ClientOnly

$Sta = New-ScheduledTaskAction -Execute $ps_path -Argument $script_path
$STSet = New-ScheduledTaskSettingsSet
Register-ScheduledTask $Name -Trigger $T1 -Action $Sta -Principal $STPrin -Settings $STSet 

