#!/usr/bin/awk -f

{
	b=0;
	for(a=0;a<i;a++){
		if(arr[a]==$0){
			arr[i]=$0;
			arr[a] = "";
			b=1;
		}
	}
	if(b==0){
		arr[i]=$0;
	}
	i++;
} END {
	for(a=0;a<i;a++) {
		if(arr[a] != ""){
			print arr[a]
		}
	}
}
