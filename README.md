# Service Health Check Script

This Bash script checks the health of specified services and sends notifications to Slack if any service is not responding with a 200 OK status.

Note: This is as basic as it gets

## Features

- Checks multiple services in parallel
- Sends Slack notifications for non-responsive services
- Easily configurable service list

## Prerequisites

- Bash shell
- `curl` command-line tool
- Slack webhook URL

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

Please make sure that the Slack webhook URL is kept confidential and not shared publicly.
