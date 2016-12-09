#!/bin/bash
#./make_color.sh > set_color
echo "#!/bin/bash"
echo "end=\"\033[0m\""
for i in "red=31" "green=32" "yellow=33" "blue=34" "purple=35" "wathet=36"
do
	color=$(echo $i | awk -F "=" '{print $1}')
	color_num=$(echo $i | awk -F "=" '{print $2}')
	echo "###########${color}###########"
	for j in "" "_1" "_4" "_5" "_7" "_1_4" "_1_5" "_1_7"
	do
		color_type=$(echo $j | awk -F "_" '{if(length($0) == 0){print }else if(length($0) == 2){print $2}else if(length($0) == 4){print $2";"$3}}')
		echo "${color}${j}=\"\033[${color_type};${color_num}m\""	
	done
	
done

