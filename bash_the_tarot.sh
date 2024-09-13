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
declare -a ReadingMeanings=()
FOCUS=""
USER_SEED=""
QUERY=""
TempDir=$(mktemp -d)
########################################################################
# Arrays inside this script (the other data is in ./lib
########################################################################
declare -a join_phrases=("is about" "pertains to" "refers to" "is related to" "is regarding" "relates to")
declare -a light_phrases=("considering" "exploring" "looking into" "contemplating" "deliberating on" "reflecting on") 
declare -a shadow_phrases=("being wary of" "avoiding" "steering clear of" "forgoing" "resisting" "being suspicious of") 

declare -a narrative0=("The influence that is affecting you or the matter of inquiry generally" \
                        "The nature of the obstacle in front of you" \
                        "The aim or ideal of the matter" \
                        "The foundation or basis of the subject that has already happened" \
                        "The influence that has just passed or has passed away" \
                        "The influence that is coming into action and will operating in the near future" \
                        "The position or attitude you have in the circumstances" \
                        "The environment or situation that have an effect on the matter" \
                        "The hopes or fears of the matter" \
                        "The culmination which is brought about by the influence shown by the other cards") 
declare -a narrative1=("The heart of the issue or influence affecting the matter of inquiry" \
                        "The obstacle that stands in the way" \
                        "Either the goal or the best potential result in the current situation" \
                        "The foundation of the issue which has passed into reality" \
                        "The past or influence that is departing" \
                        "The future or influence that is approaching" \
                        "You, either as you are, could be or are presenting yourself to be" \
                        "Your house or environment" \
                        "Your hopes and fears" \
                        "The ultimate result or cumulation about the influences from the other cards in the divination")
declare -a narrative2=("Your situation" \
                        "An influence now coming into play" \
                        "Your hope or goal" \
                        "The issue at the root of your question" \
                        "An influence that will soon have an impact" \
                        "Your history" \
                        "The obstacle" \
                        "The possible course of action" \
                        "The current future if you do nothing" \
                        "The possible future") 
declare -a narrative3=("To resolve your situation" \
                        "To help clear the obstacle" \
                        "To help achieve your hope or goal" \
                        "To get at the root of your question" \
                        "To help see an influence that will soon have an impact" \
                        "To help see how you have gotten to this point" \
                        "To help interpret your feelings about the situation" \
                        "To help you understand the moods of those closest to you" \
                        "To help understand your fear" \
                        "To help see the outcome")


 declare -a position_names=("Card 1: The Present or The Self" \
"Card 2: The Problem" \
"Card 3: The Past" \
"Card 4: The Future" \
"Card 5: Conscious" \
"Card 6: Unconscious" \
"Card 7: Your Influence" \
"Card 8: External Influence" \
"Card 9: Hopes and Fears" \
"Card 10: Outcome" \
"Card X: Exit Reading")

 declare -a position_meanings=("The Present or The Self - This position illustrates the present circumstances and ongoing events. It can also paint a picture of your current mental state and provide a glimpse of you identity at the present moment." \
                        "The Problem - This card symbolizes the hurdles that youare grappling with, issues which need resolving to move ahead." \
                        "The Past - This position gives an insight into past occurrences and their contribution to the contemporary situation. It offers clues about the past influencers that steered the present conditions." \
                        "The Future - This card predicts possible developments, assuming the status quo. These are generally short-term predictions and do not depict an ultimate conclusion." \
                        "Conscious - This card scrutinizes what has your attention and where your thoughts lie. It could signify your objectives and wishes concerning this circumstance, as well as your expectations." \
                        "Unconscious - This card reveals the concealed underlying causes of the situation; the emotions, principles and values that the querent might still be clueless about. This card can sometimes be unexpected and signify a hidden determinant." \
                        "Your Influence - This card can be interpreted in various ways - though overall, it’s about how one's self-image can potentially shape outcomes. It asks what convictions about yourself are you carrying? Are you expanding or restricting yourself?" \
                        "External Influence - This card portrays the external world and its impact on the situation. It might symbolize the societal and emotional milieu, along with others' perceptions." \
                        "Hopes and Fears - This is a complex position to decipher, as the card can signify both: clandestine wishes and potential avoidances. It reflects the paradoxical human nature, where what we dread the most might be exactly what we have been yearning for." \
                        "Outcome - This card acts as an aggregate of the preceding cards. With everything considered, what is the probable outcome of the event? If the interpretation here does not suggest a positive result, the remaining cards in the spread can help find an alternative path.")

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
            num=$((num + 78)) 
            ReadingCardList[$i]="$num"
        fi
    done 
}


