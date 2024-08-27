#!/bin/bash

# Script to check service status and notify on changes

echo "Checking if services are up and running"

# Array of services to check
services=(
    "https://banger.saas.com/healthz"
    # Add more services here as needed
)

# Slack webhook URL
slack_webhook="https://hooks.slack.com/services/<replace_me>"

# JSON file to store service status
status_file="service_status.json"

# Function to check a service
check_service() {
    local service=$1
    response=$(curl -o /dev/null -s -w "%{http_code}" "$service")
    
    # Read current status from JSON file
    if [ -f "$status_file" ]; then
        current_status=$(jq -r ".[\"$service\"]" "$status_file")
    else
        current_status="unknown"
    fi

    if [ "$response" != "200" ] && [ "$current_status" != "down" ]; then
        message="Service $service is not responding with 200 OK"
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$slack_webhook"
        jq ".[\"$service\"] = \"down\"" "$status_file" > temp.json && mv temp.json "$status_file"
    elif [ "$response" == "200" ] && [ "$current_status" == "down" ]; then
        message="Service $service is back up and running"
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$slack_webhook"
        jq ".[\"$service\"] = \"up\"" "$status_file" > temp.json && mv temp.json "$status_file"
    fi
}

# Initialize status file if it doesn't exist
if [ ! -f "$status_file" ]; then
    echo "{}" > "$status_file"
fi

# Check services in parallel
for service in "${services[@]}"; do
    check_service "$service" &
done

# Wait for all background processes to finish
wait
