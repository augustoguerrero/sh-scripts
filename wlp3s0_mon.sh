ifconfig wlp3s0 down
echo "wlp3s0 down..."
sleep 1

iwconfig wlp3s0 mode monitor
echo "wlp3s0 monitor mode..."
sleep 1

ifconfig wlp3s0 up
echo "wlp3s0 up..."
sleep 1

echo "Placa en modo monitor Ok."
