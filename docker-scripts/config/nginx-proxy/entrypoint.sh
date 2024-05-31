#!/bin/sh

# Write custom Nginx configuration
echo 'server_tokens off;' >/etc/nginx/conf.d/my_proxy.conf
echo 'client_max_body_size 100m;' >>/etc/nginx/conf.d/my_proxy.conf

# Execute the original entrypoint
exec "$@"
