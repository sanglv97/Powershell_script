# Import the Active Directory module
Import-Module ActiveDirectory

Write-Output " **************************************** BAT DAU TAO USER CHO DOMAIN OMINEXT *****************************************"
Write-Output ""
$firstnames = Read-Host "* Hay nhap ho & ten dem(VIET HOA, KHONG DAU)"
$lastnames = Read-Host "* Hay nhap ten(VIET HOA, KHONG DAU)"
$usernames = Read-Host "* Hay nhap username can tao(viet thuong, khong dau)"
$username = $usernames.ToLower()
$firstname = $firstnames.ToUpper()
$lastname = $lastnames.ToUpper()
$name = $firstname + " " + $lastname
$password = "Omi@12345" | ConvertTo-SecureString -AsPlainText -Force
$DomainOrSubdomain1 = "ominext.local"
$DomainOrSubdomain2 = "ominext.com"
$a = "@"
$email1 = $username + $a + $DomainOrSubdomain1
$email2 = $username + $a + $DomainOrSubdomain2
Write-Host ""

Write-Output "* Vui long chon OU tuong ung"
Write-Host ""
Write-Output "1 - BOM              6 - BU4             11 - KE TOAN         16 - TUYEN DUNG"
Write-Output "2 - IT Infra         7 - BU5             12 - DAO TAO         17 - R&D"   
Write-Output "3 - BU1              8 - BU6             13 - TRUYEN THONG    18 - INTERNAL TOOL"
Write-Output "4 - BU2              9 - HANH CHINH      14 - QA              19 - VP JAPAN"
Write-Output "5 - BU3              10 - BP             15 - NHAN SU" 
Write-Host ""
$validOptions = "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19" 
$option = Read-Host -Prompt "* Nhap vi tri trong OU" 
foreach ($data in $option) {
 if ($data -notin $validOptions) {
   do {
      Write-Host "Ban nhap sai vi tri, vui long nhap lai!"
     $option = Read-Host -Prompt "* Nhap vi tri trong OU"
   } until ($option -in "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19")
 }
}
switch ($option) {                                                       
"1" {$selectedOption = "OU=BOM,DC=OMINEXT,DC=LOCAL"}
"2" {$selectedOption = "OU=IT_Infra,DC=OMINEXT,DC=LOCAL"}                        
"3" {$selectedOption = "OU=BU-1,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}                                      
"4" {$selectedOption = "OU=BU-2,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"5" {$selectedOption = "OU=BU-3,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"6" {$selectedOption = "OU=BU-4,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"7" {$selectedOption = "OU=BU-5,OU=HCM.VP_BconsII,DC=OMINEXT,DC=LOCAL"} 
"8" {$selectedOption = "OU=BU-6,OU=HN01,DC=OMINEXT,DC=LOCAL"} 
"9" {$selectedOption = "OU=Hanh Chinh,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"} 
"10" {$selectedOption = "OU=BP,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"} 
"11" {$selectedOption = "OU=KETOAN,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"} 
"12" {$selectedOption = "OU=Dao Tao,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"13" {$selectedOption = "OU=Truyen Thong,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"14" {$selectedOption = "OU=QA,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"15" {$selectedOption = "OU=NhanSu,OU=NhanSu TuyenDung,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCALL"}
"16" {$selectedOption = "OU=TuyenDung,OU=NhanSu TuyenDung,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"17" {$selectedOption = "OU=R&D,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"}
"18" {$selectedOption = "OU=Internal Tool,OU=BACK OFFICE,OU=HO_HA NOI,DC=OMINEXT,DC=LOCAL"} 
"19" {$selectedOption = "OU=VP JAPAN,DC=OMINEXT,DC=LOCAL"}                       
#default {Write-Host "Invalid option"}                                    
}                                                                       
Write-Host "Ban da chon: $selectedOption"

Write-Host ""
    Write-Output "* Vui long chon GROUP tuong ung"
Write-Host ""
Write-Output "1 - BOM              10 - BP              19 - OMI JAPAN      28 - BUM 3"
Write-Output "2 - ITS              11 - KTOMI           20 - BUD 1          29 - BUM 4"
Write-Output "3 - BU1              12 - DAOTAO          21 - BUD 2          30 - BUM 5"
Write-Output "4 - BU2              13 - TRUYENTHONG     22 - BUD 3          31 - BUM 6"
Write-Output "5 - BU3              14 - QA              23 - BUD 4          32 - TPBP"
Write-Output "6 - BU4              15 - HR              24 - BUD 5          33 - TPHC"  
Write-Output "7 - BU5              16 - TD              25 - BUD 6          34 - TP.QA"
Write-Output "8 - BU6              17 - R&D             26 - BUM 1          35 - TP.TT"
Write-Output "9 - HANH CHINH       18 - INTERTOOL       27 - BUM 2"
    Write-Host ""
    $validOptions2 = "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35" 
    $option2 = Read-Host -Prompt "* Nhap vi tri trong GROUP" 
foreach ($data2 in $option2) {
 if ($data2 -notin $validOptions2) {
   do {
      Write-Host "Ban nhap sai vi tri, vui long nhap lai!"
     $option2 = Read-Host -Prompt "* Nhap vi tri trong GROUP"
   } until ($option2 -in "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35" )
 }
}
switch ($option2) {                                                       
"1" {$selectedOption2 = "BOM"}
"2" {$selectedOption2 = "ITS"}                                     
"3" {$selectedOption2 = "BU1"}                                      
"4" {$selectedOption2 = "BU2"}
"5" {$selectedOption2 = "BU3"}   
"6" {$selectedOption2 = "BU4"} 
"7" {$selectedOption2 = "BU5"} 
"8" {$selectedOption2 = "BU6"} 
"9" {$selectedOption2 = "HANHCHINH"} 
"10" {$selectedOption2 = "BP"} 
"11" {$selectedOption2 = "ktomi"} 
"12" {$selectedOption2 = "DAOTAO"}
"13" {$selectedOption2 = "TRUYENTHONG"}
"14" {$selectedOption2 = "QA"}
"15" {$selectedOption2 = "HR"}
"16" {$selectedOption2 = "TD"}
"17" {$selectedOption2 = "R&D"}
"18" {$selectedOption2 = "intertool"} 
"19" {$selectedOption2 = "omija"}  
"20" {$selectedOption2 = "BUD-1"}  
"21" {$selectedOption2 = "BUD-2"}  
"22" {$selectedOption2 = "BUD-3"}  
"23" {$selectedOption2 = "BUD-4"}  
"24" {$selectedOption2 = "BUD-5"}  
"25" {$selectedOption2 = "BUD-6"} 
"26" {$selectedOption2 = "BUM1"}  
"27" {$selectedOption2 = "BUM2"} 
"28" {$selectedOption2 = "BUM3"}               
"29" {$selectedOption2 = "BUM4"} 
"30" {$selectedOption2 = "BUM-5"} 
"31" {$selectedOption2 = "BUM6"} 
"32" {$selectedOption2 = "TPBP"} 
"33" {$selectedOption2 = "tphc"} 
"34" {$selectedOption2 = "TP.QA"} 
"35" {$selectedOption2 = "TP.TT"} 
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