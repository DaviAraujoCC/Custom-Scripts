$users = @()
Import-CSV -Path "/Directory/to/Csv/file" -Delimiter "," | ForEach-Object {$users += $_.userPrincipalName}


foreach ($user in $users)
{
    $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $st.RelyingParty = "*"
    $st.State = "Enabled"
    $sta = @($st)
    Set-MsolUser -UserPrincipalName $user -StrongAuthenticationRequirements $sta
}