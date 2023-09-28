# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to the Excel file
Add-Type -AssemblyName System.Windows.Forms
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.ShowDialog() | Out-Null
$selectedFile = $dialog.FileName
$excelFile = $selectedFile

# Define the worksheet name
$worksheetName = "Sheet1"

# Open the Excel file
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Open($excelFile)
$worksheet = $workbook.Worksheets.Item($worksheetName)

# Get the number of rows in the worksheet
$rowCount = ($worksheet.UsedRange.Rows).Count

for ($i=2; $i -le $rowCount; $i++) {
    # Get the values from the current row
    $username = $worksheet.Cells.Item($i,1).Value2
    $fullname = $worksheet.Cells.Item($i,2).Value2

     
    if ($username -eq $null) {                               
        break                                                 
        }
     
	# change Display name
    Set-ADUser -Identity $username -DisplayName $fullname
   
    #check display name has changed
	$check = Get-ADUser -Identity $username | Select-Object 
    Write-Host "$username =>" $check.Surname -ForegroundColor green



}
# Close the Excel file
$workbook.Close()
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)

# Display a message indicating that the script has finished
Write-Host "Script completed."
read-host "Press [Enter] to exit"
