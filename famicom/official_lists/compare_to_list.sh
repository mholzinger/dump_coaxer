# "$1" is the official list
# "$2" is the path with files to look at

# Compare from an official list to files in a path

while IFS='' read -r line || [[ -n "$line" ]]
do

# Debug #   echo -n "looking for title: $line"

#    fuzzy=$(echo "$line" |sed \
#		-e s/\^[Aa]\ /\*/g \
#		-e s/[Tt][Hh][Ee]\ /\*/g \
#		-e s/\ [Ii][Nn]\ /\*/g \
#		-e s/\ [Oo][Ff]\ /\*/g \
#		-e s/\ [Tt][Oo]\ /\*/g \
#	    -e s/\ [Aa][Nn][Dd]\ /\*/g \
#		-e s/\'[Ss]/\*/g|\
#		tr ' ' '*'|\
#		tr '[:punct:]' '*')

    fuzzy=$(echo "$line" |sed \
		-e s/\^[Aa]\ /\*/g \
		-e s/[Tt][Hh][Ee]\ /\*/g \
		-e s/[Tt][Hh][Ee]/\*/g \
		-e s/\ [Ii][Nn]\ /\*/g \
		-e s/\ [Oo][Ff]\ /\*/g \
		-e s/\ [Tt][Oo]\ /\*/g \
	    -e s/\ [Aa][Nn][Dd]\ /\*/g \
		-e s/\ 1/I/g \
		-e s/2/II/g \
		-e s/\ 3/III/g \
		-e s/\ 4/IV/g \
		-e s/\ 5/V/g \
		-e s/\'[Ss]/\*/g|\
		tr ' ' '*'|\
		tr '[:punct:]' '*')


    fuzzy2=$(echo "$line" |sed \
		-e s/\^[Aa]\ /\*/g \
		-e s/[Tt][Hh][Ee]/\*/g \
		-e s/\ [Ii][Nn]\ /\*/g \
		-e s/\ [Oo][Ff]\ /\*/g \
		-e s/\ [Tt][Oo]\ /\*/g \
	    -e s/\ [Aa][Nn][Dd]\ /\*/g \
		-e s/\ [Ii]\ /1/g \
		-e s/\ [Ii][Ii]\ /2/g \
		-e s/\ [Ii][Ii][Ii]\ /3/g \
		-e s/\ [Ii][Vv]\ /4/g \
		-e s/\ [Vv]\ /5/g \
		-e s/\'[Ss]/\*/g|\
		tr ' ' '*'|\
		tr '[:punct:]' '*')


# grep -E '([Ii][Ii]|2)|([Ii]|1)|([Ii][Ii][Ii]|3)|([Ii][Vv]|4)|([Vv]|[5])'

# Debug
# echo pat1 *$fuzzy*
# echo pat2 *$fuzzy2*

    IFS= title=($(find  ../uncompressed/usa/M/ -iname *"$fuzzy"*))
#    title=$(find "$2" -iname *"$fuzzy"*| head -n 1)
    if [[ -n "$title" ]]
    then
		rom=$(basename "$title")
        echo MATCH: "$line" "->" \""$rom"\"
	else
		IFS= title=($(find  ../uncompressed/usa/M/ -iname  *"$fuzzy2"*))
#	    title=$(find "$2" -iname *"$fuzzy2"*| head -n 1)
	    if [[ -n "$title" ]]
	    then
			rom=$(basename "$title")
	        echo MATCH: "$line" "->" \""$rom"\"
        else 
            echo "NOT PRESENT: $line"
        fi
	fi

done < "$1"
