$ErrorActionPreference = 'SilentlyContinue'
$ComputerNames = Read-Host -Prompt "NHAP COMPUTERNAME MA BAN MUON DELETE"
$ComputerName = $UserNames.ToLower()
$domain1 = "ominext.local"
$domain2 = "omicare.ominext.local"
$UserOminext = Get-ADComputer -Identity $ComputerName -Server $domain1 | Select-Object Name
$UserOmicare = Get-ADComputer -Identity $ComputerName -Server $domain2 | Select-Object Name                
if ($UserOminext.Name -eq $ComputerName)                                               
{                                                                                 
Remove-ADComputer -Identity $UserName -Server $domain1                                             
Write-Host "=> $ComputerName "OMINEXT da duoc xoa!" -ForegroundColor Green                  
}
elseif ($UserOmicare.Name -eq $ComputerName) {
Remove-ADComputer -Identity $ComputerName -Server $domain2                                         
Write-Host "=> $ComputerName "OMICARE da duoc xoa" -ForegroundColor Green  
}                                                                            
else                                                                            
{                                                                                 
Write-Host "=> $ComputerName "khong ton tai!" -ForegroundColor DarkYellow                         
}

Read-Host -Prompt "[Enter]"
