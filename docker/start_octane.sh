#!/bin/sh

if [ "$ONGOING_ENVIRONMENT" = "local" ]; then
    php artisan octane:start --watch
else
    php artisan octane:start
fi

