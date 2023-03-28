# Import the Active Directory module
Import-Module ActiveDirectory

# Set the path to the Excel file containing the user account details
$excelFile = "C:\Users\Administrator\Documents\user_accounts.xlsx"

# Create a new Excel object
$excel = New-Object -ComObject Excel.Application

# Open the Excel file and select the first worksheet
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item(1)

# Get the total number of rows in the worksheet
$rowCount = ($worksheet.UsedRange.Rows).count

# Loop through each row in the worksheet and create a new user account in Active Directory
for ($i=2; $i -le $rowCount; $i++) {
    # Get the values from the current row
    $firstName = $worksheet.Cells.Item($i,1).Value2
    $lastName = $worksheet.Cells.Item($i,2).Value2
    $username = $worksheet.Cells.Item($i,3).Value2
    $password = $worksheet.Cells.Item($i,4).Value2
    $email = $worksheet.Cells.Item($i,5).Value2

    $department = $worksheet.Cells.Item($i,6).Value2
    $title = $worksheet.Cells.Item($i,7).Value2

    # Create a new user object
    $user = New-Object -TypeName Microsoft.ActiveDirectory.Management.ADUser

    # Set the user account properties
    $user.SamAccountName = $username
    $user.GivenName = $firstName
    $user.Surname = $lastName
    $user.UserPrincipalName = "$username@domain.com"
    $user.EmailAddress = $email
    $user.Department = $department
    $user.Title = $title

    # Set the user account password
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    $user.SetPassword($securePassword)

    # Set the user account to be enabled
    $user.Enabled = $true

    # Save the user account to Active Directory
    New-ADUser -Instance $user
     

    #add member to group
    Add-ADGroupMember -Identity $group -Members $username

}

# Close the Excel workbook and quit Excel
$workbook.Close()
$excel.Quit()