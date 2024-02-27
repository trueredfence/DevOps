## Normal Aapache Configuration behind proxy

```
#load mod if not enable
LoadModule ssl_module modules/mod_ssl.so
LoadModule headers_module modules/mod_headers.so


serverTokens Prod
ServerSignature Off
TraceEnable Off

# Additional Header settings (adjust as needed)
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>


# Additional HTTPS settings (adjust as needed)
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite HIGH:!aNULL:!MD5:!3DES:!CAMELLIA:!AES128
# Already Listen on port 443
#Listen 443
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
    ServerName wing.flyingmachine.online
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/4aoeILdluaraeureadIdlie
    # KeepAlive settings
    KeepAlive On
    MaxKeepAliveRequests 100 to 500
    KeepAliveTimeout 5

    #Set Env Variable
    SetEnv DB_NAME agent
    SetEnv DB_PASS HGet$^%2(826lkSrwNbdFg2#%
    SetEnv DB_USER root
    setEnv BASE_DIR 4aoeILdluaraeureadIdlie

    <Directory /var/www/html/4aoeILdluaraeureadIdlie>
        Options -Indexes -Includes -ExecCGI -FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        Require all denied
        Require ip 146.70.20.242
    </Directory>

    <FilesMatch "\.txt$">
        Require all denied
    </FilesMatch>

    <Location />
        Require all denied
        Require ip 146.70.20.242
    </Location>

    ErrorLog /var/log/httpd/uploader_error.log
    CustomLog /var/log/httpd/uploader_access.log combined
</VirtualHost>
```

## With mpm

```
# Cache
LoadModule cache_module modules/mod_cache.so
LoadModule cache_disk_module modules/mod_cache_disk.so
# Load necessary modules
LoadModule ssl_module modules/mod_ssl.so
LoadModule headers_module modules/mod_headers.so

# General server settings
ServerTokens Prod
ServerSignature Off
TraceEnable Off

# Additional Header settings (adjust as needed)
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>

# Additional HTTPS settings (adjust as needed)
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite HIGH:!aNULL:!MD5:!3DES:!CAMELLIA:!AES128

# VirtualHost configuration for port 443 (HTTPS)
<VirtualHost *:443>
    ServerName wing.flyingmachine.online
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/4aoeILdluaraeureadIdlie

    # SSL/TLS settings
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

    # KeepAlive settings
    KeepAlive On
    MaxKeepAliveRequests 100
    KeepAliveTimeout 5

    # Set environment variables
    SetEnv DB_NAME agent
    SetEnv DB_PASS HGet$^%2(826lkSrwNbdFg2#%
    SetEnv DB_USER root
    SetEnv BASE_DIR 4aoeILdluaraeureadIdlie


    # Enable caching
    CacheQuickHandler Off
    CacheLock on
    CacheLockPath /tmp/mod_cache-lock
    CacheLockMaxAge 5
    CacheIgnoreCacheControl On
    CacheMaxExpire 120
    CacheLastModifiedFactor 0.5
    CacheIgnoreHeaders Set-Cookie

    <Directory /var/www/html/4aoeILdluaraeureadIdlie>
        Options -Indexes -Includes -ExecCGI -FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        Require all denied
        Require ip 146.70.20.242
    </Directory>

    # Deny access to .txt files
    <FilesMatch "\.txt$">
        Require all denied
    </FilesMatch>

    # Restrict access to the root location
    <Location />
        Require all denied
        Require ip 146.70.20.242
    </Location>

    # Logging settings
    ErrorLog /var/log/httpd/uploader_error.log
    CustomLog /var/log/httpd/uploader_access.log combined
</VirtualHost>

# MPM Prefork Module Settings
<IfModule mpm_prefork_module>
    StartServers              4
    MinSpareServers          20
    MaxSpareServers          40
    MaxRequestWorkers       200
    MaxConnectionsPerChild 4500
</IfModule>

# For high volume traffic
<IfModule mpm_event_module>
    StartServers              2
    MaxRequestWorkers       4000
    MinSpareThreads          75
    MaxSpareThreads         250
    ThreadsPerChild          25
    MaxConnectionsPerChild  0
</IfModule>

```
