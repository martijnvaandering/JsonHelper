#!/bin/bash
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
if [ "$REQUEST_METHOD" = "POST" ]; then
	echo -e "Content-type:application/json\r\n"
    if [ "$CONTENT_LENGTH" -gt 0 ]; then
    in_raw="$(cat)"
		
	export IFS="&"
	for cmd in ${QUERY_STRING}; do
	
		 if [ "$(echo $cmd | grep '=')" ]; then
		 	key=$(echo $cmd | awk -F '=' '{print $1}')
		 	value=$(echo $cmd | awk -F '=' '{print $2}')
			value=$(urldecode "$value")
		 	declare $key="$value"
		 fi
		 
	done

    if [ $q ]; then
        q=$(echo $q | sed -E $'s/%20/ /g;s/%22/"/g;s/%27/\'/g')
        response=$(echo $in_raw | jq -r $q 2>&1)
		echo $response
        exit 0;
    fi

    if [ $select ]; then        
        echo $in_raw | jq -r "[.[] | {$select}]" 
        exit 0;
    fi

	fi
	exit 1;
fi

echo -e "Content-type:text/plain\r\n"
echo -e "yo"
