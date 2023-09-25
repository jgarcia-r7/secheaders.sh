#!/bin/bash

# Function to check for a header and colorize the output
check_header() {
    header="$1"
    url="$2"
    response=$(curl -sI "$url" | grep -i -e "$header:")
    
    if [ -n "$response" ]; then
        echo -e "\e[32m[✓] $header found\e[0m"
    else
        echo -e "\e[31m[✗] $header missing\e[0m"
    fi
}

# Function to check for HTTP error codes
check_http_status() {
    url="$1"
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    if [ "$http_status" = "403" ]; then
        echo -e "\e[31m[✗] HTTP Error 403 Forbidden\e[0m"
        exit 1
    elif [ "$http_status" = "503" ]; then
        echo -e "\e[31m[✗] HTTP Error 503 Service Unavailable\e[0m"
        exit 1
    elif [ "$http_status" != "200" ]; then
        echo -e "\e[31m[✗] HTTP Error $http_status\e[0m"
        exit 1
    fi
}

# Check for each of the headers
url=""
while getopts "u:" opt; do
    case $opt in
        u)
            url="$OPTARG"
            ;;
        *)
            echo "Usage: $0 -u <URL>"
            exit 1
            ;;
    esac
done

if [ -z "$url" ]; then
    echo "URL not provided. Usage: $0 -u <URL>"
    exit 1
fi

# Check HTTP status to determine if the host is unreachable
check_http_status "$url"

# If the host is reachable, proceed with checking headers
check_header "Strict-Transport-Security" "$url"
sleep 1
check_header "X-Content-Type-Options" "$url"
sleep 1
check_header "X-Frame-Options" "$url"
sleep 1
check_header "Content-Security-Policy" "$url"
sleep 1
check_header "X-Permitted-Cross-Domain-Policies" "$url"
