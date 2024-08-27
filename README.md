# Service Health Check Script

This Bash script checks the health of specified services and sends notifications to Slack if any service is not responding with a 200 OK status.

Note: This is as basic as it gets

## Features

- Checks the health of multiple services
- Sends Slack notifications when a service goes down or comes back up
- Runs checks in parallel for efficiency
- Maintains service status in a JSON file to track changes

## How it works

1. The script iterates through the list of services.
2. For each service, it sends a GET request and checks the HTTP status code.
3. If a service is down (non-200 response) and was previously up, it sends a Slack notification.
4. If a service is up (200 response) and was previously down, it sends a Slack notification.
5. The current status of each service is stored in a JSON file (`service_status.json`).


## Prerequisites

- Bash shell
- `curl` command-line tool
- Slack webhook URL
- `jq` command-line JSON processor

## Configuration

1. Edit the `services` array to include the URLs of the services you want to monitor.
2. Set the `slack_webhook` variable with your Slack webhook URL.

## Usage

1. Make the script executable:
   ```
   chmod +x uptime.sh
   ```

2. Run the script:
   ```
   ./uptime.sh
   ```

It's recommended to set up a cron job to run this script at regular intervals.


## Running with Cron

To run this script every minute using cron:

1. Open the crontab file:
   ```
   crontab -e
   ```

2. Add the following line to run the script every minute:
   ```
   * * * * * /path/to/uptime.sh
   ```
   Replace `/path/to/` with the actual path to your script.

3. Save and exit the crontab editor.

The script will now run automatically every minute.

## Customization

- Add more services to the `services` array as needed.
- Modify the `check_service` function to adjust the health check criteria or add more complex checks.

## Note

Please ensure the Slack webhook URL is kept confidential and not shared publicly.
