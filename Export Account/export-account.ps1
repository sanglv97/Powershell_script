Install-Module -Name ImportExcel -Scope CurrentUser
Import-Module ActiveDirectory

# Define the path for the Excel file where you want to export the data
$excelFilePath = "C:\File_account.xlsx"

# Retrieve AD users' usernames and display names
$users = Get-ADUser -Filter * -Properties DisplayName, SamAccountName | Select-Object SamAccountName, DisplayName

# Export the data to an Excel file
$users | Export-Excel -Path $excelFilePath -WorksheetName "ADUsers" -AutoSize
