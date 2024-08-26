#!/bin/bash

# Script to display system uptime

echo "Is the services up and running"

# Array of services to check
services=(
    "https://identity.testing.dagen.se/health"
    # Add more services here as needed
)

# Slack webhook URL
slack_webhook="https://hooks.slack.com/services/<rest_of_the_url"

# Function to check a service
check_service() {
    local service=$1
    response=$(curl -o /dev/null -s -w "%{http_code}" "$service")
    if [ "$response" != "200" ]; then
        message="Service $service is not responding with 200 OK"
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$slack_webhook"
    fi
}

# Check services in parallel
for service in "${services[@]}"; do
    check_service "$service" &
done

# Wait for all background processes to finish
wait
