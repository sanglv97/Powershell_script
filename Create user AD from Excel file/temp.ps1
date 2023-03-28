# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the Excel file
$excelFile = "C:\users.xlsx"

# Define the worksheet name
$worksheetName = "Sheet1"

# Open the Excel file
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item($worksheetName)

# Get the number of rows in the worksheet
$rowCount = ($worksheet.UsedRange.Rows).Count

# Loop through each row in the worksheet
for ($i = 2; $i -le $rowCount; $i++) {

    # Get the values from the current row
    $firstName = $worksheet.Cells.Item($i, 1).Value2
    $lastName = $worksheet.Cells.Item($i, 2).Value2
    $username = $worksheet.Cells.Item($i, 3).Value2
    $password = $worksheet.Cells.Item($i, 4).Value2
    $email = $worksheet.Cells.Item($i, 5).Value2

    # Create the user account in Active Directory
    $name = "$firstName $lastName"
    $ou = "OU=Users,OU=Company,DC=example,DC=com"
    $domain = "example.com"
    $samAccountName = $username
    $displayName = $name
    $givenName = $firstName
    $surName = $lastName
    $userPrincipalName = "$username@$domain"
    $emailAddress = $email
    $password = ConvertTo-SecureString $password -AsPlainText -Force
    $description = "User account created from Excel file"
    $accountPassword = $password

    $user = New-ADUser `
        -Name $name `
        -Path $ou `
        -SamAccountName $samAccountName `
        -DisplayName $displayName `
        -GivenName $givenName `
        -SurName $surName `
        -UserPrincipalName $userPrincipalName `
        -EmailAddress $emailAddress `
        -AccountPassword $accountPassword `
        -Description $description `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    # Set additional attributes if needed
    # Set-ADUser $user -Department "Sales"

    Write-Host "User account created: $name"
}
# Close the Excel file
$workbook.Close()
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

# Display a message indicating that the script has finished
Write-Host "Script completed."