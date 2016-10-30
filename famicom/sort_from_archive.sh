# homebrew/   prototypes/ rom_hacks/  translated/ unlicensed/


zip_folder=7z
output_path=uncompressed
prog=/opt/local/bin/7z

everything_else(){
    mkdir -p $output_path/to_sort
    $prog x $zip_folder/ -o$output_path/to_sort \
		'-x!*Prototype*' \
		'-x!*(*Hack*)*' \
		'-x!*T+*' \
		'-x!*(J)*' \
		'-x!*(U)*' \
		'-x!*(Unl)*' \
		'-x!*(Ch)*' \
		'-x!*(E)*' \
		'-x!*[*b*]*'
}

check_tran(){ 

  echo debug: function check_tran

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -is 'T+')
#  has_title=$(7z l $1|grep .nes|grep -s '(Unl)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/unofficial/translated/"$nes_name"
    $prog -o$output_path/unofficial/translated/"$nes_name"/ x $zip_folder/"$nes_archive" '*T+*'
  else 
    echo "No translated roms found"
  fi
}

check_proto(){ 

  echo debug: function check_proto

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -is '(Prototype)')
#  has_title=$(7z l $1|grep .nes|grep -s '(Unl)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/unofficial/prototypes/"$nes_name"
    $prog -o$output_path/unofficial/prototypes/"$nes_name"/ x $zip_folder/"$nes_archive" '*(Prototype)*'
  else 
    echo "No Prototype roms found"
  fi
}


check_hak(){ 

  echo debug: function check_hak

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -is '(*hack*)')
#  has_title=$(7z l $1|grep .nes|grep -s '(Unl)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/unofficial/rom_hacks/"$nes_name"
    $prog -o$output_path/unofficial/rom_hacks/"$nes_name"/ x $zip_folder/"$nes_archive" '*(*Hack*)*'
  else 
    echo "No Rom Hacks rom found"
  fi
}

check_unl(){ 

  echo debug: function check_unl

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -s '(Unl)')
#  has_title=$(7z l $1|grep .nes|grep -s '(Unl)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/unofficial/unlicensed/"$nes_name"
    $prog -o$output_path/unofficial/unlicensed/"$nes_name"/ x $zip_folder/"$nes_archive" '*(Unl)*'	
  else 
    echo "No Unlicenced rom found"
  fi
}

check_cn(){ 

  echo debug: function check_cn

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -s '(Ch)')
#  has_title=$(7z l $1|grep .nes|grep -s '(Ch)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/international/china/"$nes_name"
    $prog -o$output_path/international/china/"$nes_name"/ x $zip_folder/"$nes_archive" '*(Ch)*'	'-x!*Prototype*' '-x!*(*Hack*)*' '-x!*T+*'
  else 
    echo "No Chinese rom found"
  fi
}


check_japan(){ 

  echo debug: function check_japan

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -s '(J)')
#  has_title=$(7z l $1|grep .nes|grep -s '(J)')

  if [[ -n "$has_title" ]];then
    echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/international/japan/"$nes_name"
    $prog -o$output_path/international/japan/"$nes_name"/ x $zip_folder/"$nes_archive" '*(J)*'	'-x!*Prototype*' '-x!*(*Hack*)*' '-x!*T+*'
  else 
    echo "No Japanese rom found"
  fi
}

check_us(){

  echo debug: function check_us

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -s '(U)')
#  has_title=$(7z l $1|grep .nes|grep -s '(U)')

  if [[ -n "$has_title" ]];then
	echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/usa_official/"$nes_name"
    $prog -o$output_path/usa_official/"$nes_name"/ x $zip_folder/"$nes_archive" '*(*U)*' '-x!*Prototype*' '-x!*(*Hack*)*' '-x!*T+*'
  else
    echo "No US rom found"
  fi
}

check_eu(){ 

  echo debug: function check_eu

  has_title=$(7z l "$zip_folder"/"$nes_archive"|grep .nes|grep -s '(E)')
#  has_title=$(7z l $1|grep .nes|grep -s '(E)')

  if [[ -n "$has_title" ]];then
	echo debug: Houston, we have something
    echo debug:  "$has_title"
    mkdir -p $output_path/international/eu/"$nes_name"
    $prog -o$output_path/international/eu/"$nes_name"/ x $zip_folder/"$nes_archive" '*(E)*' '-x!*Prototype*' '-x!*(*Hack*)*' '-x!*T+*'
  else
    echo "No EU rom found"
  fi
}

find $zip_folder/ -name '*.7z'|\
  while IFS= read -r foo
    do

      # capture some variables
	  echo debug: capturing variables
      nes_name=$(basename "$foo"|sed s/.7z//g)
      nes_archive=$(basename "$foo")
      echo debug:  printing nes_name $nes_name

      # Print out file contents
      echo debug: listing for $zip_folder/$nes_archive

      check_tran $zip_folder/$nes_archive

      check_proto $zip_folder/$nes_archive

      check_hak $zip_folder/$nes_archive

      check_japan $zip_folder/$nes_archive

      check_cn $zip_folder/$nes_archive

      check_us $zip_folder/$nes_archive

      check_eu $zip_folder/$nes_archive

      check_unl $zip_folder/$nes_archive

    done

