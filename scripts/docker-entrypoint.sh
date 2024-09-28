#!/bin/sh

echo "Starting JMusicBot made by ${bold}jagrosh${bold} (https://github.com/jagrosh/MusicBot)"
echo ""

# Change directory to the config folder
cd /app/config

exec java -Dnogui=true -jar /opt/jmusicbot/JMusicBot.jar
