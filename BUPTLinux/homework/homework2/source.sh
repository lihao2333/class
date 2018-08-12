#!/bin/bash  
OUTPUT=output
cal(){
	return $(expr $1 \* $2)
}
show(){
  	if [ $# == 0 ]
	then
	 	 printf "\n" >> $OUTPUT
	else
		printf $@ >> $OUTPUT
	fi
}
printf "%s\nclass:%d id:%d\nname:李昊\n" "Second linux homework" "2015211107" "2014210192">$OUTPUT
show "%-36s\n" "==========source_code=========="
cat $0>>$OUTPUT
show "%-36s\n" "==========output===================="
for i in $(seq 1 9)  
do   
		for j in $(seq 1 9)
		do
				if [ $i != 5 ]; then 
						cal $i $j
						show "%4d" "$?" 
				else 
				  		show "%4s" "!_!"
				fi
		done
		show
done  

show "%-27s\n" "===========end_of_file=============="
