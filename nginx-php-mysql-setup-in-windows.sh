## Install NGINX

- Download the stable latest version of NGINX 
- Extract to a folder

    > C:\nginx
    
- Open a Command Prompt, navigate to Nginx folder

    > cd C:\nginx
    >
    > start nginx

- Test in browser

    > http://localhost

- To restart nginx

    > nginx -s reload

- To stop nginx

    > nginx -s stop


## Install Multiple PHP Versions

- Download Thread Safe ZIP builds

- Extract each to separate folders:

    > C:\php\php83
    > C:\php\php84

- Copy the php.ini-development to php.ini

- Verify by navigate to directory in CMD and run following command

    > CD C:\php\php84
    > php -v
    > or
    > php-cgi.exe -v

- To test in browser create a file phpinfo.php in root folder (C:\php\php84\phpinfo.php) and run following command
    
    > php -S 127.0.0.1:8000

- We can change following settings

    > extension_dir = "ext"
    > date.timezone = "Asia/Kolkata"
    > memory_limit = 512M
    > post_max_size = 64M
    > upload_max_filesize = 64M
    > max_execution_time = 120
    > max_input_time = 120

- Enable required extensions

    > extension=curl
    > extension=mbstring
    > extension=gd
    > extension=openssl
    > extension=mysqli
    > extension=pdo_mysql
    > extension=fileinfo
    > extension=zip
    > extension=intl
    > extension=exif

- CGI / FastCGI Settings

    > cgi.force_redirect = 0
    > cgi.fix_pathinfo = 1
    > fastcgi.logging = 0

## Install MySQL/MariaDB (Recommanded MariaDB)

- Download and install MariaDB (Windows (MSI Installer))

- Verify by following command

    > mysql -u root -p 
    > or
    > mariadb -u root -p

## Config Nginx to Use PHP

- Open C:\nginx\conf\nginx.conf 

- Find the server block and modify it

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        root   html; 
        # root D:/Projects/ #if we need to change root
        
        index  index.php index.html index.htm;

        location / {
            try_files $uri $uri/ /index.php?$args;
        }

        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;  # Default PHP version
            fastcgi_index  index.php;
            include        fastcgi_params;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        location ~ /\.ht {
            deny  all;
        }
    }

- by default Nginx blocks directory listing, if we need to enable directory browsing (autoindex)

- Inside the location / block, add or modify these lines:

    # Main location block
    location / {
        # Try to serve file or directory, otherwise pass to PHP
        try_files $uri $uri/ /index.php?$args;

        # Enable directory listing when no index file is found
        autoindex on;
        autoindex_exact_size off;  # Show sizes in KB/MB
        autoindex_localtime on;    # Show local time instead of UTC
    }

## Updated Nginx Configuration to separate PHP/WordPress sites 

- Replace the entire server { ... } block in nginx.conf

    http {
        include       mime.types;
        default_type  application/octet-stream;

        sendfile        on;
        keepalive_timeout  65;

        # Include individual site configs
        include sites-enabled/*.conf;
    }

- Create folder structure

    > C:/nginx/conf/sites-available
    > C:/nginx/conf/sites-enabled

- Create server block files and add content

    > PATH: C:/nginx/conf/sites-available/site1.conf

    server {
        listen       80;
        server_name site1.local;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        root   D:/Divyang/wordpress/site1;
        index  index.php index.html index.htm;

        location / {
            try_files $uri $uri/ /index.php?$args;

            # Enable directory listing when no index file is found
            #autoindex on;
            #autoindex_exact_size off;  # Show sizes in KB/MB
            #autoindex_localtime on;    # Show local time instead of UTC
        }

        location ~ \.php$ {
            fastcgi_pass   127.0.0.1:9000;  # Default PHP version
            fastcgi_index  index.php;
            include        fastcgi_params;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        location ~ /\.ht {
            deny  all;
        }
    }

    - Copy sites-available/site1.conf to sites-enabled directory (symlink/shortcut won't in windows)

        > xcopy /Y C:\nginx\conf\sites-available\*.conf C:\nginx\conf\sites-enabled\

    - Navigate C:\Windows\System32\drivers\etc\hosts add host

        > 127.0.0.1 site1.local
        > 127.0.0.1 site2.local

    - Restart Nginx

## Run Project

- Start PHP FastCGI

    > CD C:\php\php84
    >
    > php-cgi.exe -b 127.0.0.1:9000

- Start nginx

    > cd C:\nginx
    >
    > start nginx

## Run using register service

- Download NSSM (Non-Sucking Service Manager)

- Extract it to c:\nssm

- Install Nginx as a Windows Service

    > C:\nssm\win64\nssm.exe install nginx

- NSSM GUI opens

    > PATH: C:\nginx\nginx.exe
    > Startup directory: C:\nginx
    > Click Install service.

- Start service

    - net start nginx

- Install PHP-FastCGI as a Windows Service

    > C:\nssm\win64\nssm.exe install php-fpm

- NSSM GUI opens

    > PATH: C:\php\php84\php-cgi.exe
    > Startup directory: C:\php\php84
    > Arguments: -b 127.0.0.1:9000
    > Click Install service.

- Start service

    > net start php-fpm

- Restart nginx

    > net stop nginx
    > net start nginx
    >
    > OR
    >
    > nssm restart nginx