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
    } | Select-Object Name
