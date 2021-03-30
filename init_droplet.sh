#!/usr/bin/env bash

[ -z "$SERVER_NAME" ] && { echo "ERROR: Missing \$SERVER_NAME"; exit 1; }
[ -z "$SERVER_DOMAIN" ] && { echo "ERROR: Missing \$SERVER_DOMAIN"; exit 1; }
[ -z "$SERVER_REGION" ] && { echo "ERROR: Missing \$SERVER_REGION"; exit 1; }
[ -z "$SERVER_IMAGE" ] && { echo "ERROR: Missing \$SERVER_IMAGE"; exit 1; }
[ -z "$SERVER_SIZE" ] && { echo "ERROR: Missing \$SERVER_SIZE"; exit 1; }
[ -z "$SSH_KEY_SIG" ] && { echo "ERROR: Missing \$SSH_KEY_SIG"; exit 1; }

# Create a new droplet
echo -n "Droplet $SERVER_IMAGE ($SERVER_SIZE) created in $SERVER_REGION: "
DROPLET_ID=$(doctl compute droplet create "$SERVER_NAME" --region "$SERVER_REGION" --image "$SERVER_IMAGE" --size "$SERVER_SIZE" --ssh-keys "$SSH_KEY_SIG" --enable-monitoring --wait --format ID --no-header)
echo "$SERVER_NAME"

# Attach our floating IP to the newly created droplet
echo -n "Floating IP attached to droplet: "
FLOATING_IP=$(dig "$SERVER_DOMAIN" +short)
doctl compute fipa assign "$FLOATING_IP" "$DROPLET_ID" > /dev/null
echo "$FLOATING_IP"

# Create a cloud firewall and assign it to the newly created droplet
echo -n "Cloud firewall assigned to droplet: "
doctl compute firewall create --name "${SERVER_NAME}-fw" --droplet-ids "$DROPLET_ID" \
--inbound-rules "protocol:tcp,ports:22,address:0.0.0.0/0 protocol:tcp,ports:443,address:0.0.0.0/0" \
--outbound-rules "protocol:tcp,ports:1-65535,address:0.0.0.0/0 protocol:udp,ports:1-65535,address:0.0.0.0/0 protocol:icmp,ports:1-65535,address:0.0.0.0/0" > /dev/null
echo "${SERVER_NAME}-fw"
