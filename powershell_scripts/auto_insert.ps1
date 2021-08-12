#Author: Davi Araújo
#Date: 27/07/2021

#Variables runbook
$pass = Get-AutomationVariable -Name 'pass'
$appId = Get-AutomationVariable -Name 'appId'
$StorageAccountKey = Get-AutomationVariable -Name 'storageKey'

#Get-Credentials (promptless)
$username = $appId
$password = ConvertTo-SecureString $pass -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

#Download of archives
$Context = New-AzureStorageContext -StorageAccountName 'storage-Account-Name' -StorageAccountKey $StorageAccountKey
Get-AzureStorageFileContent -ShareName 'Share-Name' -Context $Context -path 'users-to-be-placed-in-group.csv' -Destination 'C:\Temp'
$filePath = Join-Path -Path 'C:\Temp' -ChildPath 'users-to-be-placed-in-group.csv'

#Make connection with AD
Connect-AzAccount -Credential $psCred -Tenant 'Tenant-ID' -ServicePrincipal

#Add users to the group
Import-Csv –Path $filePath -Delimiter ";" | ForEach-Object {Add-AzADGroupMember -TargetGroupDisplayName "Group-To-Be-Placed" -MemberUserPrincipalName $_.’userPrincipalName’}