function create_card_interpretation () {
    position="$1"
    chooser=$((RANDOM%4))
    case $chooser in
        0) preface="${narrative0[position]}";;
        1) preface="${narrative1[position]}";;
        2) preface="${narrative2[position]}";;
        3) preface="${narrative3[position]}";;
    esac
    chooser=$((RANDOM%6))
    joiner="${join_phrases[chooser]}"
    cnum=$(echo "${ReadingCardList[$position]}")
    s1=$(grep -e "^$cnum\=" "${SCRIPT_DIR}/lib/number_cards.dat")
    cname=$(echo "${s1}" | awk -F '=' '{print $2}')
    crev=$(echo "${s1}" | awk -F '=' '{print $3}')
    choose2=$((RANDOM%6))
    if [ "${crev}" == "shadow" ];then
        c_mean=$(jq -r --arg CARDNAME "${cname}" '.tarot_interpretations[] | select(.name==$CARDNAME) | .meanings.shadow' "${SCRIPT_DIR}"/lib/interpretations.json | sed '1d;$d' | shuf | head -1 | awk -F '"' '{print $2}')
        join2="${shadow_phrases[choose2]}"
    else
        c_mean=$(jq -r --arg CARDNAME "${cname}" '.tarot_interpretations[] | select(.name==$CARDNAME) | .meanings.light' "${SCRIPT_DIR}"/lib/interpretations.json | sed '1d;$d' | shuf | head -1 | awk -F '"' '{print $2}')
        join2="${light_phrases[choose2]}"
    fi
    meaning=$(echo "${c_mean,,}")
    #printf "%s in %s: %s %s %s \n" "${cname}" "${crev}" "${preface}" "${joiner}" "${meaning}"   
    ReadingMeanings[$position]=$(printf "# %s in %s: %s %s %s %s \n" "${cname}" "${crev}" "${preface}" "${joiner}" "${join2}" "${meaning}")
}


if [[ "${@}" != "" ]];then
    USER_SEED="${@}"
    QUERY="${@}"
else
    USER_SEED=$(date +%s)
fi

draw_cards
# now that we've drawn the cards, we can pull the readings one at a time and present them to the user.
# iterate through the ten cards
# use the number_cards file to get the name and whether it's reversed or not
# for each position, random 0-3, pick that number of array and then the index number from the iteration for the narrative bit
# join phrase
# card phrase(s) pulled by jq from the json file
for (( i = 0; i < NUM_COUNT; i++ )); do
    create_card_interpretation $i
done

# OKAY, so for the fancy readings, we will allow the user to scroll back and forth through the positions.
# for each position:
# position_name
# position_explanation
# image ?
# jp2a --height=24 --colors ./maj15.jpg   AND CAN FLIP ON Y AXIS FOR REVERSED
# interpretation
# use [, ], and q 

loud "Beginning reading"
echo "Your query was: ${QUERY}"


for (( i = 0; i < NUM_COUNT; i++ )); do

    echo "${position_names[i]}" > "${TempDir}"/"${i}".txt
    echo " " >> "${TempDir}"/"${i}".txt
    echo "${position_meanings[i]}" >> "${TempDir}"/"${i}".txt
    echo " " >> "${TempDir}"/"${i}".txt
    echo "${ReadingMeanings[i]}" >> "${TempDir}"/"${i}".txt
    echo " ************" >> "${TempDir}"/"${i}".txt
    #echo -e "\E[0;32m(\E[0;37mn\E[0;32m)ext, (\E[0;37mp\E[0;32m)revious, or (\E[0;37mq\E[0;32m)uit? "; tput sgr0
    #read -r CHOICE
    #asciiart -c -w 30 ./cups04.jpg
    #img2txt.py --ansi --targetAspect=0.5 --maxLen=30 ./cups01.jpg
    #jp2a ./cups01.jpg --colors
    #asciiart -c -w 30 ./cups04.jpg
done


counter=0
exit=0


while [ $exit -eq 0 ]; do
    selected=$(printf "%s\n" "${position_names[@]}" | fzf | awk -F ':' '{print $1}' | awk -F ' ' '{print $2}')
    echo "$selected"
    if [ "$selected" == "X" ];then
        exit=1
        break
    else
        selected=$(( selected-1 ))
        echo "$selected"
        cat "${TempDir}"/"${selected}".txt
        read
    fi
    
done

# TODO Add option to save reading as one file
# TODO Add images
# TODO offer just slide by slide moving through

rm -rf "${TempDir}"/*
