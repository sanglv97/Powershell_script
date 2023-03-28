# Import the Active Directory module
Import-Module ActiveDirectory
# Change background color to black
$Host.UI.RawUI.BackgroundColor = 'Black'
Clear-Host

# function Remove Diacritics
function Remove-Diacritics 
{
  param ([String]$sToModify = [String]::Empty)

  foreach ($s in $sToModify) # Param may be a string or a list of strings
  {
    if ($sToModify -eq $null) {return [string]::Empty}

    $sNormalized = $sToModify.Normalize("FormD")

    foreach ($c in [Char[]]$sNormalized)
    {
      $uCategory = [System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($c)
      if ($uCategory -ne "NonSpacingMark") {$res += $c}
    }

    return $res
  }
}

$is = "y","Y","yes","YES"
do {
Write-Host ========> BAT DAU TAO TAI KHOAN
  $fullname = Read-Host "HAY NHAP HO & TEN"
  $email = Read-Host "HAY NHAP EMAIL"
  $domains = Read-Host "HAY NHAP DOMAIN AD"
  $domain = $domains.ToLower() | % {Remove-Diacritics $_}
  $name = $fullname.ToUpper() | % {Remove-Diacritics $_}
  $firstname,$lastname = $name.Split(' ')
  $givenName = [string]$firstname
  $surName = [string]$lastname
  $emailAddress = $email.ToLower() | % {Remove-Diacritics $_}
  $samAccountName = $emailAddress.Split('@')[0]
  $userPrincipalName = "$samAccountName@$domain"
  $password = Read-Host "HAY NHAP MAT KHAU" -AsSecureString
  $accountPassword = $password | ConvertTo-SecureString -AsPlainText -Force
  $description = "DAY LA TAI KHOAN $samAccountName"
  
  # option change password AtLogon
  Write-Host "BAN CO MUON THAY DOI MAT KHAU CHO LAN DAU DANG NHAP KHONG?" -ForegroundColor Blue
  Write-Host "(DONG Y) CHON [1]" -ForegroundColor Yellow
  Write-Host "(KHONG DONG Y) CHON [2]" -ForegroundColor Yellow
  
  $validOptions = "1", "2"
$option = Read-Host -Prompt "NHAP TUY CHON"
foreach ($dataAtlogon in $option) {
 if ($dataAtlogon -notin $validOptions) {
   do {
      Write-Host "BAN DA CHON SAI, VUI LONG CHON LAI!" -ForegroundColor Red
     $option = Read-Host -Prompt "NHAP TUY CHON"
   } until ($option -in "1", "2")
 }
}
switch ($option) {                                                       
"1" {$selectedOption = $true}                        
"2" {$selectedOption = $false}                                      
}

  $is2 = "y", "Y","YES","yes","yEs","YeS","Yes","yES","yeS","YEs"
  do { 
  # get groups in AD                          
  $checkgrp = Get-ADGroup -Filter {
  Name -notlike "Administrators" -and
  Name -notlike "Users" -and
  Name -notlike "Guests" -and
  Name -notlike "Print Operators" -and 
  Name -notlike "Backup Operators" -and 
  Name -notlike "Replicator" -and 
  Name -notlike "Remote Desktop Users" -and                    
  Name -notlike "Network Configuration Operators" -and        
  Name -notlike "Performance Monitor Users" -and              
  Name -notlike "Performance Log Users" -and                  
  Name -notlike "Distributed COM Users" -and                  
  Name -notlike "IIS_IUSRS" -and                             
  Name -notlike "Cryptographic Operators" -and                
  Name -notlike "Event Log Readers" -and                      
  Name -notlike "Certificate Service DCOM Access" -and       
  Name -notlike "RDS Remote Access Servers" -and              
  Name -notlike "RDS Endpoint Servers" -and                   
  Name -notlike "RDS Management Servers" -and                 
  Name -notlike "Hyper-V Administrators" -and                 
  Name -notlike "Access Control Assistance Operators" -and    
  Name -notlike "Remote Management Users" -and                
  Name -notlike "Name -notlike Storage Replica Administrators" -and         
  Name -notlike "Domain Computers" -and                       
  Name -notlike "Domain Controllers" -and                     
  Name -notlike "Schema Admins" -and                          
  Name -notlike "Enterprise Admins" -and                      
  Name -notlike "Cert Publishers" -and                        
  Name -notlike "Domain Admins" -and                          
  Name -notlike "Domain Users" -and                           
  Name -notlike "Domain Guests" -and                          
  Name -notlike "Group Policy Creator Owners" -and            
  Name -notlike "RAS and IAS Servers" -and                    
  Name -notlike "Server Operators" -and                       
  Name -notlike "Account Operators" -and                      
  Name -notlike "Pre-Windows 2000 Compatible Access" -and     
  Name -notlike "Incoming Forest Trust Builders" -and         
  Name -notlike "Windows Authorization Access Group" -and     
  Name -notlike "Terminal Server License Servers" -and        
  Name -notlike "Allowed RODC Password Replication Group" -and
  Name -notlike "Denied RODC Password Replication Group" -and 
  Name -notlike "Read-only Domain Controllers" -and          
  Name -notlike "Enterprise Read-only Domain Controllers" -and
  Name -notlike "Cloneable Domain Controllers" -and
  Name -notlike "Protected Users" -and
  Name -notlike "Key Admins" -and
  Name -notlike "Enterprise Key Admins" -and
  Name -notlike "DnsAdmins" -and
  Name -notlike "DnsUpdateProxy" -and
  Name -notlike "Storage Replica Administrators"
  } -Server $domain | Select-Object Name
  $getgrp = $checkgrp.Name
      $i = 0
  Write-Host "CHON SO TUONG UNG CHO GROUP:" -ForegroundColor Blue
  $getgrp | ForEach-Object {
      Write-Host "$i - $_" -ForegroundColor Yellow
      $i++
  }
  $countgrp = $checkgrp.count
  # specify the row number you want to display
  $rowNumber = Read-Host "NHAP SO TUONG UNG VOI GROUP CAN CHON"

  # use Select-Object to skip to the specified row and select only that row
  $grp = $checkgrp | Select-Object -Skip ($rowNumber - 0) -First 1
  $setgrp = $grp.Name
  $setou = (Get-ADGroup $setgrp -Server $domain).DistinguishedName.Replace("CN=$setgrp,","")
clear
  Write-Host "BAN DA CHON:" -ForegroundColor Blue
  Write-Host "GROUP =>" $setgrp -ForegroundColor Yellow
  Write-Host "OU =>" $setou -ForegroundColor Yellow
  $grpou = "$setgrp@$setou"
  $group = $grpou.Split("@")[0]
  $ou = $grpou.Split("@")[1]
  $exit2 = Read-Host "BAN CO MUON CHON LAI KHONG?(yes/no)"
} while ($is -eq $exit2)

  # check username in AD and create account
$check = Get-ADUser -Filter {SamAccountName -eq $samAccountName} -Server $domain | Select-Object SamAccountName
if ($samAccountName -in $check.SamAccountName) {
    Write-Host "TAI KHOAN ($samAccountName) DA TON TAI"  -ForegroundColor Red
  }
else {
  $user = New-ADUser `
      -Name $name `
      -Path $ou `
      -SamAccountName $samAccountName `
      -DisplayName $name `
      -GivenName $givenName `
      -SurName $surName `
      -UserPrincipalName $userPrincipalName `
      -EmailAddress $emailAddress `
      -AccountPassword $accountPassword `
      -Description $description `
      -Enabled $true `
      -ChangePasswordAtLogon $selectedOption `
      -Server $domain
  #add member to group
  Add-ADGroupMember -Identity $group -Members $samAccountName -Server $domain
  Write-Host "BAN DA TAO THANH CONG TAI KHOAN:" $samAccountName -ForegroundColor green
 }
 $exit = Read-Host "BAN CO MUON TIEP TUC TAO TAI KHOAN KHONG?(yes/no)"
clear
} while ($is -eq $exit)
