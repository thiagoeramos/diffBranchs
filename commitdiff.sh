#!/bin/bash

echo "Informe o local aonde quer que os logs sejam salvos. (Somente o diretorio pois o arquivo é gerado automaticamente!)"

read -r path_logs
if(cd "$path_logs"); then

echo "Informe o repositorio que deseja fazer as comparacoes dos branchs"

read -r repositorio

echo "\n **********************\n Os logs serão salvos em $path_logs e a comparação de branchs será feita em: $repositorio 
	 \r\n Digite [ENTER] para continuar";

	read -r nextStep

		fLog="$path_logs/branchs_nao_presentes_$repositorio.txt";

		rm "$fLog"

		touch "$fLog";
		
		if(cat /etc/*-release | grep PRETTY ); then
		    cd /var/www/"$repositorio"
		else
		    cd C://xampp/htdocs/"$repositorio"
		fi

		git checkout dev

		for lista in $(git branch -r); 
			do

			val=$(echo $lista | awk '{split($0,a,"origin/"); print a[2]}');

			if (git log master | grep "$val"); then
			       echo "possui $val";
			else 	
			    echo "$val " >> "$fLog";
			fi
		done

		echo "\n ********************************************
		\n Acabou! Os logs constam em $fLog";
		else
			echo "\n ERRO! \n\n O programa nao encontrou o diretorio de destino para os logs. \n Por favor insira um caminho valido sem links ou atalhos"
		fi;