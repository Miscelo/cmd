#!/usr/bin/bash

# Archivo que contiene todos los comandos bash
file=bashcmd.lst

# Comprobamos si el archivo con los comandos existe
if [ ! -e $file ];then
	echo -e "No existe el archivo bashcmd.lst.\n
			Por favor, visiten la página web https://github.miscelo para bajar el archivo de nuevo.\n"
fi



# Realizamos una función que debe imprimir un comando shell aleatorio del archivo bashcmd.lst y tecleando RETURN sale la explicación.
getBashcmd() {
	lines=$(wc -l $file | cut -d" " -f1)
	for i in $(seq 1 $1);do
		echo -e "\n*********************** $i ****************************\n"
		random_number=$((RANDOM %$lines +1))
		sed -n "${random_number}p" $file | cut -d":" -f1
		echo "---"
		head -n $random_number $file | tail -n 1 | cut -d":" -f2
		echo ""
		read -s ret
	done
}




mainmenu() {
	echo -e "\n******************************************************"	
	echo -e "\n Bienvenidos - aquí puedes aprender comandos de shell\n"	
	PS3='Elige una opción: ' 	
	options=("10 comandos bash - ¡No tengo tiempo hoy!" "20 comandos bash - ¡Cumplo con mi deber diario!" "30 comandos bash - ¡Mañana tengo un exámen!" "Quit")
	select opt in "${options[@]}";do
    		case $opt in 
			"10 comandos bash - ¡No tengo tiempo hoy!")
            			getBashcmd 10;
				mainmenu;;
        		"20 comandos bash - ¡Cumplo con mi deber diario!")
            			getBashcmd 20;
				mainmenu;;
        		"30 comandos bash - ¡Mañana tengo un exámen!")
            			getBashcmd 30;
				mainmenu;;
        		"Quit")
            			exit;;
        		*) echo "invalid option $REPLY";;
    		esac
	done	
}


if [[ ! $1 ]];then
	mainmenu;
else
	# Sí el primer argumento es '-p' y el segundo '-all' o '-a' o el primer arguemnto es '-pa', imprime toda el archivo bashcmd.lst
	if ([[ $1 == "-p" ]] && [[ $2 == "-all" ]]) || ([[ $1 == "-p" ]] && [[ $2 == "-a" ]]) || [[ $1 == "-pa" ]];then
		cat $PWD/bashcmd.lst
	# Sí el primer argumento es -p, imprime sólo los comandos bash del archivo bashcmd.lst
	elif [[ $1 == "-p" ]];then
		cat $PWD/bashcmd.lst | cut -d":" -f1
	else
		#Añadir nuevos comandos al archivo manualmente  ./cmd <comando bash> <explicación> <apartado LPIC, p.E. 102.4 (opcional)> 
		if [ $# -eq 2 ];then
			#PAssed first 2 arguments to a file
			echo -e $1":"$2  >> /home/mic/Documents/PC-utilitis/bashcmd.lst
		elif [ $# -eq 3 ];then
			echo -e $1":"$2":"$3 >> /home/mic/Documents/PC-utilitis/bashcmd.lst
		else
			echo "Usage: cmd [argumentos]"
			echo " "
			echo "Maneja cmd con argumentos de confianza."	
			echo " "
			echo "  -g            - Start Game"
			echo "  -p            - muestra todos los comandos bash"
			echo "  -p (-all/-a)  - muestra todos los comandos con su explicación" 
			echo " "
		fi
	fi
fi



