STATUS=$(echo $(eww active-windows))
if [[ $STATUS != "" ]]; then
	eww close bar_1
else
	eww open bar_1
fi
