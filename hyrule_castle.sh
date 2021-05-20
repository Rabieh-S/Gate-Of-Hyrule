#!/bin/bash


#Je commence par créer mes variables
GREEN="\033[32m"
NORMAL="\033[0;39m"
RED="\033[31m"
floorLevel=1

#Ensuite je créé mes fonctions
getEnemyHpFromCsv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $name = Bokoblin ]]; then
	echo $hp
    fi 
done < enemies.csv
}
getEnemyNameFromCsv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $name = Bokoblin ]]; then
	echo -e $RED$name $NORMAL
    fi
done < enemies.csv
}


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

	#fonction de boss
getBossHpFromCsv() {
	        while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
		    if [[ $name = Ganon ]]; then
			echo $hp
		    fi 
done < bosses.csv
	}
getEnemyNameFromCsv() {
	    while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
		if [[ $name = Bokoblin ]]; then
		    echo -e $RED$name $NORMAL
		fi
	    done < enemies.csv
}
bossSTR() {
while IFS=',' read -r id name hp mp str int def res spd luck race rarity; do
    if [[ $name = Ganon ]]; then
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

fightSequence() {
    enemyRealHp=$(getEnemyHpFromCsv)

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

if [[ $enemyRealHp -lt 0 ]]; then
    echo "Enemy is dead ! Rest in peace ..."
elif [[ $linkRealHp -le 0 ]]; then
    echo "You are dead ! Try Again"
    exit 0
fi
floorLevel=$(($floorLevel + 1))
echo 
}


#J'introduis ensuite les valeurs tenant compte des fonctions ci-dessus
linkRealHp=$(getLinkHpFromCsv)


#L'aventure débute ici !

echo "
Good morning Link ! Welcome to the Hyrule Castle.
To find Ganon you will have to defeat enemies before.
One will appear at each floor. Ganon is at the 10th floor.
May the force be with you Link ...."





while [[ $floorLevel -lt 10 ]]; do
        echo "
=================== Floor $floorLevel ===================="

	read -p "Press enter to continue"
        echo "An enemy appears !"
	fightSequence

done

if [[ $floorLevel -eq 10 ]]; then
    echo "
=================== Floor $floorLevel ===================="

	read -p "Press enter to continue"


	
	
	#FightSequenceBoss
        enemyRealHp=$(getBossHpFromCsv)

while [[ $enemyRealHp -gt 0 ]] && [[ $linkRealHp -gt 0 ]]; do
    echo "$(getBossNameFromCsv)
    HP : " $enemyRealHp/"$(getBossHpFromCsv)
"

    echo "$(getLinkNameFromCsv)
    HP : " $linkRealHp/"$(getLinkHpFromCsv)
"
    echo "
======================== Options =======================
"    
    choice
    
    echo "Enemy attacked and dealt $(bossSTR)"
    linkRealHp=$(($linkRealHp - $(bossSTR)))
    echo "
Enemy attacked and dealt $(enemySTR) damages !"
done

    #Conclusion
    echo "Bravo ! 
Merci à Rabieh Sassi,aux Assets et aux co-promo"

fi
