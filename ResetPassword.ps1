# Reset a user's password                                                                             
$username = Read-Host -Prompt "Enter the username of the account you want to reset the password for"  
$password = Read-Host -Prompt "Enter the new password for the account" -AsSecureString                
$user = Get-ADUser -Identity $username -ErrorAction SilentlyContinue                                  
if ($user -eq $null) {                                                                                
Write-Host "User not found"                                                                           
return                                                                                                
}                                                                                                     
Set-ADAccountPassword -Identity $username -NewPassword $password -Reset                             
Write-Host "Password reset successfully"