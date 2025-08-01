# pwsh initial start
pwsh -command {
set-psrepository -name psgallery -installationpolicy trusted
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
if (get-item $profile -erroraction silentlycontinue) {
add-content -path $profile -value "
Import-Module posh-git
Import-Module oh-my-posh
"} else {
set-content -path $profile -value "
Import-Module posh-git
Import-Module oh-my-posh
"}}
# NOTE!
## getting parameter names of command
## (Get-Command New-PSSession).ParameterSets.Name