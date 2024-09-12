    #!/bin/bash  
  
 ######################################################################## 
 #   bash-the-tarot 
 #   a very bespoke news searcher 
 #   by Steven Saus (c)2024 
 #   Licensed under CC0 license 
 #  
 ######################################################################## 
 
######################################################################## 
# Definitions 
######################################################################## 
export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")" 
# noisy feedback or not? 
LOUD=1 
declare -a ReadingCardList=() 
FOCUS=""
USER_SEED=""
######################################################################## 
# Arrays inside this script (the other data is in ./lib 
######################################################################## 
declare -a join_phrases=("is about" "pertains to" "refers to" "is related to" "is regarding" "relates to") 
declare -a light_phrases=("consider" "aim for" "try" "explore" "look into" "contemplate" "deliberate on" "ruminate over" "reflect on")  
declare -a shadow_phrases=("be wary of" "avoid" "steer clear of" "forgo" "refain from" "resist" "stop" "be suspicious of")  
declare -a narrative0=("The influence that is affecting you or the matter of inquiry generally"  
                        "The nature of the obstacle in front of you"  
                        "The aim or ideal of the matter"  
                        "The foundation or basis of the subject that has already happened"  
                        "The influence that has just passed or has passed away"  
                        "The influence that is coming into action and will operatin in the near future"  
                        "The position or attitude you have in the circumstances"  
                        "The environment or situation that have an effect on the matter"  
                        "The hopes or fears of the matter"  
                        "The culmination which is brought about by the influence shown by the other cards")  
declare -a narrative1=("The heart of the issue or influence affecting the matter of inquiry"  
                        "The obstacle that stands in the way"  
                        "Either the goal or the best potential result in the current situation"  
                        "The foundation of the issue which has passed into reality"  
                        "The past or influence that is departing"  
                        "The future or influence that is approaching"  
                        "You, either as you are, could be or are presenting yourself to be"  
                        "Your house or environment"  
                        "Your hopes and fears"  
                        "The ultimate result or cumulation about the influences from the other cards in the divination")  
declare -a narrative2=("Your situation"  
                        "An influence now coming into play"  
                        "Your hope or goal"  
                        "The issue at the root of your question"  
                        "An influence that will soon have an impact"  
                        "Your history"  
                        "The obstacle"  
                        "The possible course of action"  
                        "The current future if you do nothing"  
                        "The possible future")  
declare -a narrative3=("To resolve your situation"  
                        "To help clear the obstacle"  
                        "To help achieve your hope or goal"  
                        "To get at the root of your question"  
                        "To help see an influence that will soon have an impact"  
                        "To help see how you've gotten to this point"  
                        "To help interpret your feelings about the situation"  
                        "To help you understand the moods of those closest to you"  
                        "To help understand your fear"  
                        "To help see the outcome")  
 
 
######################################################################## 
# Functions 
######################################################################## 
 
function loud() { 
    if [ $LOUD -eq 1 ];then 
        echo "$@" 
    fi 
} 
 
 
 
 
  
function get_random_baby(){
    # if there is user input on what to inquire about
    if [ "${USER_SEED}" != "" ];then
        # run string of seed through here to turn into numbers 
        SEED=$(echo "${USER_SEED}" |  od -An -vtu1 | sed 's/  / /g' | tr ' ' '+') 
        SEED="${SEED:1}" #remove first +
        SEED=$(echo $(( SEED )))
        SEED=$(( SEED + $(date +%s) ))
    else
        SEED=$(date +%s)
    fi
    RANDOM=$SEED
    echo $(( RANDOM % 78  )) 
    sleep 1

}
  
function draw_cards(){ 
 
    readonly NUM_RANGE=78  
    readonly NUM_COUNT=10
  
 


  
    for (( i = 0; i < NUM_COUNT; i++ )); do  
        loud "Drawing card number $( echo $(( i + 1)))"
        while (( 1 )); do  
  
            rand=$(get_random_baby)
            rand=$((rand+1))  
            if [[ ! " ${drawn[@]} " =~ " ${rand} " ]]; then  
                ReadingCardList+=($rand)  
                break  
            fi  
        done  
    done  
    for (( i = 0; i < NUM_COUNT; i++ )); do  
        flip=$((RANDOM%2))  
        if [ $flip -eq 1 ]; then  
            num="${ReadingCardList[$i]}"
            echo "FLIP" 
            num=$((num + 78))  
            ReadingCardList[$i]="$num"
        fi
    done  
} 
 
if [[ "${@}" != "" ]];then
    USER_SEED="${@}"
else
    USER_SEED=$(date +%s)
fi

draw_cards 


echo "${ReadingCardList[@]}" 

# now that we've drawn the cards, we can pull the readings one at a time and present them to the user.
# iterate through the ten cards
# use the number_cards file to get the name and whether it's reversed or not
# for each position, random 0-3, pick that number of array and then the index number from the iteration for the narrative bit
# join phrase
# card phrase(s) pulled by jq from the json file

echo "${ReadingCardList[3]}" 
  
