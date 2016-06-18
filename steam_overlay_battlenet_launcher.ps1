### User adjustable arguements ###

#Battlenet Launch Argument
$battlenetLaunchArgument = "battlenet://Pro"

#battlenet launcher wait time
$waitTime = 10

### End User adjustable arguments
##################################

Write-Host "####################################
#  Steam Overlay for Battle.net    #
# Created by GeekForged - 06-07-16 #
#  https://twitter.com/geekforged  #
####################################"

#Get the path to the battle.net launcher from the registry
$urlCommand = (Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\battlenet\shell\open\command -Name '(default)' ).'(default)'
$battlenetPath = $urlCommand.Replace(" `"%1`"","")

#Get the process name from the path
$splitPath = $battlenetPath.split('\')
$processName = $splitPath[$splitPath.length -2].Replace(".exe`"","").Trim()

#Function to launch the game
function LaunchGame {
    Write-Host "Attempting to launch game"
    #Launch the game
    Start-Process $battlenetPath -ArgumentList $battlenetLaunchArgument
    #Wait then kill Battle.net
    Start-Sleep -Seconds $waitTime
    Write-Host "Closing Battle.net"
    Stop-Process -processname $processName

}

Write-Host "Checking Battle.net status"
#Check if the process is running
$process = Get-Process $processName -ErrorAction SilentlyContinue
if(!$process){
    #If the battle.net process is not running, start it
    Start-Process $battlenetPath
    #Wait for it to get up to speed
    Start-Sleep -Seconds $waitTime
    #Ensure that the process is running
    $process = Get-Process $processName -ErrorAction SilentlyContinue
    if(!$process){
        Write-Host "Could not start battle.net process with-in " + $waitTime + " seconds... aborting (You may try adjusting this for slower computers)"
        Exit-PSSession
    }
    LaunchGame

} else{
   LaunchGame
}
