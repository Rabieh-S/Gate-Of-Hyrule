#!/bin/bash


#Je commence par créer mes variables
GREEN="\033[32m"
NORMAL="\033[0;39m"
RED="\033[31m"
floorLevel=10


getLinkHpFromCsv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $name = Link ]]; then
	echo $hp
    fi  
done < players.csv
}

getLinkNameFromCsv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $name = Link ]]; then
	echo -e $GREEN$name $NORMAL
    fi  
done < players.csv
}

linkSTR() {
    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
	if [[ $name = Link ]]; then
            echo $str
	fi  
    done < players.csv
}
enemySTR() {
while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $id = 12 ]]; then
        echo $str
    fi  
done < enemies.csv
}
	
LinkHealing() {
    	halfHealth=$(($(getLinkHpFromCsv) / 2))
	linkRealHp=$(( $linkRealHp + $halfHealth ))
	if [[ $linkRealHp -gt $(getLinkHpFromCsv) ]]; then
	    linkRealHp=$(getLinkHpFromCsv)
	fi
}
choice() {
   echo  "
1. Attack  2. Heal "
    read choice
    if [[ $choice == 1 ]]; then
	    enemyRealHp=$(($enemyRealHp - $(linkSTR)))
	    echo "
You attacked and dealt $(linkSTR) damages !"
    elif [[ $choice == 2 ]]; then
	LinkHealing
	echo "Healing done !"
    else
    echo "You have to choose ! 1 or 2 ? This is the only way ..."
    choice
fi
}

linkRealHp=$(getLinkHpFromCsv)

echo "=================== Floor $floorLevel ===================="


read -p "Press enter to continue"


#fonction de boss

getBossHpFromCsv() {
	        while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
		    if [[ $name = Ganon ]]; then
			echo $hp
		    fi 
done < bosses.csv
	}
	
	#FightSequenceBoss
        enemyRealHp=$(getBossHpFromCsv)

	linkRealHp=60
while [[ $enemyRealHp -gt 0 ]] && [[ $linkRealHp -gt 0 ]]; do
    echo "$(getEnemyNameFromCsv)
    HP : " $enemyRealHp/"$(getEnemyHpFromCsv)
"

    echo "$(getLinkNameFromCsv)
    HP : " $linkRealHp/"$(getLinkHpFromCsv)
"
    echo "
======================== Options =======================
"    
    choice
    
    echo "Enemy attacked and dealt $(enemySTR)"
    linkRealHp=$(($linkRealHp - $(enemySTR)))
    echo "
Enemy attacked and dealt $(enemySTR) damages !"
    done
    
