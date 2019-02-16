#!/bin/sh
#Test if a page existe on a wordpress based website ... in order to find hidden pages
myline=""

destdir=./test_output_70k_END.txt

mytest=0

echo " " >> "$destdir"
echo " " >> "$destdir"
echo "           \ -----------/----------/------------/-------------/------------- /         " >> "$destdir"
echo " " >> "$destdir"
echo " " >> "$destdir"

for i in `seq 0 70000`
do
	# myline=$(curl -s --connect-timeout 20 --head https://[YourWebsitehere]/?p=$i | head -n 1)
	sleep 1
	myline=$(curl -s --connect-timeout 20 --head https://[YourWebsitehere]/?p=$i | head -n 6 | tail -n 1 | cut -c 11-)

	# echo "p=$i -- $myline"

	mytest=$(echo "$myline" | grep 'http')


	if [ "$mytest" ]; then
		# echo "bad one"
		#mytest=0
	# else
		# echo "https://[YourWebsitehere]/?p=$i" >> "$destdir"
		echo "$myline" >> "$destdir"
		echo "p=$i -- $myline"
	fi
done

echo " " >> "$destdir"
echo " " >> "$destdir"
echo "           \ -----------/----------/------------/-------------/------------- /         " >> "$destdir"
echo " " >> "$destdir"
echo " " >> "$destdir"
