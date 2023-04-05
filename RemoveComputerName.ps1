clear
$ErrorActionPreference = 'SilentlyContinue'
$ComputerNames = Read-Host -Prompt "NHAP COMPUTERNAME MA BAN MUON DELETE"
$ComputerName = $ComputerNames.ToUpper()
$domain1 = "ominext.local"
$domain2 = "omicare.ominext.local"
$CheckOminext = Get-ADComputer -Identity $ComputerName -Server $domain1 | Select-Object Name
$CheckOmicare = Get-ADComputer -Identity $ComputerName -Server $domain2 | Select-Object Name
$GetComputer1 =  $CheckOminext.Name
$GetComputer2 = $CheckOmicare.Name               
if ($GetComputer1 -eq $ComputerName)                                               
{                                                                                 
Remove-ADComputer -Identity $ComputerName -Confirm:$True -Server $domain1                                             
Write-Host "=> $ComputerName "OMINEXT da duoc xoa!" -ForegroundColor Green                  
}
elseif ($GetComputer2 -eq $ComputerName) {
Remove-ADComputer -Identity $ComputerName -Confirm:$True -Server $domain2                                     
Write-Host "=> $ComputerName "OMICARE da duoc xoa" -ForegroundColor Green  
}
else {
Write-Host "=> $ComputerName KHONG TON TAI TREN HE THONG"
}  
Read-Host -Prompt "[Enter]"
