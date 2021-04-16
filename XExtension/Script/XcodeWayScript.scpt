use scripting additions
use framework "Foundation"
property NSString : a reference to current application's NSString

-- Helper

on myRemoveLastPath(myPath)
set myString to NSString's stringWithString:myPath
set removedLastPathString to myString's stringByDeletingLastPathComponent
removedLastPathString as text
end myRemoveLastPath

on myFolderExists(myFolder) -- (String) as Boolean
tell application "System Events"
if exists folder myFolder then
return true
else
return false
end if
end tell
end myFolderExists

on myRemoveSubString(oldString, subString)
set myString to NSString's stringWithString:oldString
set newString to myString's stringByReplacingOccurrencesOfString:subString withString:""
newString as text
end myRemoveSubString

on myGetRemote(myText)
set myString to NSString's stringWithString:myText
set myParts to myString's componentsSeparatedByString:"\t"
set myFirstParts to item 1 of myParts
myFirstParts as text
end myGetRemote

-- Path

on myHomePath()
tell application "System Events"
"/Users/" & (name of current user)
end tell
end myHomePath

on myLibraryPath()
myHomePath() & "/Library"
end myLibraryPath

on myXcodePath()
myLibraryPath() & "/Developer/Xcode"
end myXcodePath

on myCoreSimulator()
myLibraryPath() & "/Developer/CoreSimulator"
end myCoreSimulator

on myUserDataPath()
myXcodePath() & "/UserData"
end myUserDataPath

on myProjectPath()
tell application "Xcode"
tell active workspace document
set myPath to path
end tell
end tell
myRemoveLastPath(myPath)
end myProjectPath

on myCurrentFilePath()
tell application "Xcode"
set activeDocument to document 1 whose name ends with (word -1 of (get name of window 1))
path of activeDocument
end tell
end myCurrentFilePath

-- Generic Open

on myOpenFolder(myPath)
tell application "Finder"
activate
open myPath as POSIX file
end tell
end myOpenFolder

on myOpeniTerm(myPath)
tell application "Terminal"
if not (exists window 1) then reopen
activate
set currentTab to do script ("cd " & quoted form of myPath)
end tell
end myOpeniTerm

-- Do

on myPodInstall()
set myPath to myProjectPath()
tell application "Terminal"
if not (exists window 1) then reopen
activate
do script ("cd " & quoted form of myPath) in window 1
do script ("pod install") in window 1
end tell
end myOpeniTerm

on myPodUpdate()
set myPath to myProjectPath()
tell application "Terminal"
if not (exists window 1) then reopen
activate
do script ("cd " & quoted form of myPath) in window 1
do script ("pod upadte") in window 1
end tell
end myOpeniTerm

-- Open

on myOpenThemesFolder()
set myPath to myUserDataPath() & "/FontAndColorThemes/"
myOpenFolder(myPath)
end myOpenThemesFolder

on myOpenCodeSnippetsFolder()
set myPath to myUserDataPath() & "/CodeSnippets/"
myOpenFolder(myPath)
end myOpenCodeSnippetsFolder

on myOpenDeviceSupportFolder()
set myPath to "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport"
myOpenFolder(myPath)
end myOpenDeviceSupportFolder

on myOpenArchivesFolder()
set myPath to myXcodePath() & "/Archives/"
myOpenFolder(myPath)
end myOpenArchivesFolder

on myOpenProvisioningProfileFolder()
set myPath to myLibraryPath() & "/MobileDevice/Provisioning Profiles"
myOpenFolder(myPath)
end myOpenProvisioningProfileFolder

on myOpenProjectFolder()
set myPath to myProjectPath()
myOpenFolder(myPath)
end myOpenProjectFolder

on myOpenTermnalForCurrentProject()
set myPath to myProjectPath()
myOpeniTerm(myPath)
end myOpeniTermForCurrentProject

on myOpenDerivedDataFolder()
set myRelativePath to myProjectPath() & "/DerivedData/"
if myFolderExists(myRelativePath) then
myOpenFolder(myRelativePath)
else
myOpenFolder(myXcodePath() & "/DerivedData/")
end if
end myOpenDerivedDataFolder

on myOpenDocument()
set command1 to "cd ~/Library/Developer/CoreSimulator/Devices/;"
set command2 to "cd `ls -t | head -n 1`/data/Containers/Data/Application;"
set command3 to "cd `ls -t | head -n 1`/Documents;"
set command4 to "open ."
do shell script command1 & command2 & command3 & command4
end myOpenDocument

-- Clean

on myCleanDerivedData()
set myRelativePath to myProjectPath() & "/DerivedData"
if myFolderExists(myRelativePath) then
else
set myRelativePath to myXcodePath() & "/DerivedData"
end if
do shell script "rm -rf " & myRelativePath
end myCleanDerivedData

on myOpenAbout()
open location "https://github.com/GesanTung/XcodeWay"
end myOpenAbout
