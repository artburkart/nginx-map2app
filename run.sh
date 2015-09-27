#!/usr/bin/env bash

set -m
set -e

# Swaps out defaults with proxy that points to app
if [ "$APP_PROXY" != "" ]; then
  sed -i '/#DEFAULT$/ s/^/  #/; s/#DEFAULTS//; s/^\s*#APP_PROXY/ /;' /etc/nginx/conf.d/default.conf
  temp=$(echo "$APP_PROXY" | sed 's/[\/&]/\\&/g')
  sed -i "s/{{APP_PROXY}}/$temp/" /etc/nginx/conf.d/default.conf
  unset APP_PROXY
fi

# Allows you to use nginx server for static pages
if [ "$STATIC_PATH" != "" ] && [ "$STATIC_DIR" != "" ]; then
  # Swap out STATIC_PATH
  sed -i 's/^\s*#STATIC_DIR/ /' /etc/nginx/conf.d/default.conf
  temp=$(echo "$STATIC_PATH" | sed 's/[\/&]/\\&/g')
  sed -i "s/{{STATIC_PATH}}/$temp/" /etc/nginx/conf.d/default.conf
  unset STATIC_PATH

  # Swap out STATIC_DIR
  temp=$(echo "$STATIC_DIR" | sed 's/[\/&]/\\&/g')
  sed -i "s/{{STATIC_DIR}}/$temp/;" /etc/nginx/conf.d/default.conf
  unset STATIC_DIR
fi

nginx -g "daemon off;";
