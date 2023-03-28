Import-Module ActiveDirectory

Write-Output " **************************************** BAT DAU TAO USER CHO DOMAIN OMICARE *****************************************"
Write-Output ""
$firstnames = Read-Host "* Hay nhap ho & ten dem(VIET HOA, KHONG DAU)"
$lastnames = Read-Host "* Hay nhap ten(VIET HOA, KHONG DAU)"
$usernames = Read-Host "* Hay nhap username can tao(viet thuong, khong dau)"
 $username = $usernames.ToLower()
 $firstname = $firstnames.ToUpper()
 $lastname = $lastnames.ToUpper()
$name = $firstname + " " + $lastname
$password = "Omi@12345" | ConvertTo-SecureString -AsPlainText -Force
$DomainOrSubdomain1 = "omicare.ominext.local"
$DomainOrSubdomain2 = "omicare.vn"
$a = "@"
$email1 = $username + $a + $DomainOrSubdomain1
$email2 = $username + $a + $DomainOrSubdomain2
Write-Host ""

Write-Output "* Vui long chon OU tuong ung"
Write-Host ""
Write-Output "1 - KE TOAN        4 - KINH DOANH           7 - MARKETING"           
Write-Output "2 - PRODUCT        5 - IT SOFT              8 - LOGISTECS"                  
Write-Output "3 - VPN            6 - IT INFRA"                                      
Write-Host ""
$validOptions = "1", "2", "3", "4", "5", "6", "7", "8"
$option = Read-Host -Prompt "* Nhap vi tri trong OU"
foreach ($data in $option) {
 if ($data -notin $validOptions) {
   do {
      Write-Host "Ban nhap sai vi tri, vui long nhap lai!"
     $option = Read-Host -Prompt "* Nhap vi tri trong OU"
   } until ($option -in "1", "2", "3", "4", "5", "6", "7", "8")
 }
}
switch ($option) {                                                       
"1" {$selectedOption = "OU=Ke Toan,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"}                        
"2" {$selectedOption = "OU=PRODUCT,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"}                                      
"3" {$selectedOption = "OU=VPN,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"}
"4" {$selectedOption = "OU=KinhDoanh,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"}
"5" {$selectedOption = "OU=IT Soft,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"}
"6" {$selectedOption = "OU=IT_Infra,DC=OMICARE,DC=OMINEXT,DC=LOCAL"} 
"7" {$selectedOption = "OU=Marketing,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAL"} 
"8" {$selectedOption = "OU=Logistics,OU=OMICARE,DC=OMICARE,DC=OMINEXT,DC=LOCAl"} 
#default {Write-Host "Invalid option"}
}
Write-Host "Ban da chon: $selectedOption"

Write-Host ""
    Write-Output "* Vui long chon GROUP tuong ung"
Write-Host ""
Write-Output "1 - KE TOAN OMC    3 - OMCITIS"
Write-Output "2 - PRODUCT        4 - MARKETING"

    Write-Host ""
    $validOptions2 = "1", "2", "3", "4"
    $option2 = Read-Host -Prompt "* Nhap vi tri trong GROUP"
foreach ($data2 in $option2) {
 if ($data2 -notin $validOptions2) {
   do {
      Write-Host "Ban nhap sai vi tri, vui long nhap lai!"
     $option2 = Read-Host -Prompt "* Nhap vi tri trong GROUP"
   } until ($option2 -in "1", "2", "3", "4")
 }
}
switch ($option2) {
"1" {$selectedOption2 = "ktomicare"}
"2" {$selectedOption2 = "produc"}
"3" {$selectedOption2 = "omcitis"}
"4" {$selectedOption2 = "Marketings"}
#default {Write-Host "Invalid option"}                                    
}
Write-Host "Ban da chon: $selectedOption2"
$ErrorActionPreference = 'SilentlyContinue'
$check = Get-ADUser -Filter {SamAccountName -eq $username} -Server $DomainOrSubdomain1 | Select-Object SamAccountName
  if ($username -in $check.SamAccountName) {
       Write-Host "$username da ton tai"
       Read-Host "Nhan [Enter] de thoat"
       exit                                                                                            
       break
  }
  else {
    New-ADUser -Name $name -DisplayName $name -GivenName $firstname -Surname $lastname -SamAccountName $username -UserPrincipalName ($email1) -EmailAddress $email2 -Path $selectedOption -AccountPassword $password -ChangePasswordAtLogon $true -Server $DomainOrSubdomain1 -Enabled $true
    Add-ADGroupMember -Identity $selectedOption2 -Members $username -Server $DomainOrSubdomain1   
        Write-Host "$username da tao thanh cong"
        Read-Host "Nhan [Enter] de thoat"
        exit
  }






