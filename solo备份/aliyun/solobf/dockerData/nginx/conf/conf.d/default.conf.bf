upstream backend {
	server localhost:8080; 
}

server {
    listen       443;
    server_name  localhost;
    ssl on;
    ssl_certificate /ssl/public.pem; 
    ssl_certificate_key /ssl/public.key;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;  

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {

       proxy_pass http://goofiest.top:8080;
	proxy_set_header  Host $http_host;
	    proxy_set_header  X-Real-IP  $remote_addr;
	    client_max_body_size  10m;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
server{
  listen 80;
  server_name goofiest.top;
  rewrite ^(.*) https://$host$1 permanent;
}

