# Xác định tên người dùng và mật khẩu mặc định
$username = Read-Host -Prompt "ten_nguoi_dung"
$password = Read-Host -Prompt "mat khau" | ConvertTo-SecureString -AsPlainText -Force
$domain1 = "ominext.local"
$domain2 = "omicare.ominext.local"

#hiden error when run script
$ErrorActionPreference = 'SilentlyContinue'

if ($username) {
    # Thiết lập thuộc tính để yêu cầu người dùng thay đổi mật khẩu lần đầu tiên đăng nhập
    Set-ADUser -Identity $username -ChangePasswordAtLogon $true $domain1
    
    # Nếu người dùng tồn tại, đặt mật khẩu mới cho tài khoản của họ
    Set-ADAccountPassword -Identity $username -NewPassword $password -Reset -ChangePasswordAtLogon $true
    
    # Hiển thị thông báo khi mật khẩu đã được đặt thành công
    Write-Host "Mật khẩu cho $username (OMINEXT) đã được đặt thành công. Người dùng sẽ được yêu cầu thay đổi mật khẩu lần đầu tiên đăng nhập." -ForegroundColor Green
}
elseif ($username) {
     # Thiết lập thuộc tính để yêu cầu người dùng thay đổi mật khẩu lần đầu tiên đăng nhập
    Set-ADUser -Identity $username -ChangePasswordAtLogon $true -Server $domain2
    
    # Nếu người dùng tồn tại, đặt mật khẩu mới cho tài khoản của họ
    Set-ADAccountPassword -Identity $username -NewPassword $password -Reset -ChangePasswordAtLogon $true -Server $domain2
    
    # Hiển thị thông báo khi mật khẩu đã được đặt thành công
    Write-Host "Mật khẩu cho $username (OMICARE) đã được đặt thành công. Người dùng sẽ được yêu cầu thay đổi mật khẩu lần đầu tiên đăng nhập." -ForegroundColor Green
} 
else {
    # Nếu người dùng không tồn tại, hiển thị thông báo lỗi
    Write-Host "Người dùng $username không tồn tại trong hệ thống. Vui lòng kiểm tra lại tên người dùng." -ForegroundColor Red
}
