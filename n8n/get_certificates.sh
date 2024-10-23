#!/bin/bash
# This script updates the DNS TXT record for the domain

DOMAIN="_acme-challenge.automation.leaftix.com"
VALUE=$CERTBOT_VALIDATION

# Use your DNS provider's API to update the TXT record
# Example for Cloudflare:
curl -X POST "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/dns_records" \
     -H "Authorization: Bearer YOUR_API_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"TXT","name":"'"$DOMAIN"'","content":"'"$VALUE"'","ttl":120}'

# Wait for DNS propagation
sleep 120
