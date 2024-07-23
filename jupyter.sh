#!/bin/bash

# Step 1: Install Jupyter Notebook and Ngrok
pip install notebook
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvf ngrok-v3-stable-linux-amd64.tgz

# Step 2: Prompt for Ngrok authentication token
read -p "Please enter your Ngrok authentication token: " ngrok_token

# Step 3: Authenticate Ngrok with the provided token
./ngrok authtoken $ngrok_token

# Step 4: Start Ngrok to expose Jupyter Notebook
./ngrok http 8888 &

# Step 5: Start Jupyter Notebook without authentication
nohup jupyter notebook --allow-root --NotebookApp.token='' --NotebookApp.password='' --port=8888 &

# Step 6: Get the public URL for the Jupyter Notebook
sleep 5  # Wait for ngrok to establish the tunnel
curl -s http://localhost:4040/api/tunnels | python3 -c \
"import sys, json; print(json.load(sys.stdin)['tunnels'][0]['public_url'])"
