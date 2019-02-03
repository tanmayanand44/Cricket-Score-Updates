teamname=$1
rm -rf status result livescores.xml;
flag=0;
score="";
updatedscore="";
while true;
do
  sleep 10;
  rm -rf livescores.xml;
	wget http://www.espncricinfo.com/rss/livescores.xml;
	if [ "$flag" == 0 ]
	then
		score=$(cat livescores.xml | grep -m1 "$teamname");
		echo "1" >> status;
    echo "$score" >> status;
		flag=$1;
    temp=$(echo "$score" | grep -o -P '(?<=<title>).*(?=</title>)');  #regex source:https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
    finalstring=$(echo $temp| sed 's/\&amp;/\&/g');
    notify-send "$finalstring" --expire-time=1;
    echo "$temp">>result;
    echo "$score">>result;
  else
		updatedscore=$(cat livescores.xml | grep -m1 "$teamname");
		echo "2" >> status;
    echo "$updatedscore" >> status;
    if [ "$updatedscore" != "$score" ]
    then
      echo "changed">>result;
      temp=$(echo "$updatedscore" | grep -o -P '(?<=<title>).*(?=</title>)');  #regex source:https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
      finalstring=$(echo $temp| sed 's/\&amp;/\&/g');
      notify-send "$finalstring" --expire-time=1;
      score=$updatedscore;
      echo "$temp" >>result;
      echo "$updatedscore">>result;
      echo "$score">>result;
      # flag=$0;
    fi;
	fi;
done;
