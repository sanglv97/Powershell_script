# Import the Active Directory module
Import-Module ActiveDirectory

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


# Use the dialog box to browse for the file or folder you want to select
Add-Type -AssemblyName System.Windows.Forms
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.ShowDialog() | Out-Null
$selectedFile = $dialog.FileName

# Set the path to the Excel file containing the user account details
$excelFile = "$selectedFile"

# Define the worksheet name
$worksheetName = "sanglv"

# Create a new Excel object
$excel = New-Object -ComObject Excel.Application

# Open the Excel file and select the first worksheet
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item($worksheetName)

# Get the total number of rows in the worksheet
$rowCount = ($worksheet.UsedRange.Rows).count

# Loop through each row in the worksheet and create a new user account in Active Directory
for ($i=2; $i -le $rowCount; $i++) {
    # Get the values from the current row
    $fullname = $worksheet.Cells.Item($i,1).Value2
    $email = $worksheet.Cells.Item($i,2).Value2
    $passwords = $worksheet.Cells.Item($i,3).Value2
    $domains = $worksheet.Cells.Item($i,4).Value2
    $grp = $worksheet.Cells.Item($i,5).Value2
    $ous = $worksheet.Cells.Item($i,6).Value2
    
    # Chain separation
    $firstName, $lastName = $fullname.Split(' ')
    $username = $email.Split('@')[0]

    # execute will be stopped if the value is null
    if ($fullname -eq $null) {                               
    break                                                 
    }
    #hiden error when run script
    $ErrorActionPreference = 'SilentlyContinue'

    $name = $fullname.ToUpper() | % {Remove-Diacritics $_}
    $firstname,$lastname = $name.Split(' ')
    $username = $email.Split('@')[0]
    $ou = $ous
    $domain = $domains.ToLower()
    $samAccountName = $username.ToLower()
    $givenName = [string]$firstName
    $surName = [string]$lastName
    $userPrincipalName = "$username@$domain"
    $emailAddress = $email.ToLower()
    $password = $passwords | ConvertTo-SecureString -AsPlainText -Force
    $description = "User account created from Excel file"
    $accountPassword = $password
    $group = $grp

# check username in AD and create account
$check = Get-ADUser -Filter {SamAccountName -eq $samAccountName} -Server $domain | Select-Object SamAccountName
  if ($samAccountName -in $check.SamAccountName) {
      Write-Host "User account existed:" $samAccountName -ForegroundColor Red
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
        -ChangePasswordAtLogon $true
    #add member to group
    Add-ADGroupMember -Identity $group -Members $samAccountName
    Write-Host "User account created:" $samAccountName -ForegroundColor green
    }
    $user
}

# Close the Excel file
$workbook.Close()
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

# Display a message indicating that the script has finished
Write-Host "Script completed."
read-host "Press [Enter] to exit"