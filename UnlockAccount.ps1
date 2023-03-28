$ErrorActionPreference = 'SilentlyContinue'
$UserNames = Read-Host -Prompt "NHAP TAI KHOAN MA BAN MUON UNLOCKED"
$UserName = $UserNames.ToLower()
$domain1 = "ominext.local"
$domain2 = "omicare.ominext.local"
$UserOminext = Get-ADUser -Identity $UserName -Properties LockedOut -Server $domain1
$UserOmicare = Get-ADUser -Identity $UserName -Properties LockedOut -Server $domain2                
if ($UserOminext.LockedOut -eq $true)                                               
{                                                                                 
Unlock-ADAccount -Identity $UserName -Server $domain1                                             
Write-Host "=> Tai khoan" $UserName "OMINEXT da duoc unlocked!" -ForegroundColor Green                  
}
elseif ($UserOmicare.LockedOut -eq $true) {
Unlock-ADAccount -Identity $UserName -Server $domain2                                         
Write-Host "=> Tai khoan" $UserName "OMICARE da duoc unlocked" -ForegroundColor Green  
}                                                                            
else                                                                            
{                                                                                 
Write-Host "=> Tai khoan:" $UserName "khong bi khoa!" -ForegroundColor DarkYellow                         
}

Read-Host -Prompt "[Enter]"
