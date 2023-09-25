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

check_header "Strict-Transport-Security" "$url"
sleep 1
check_header "X-Content-Type-Options" "$url"
sleep 1
check_header "X-Frame-Options" "$url"
sleep 1
check_header "Content-Security-Policy" "$url"
sleep 1
check_header "X-Permitted-Cross-Domain-Policies" "$url"
