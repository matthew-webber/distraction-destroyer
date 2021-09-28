#!/bin/bash

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

random() {
   local arr=("${!1}")
   echo -e "${arr[$RANDOM % ${#arr[@]}]}"
}

ascii_banner()
{
  printf "$@"
}

# pairs w/ prompt variables
function opening_prompt {
   # timed prompt before script begins
   flag=false
   local prompt=$1
   local choices=$2
   local timeout2=$3
   # countdown starts
   for (( i=$timeout2; i>0; i--)); do
      printf "\r${prompt} ${i} or ${choices}"
      case "$i" in
         [4]* ) printf "\e[K🐉 Let the slaying.";;
         [3]* ) printf "🐉 Let the slaying..";;
         [2]* ) printf "🐉 Let the slaying...";;
         [1]* ) printf "🐉 Let the slaying... begin!";;
      esac
      read -s -n 1 -t 1 waitresponse
      if [ $? -eq 0 ]
      then
        case "$waitresponse" in
           [Qq]* ) input="q"; flag=true;; # quit
           [Ee]* ) input="e"; flag=true;; # edit
           "" ) input=""; flag=true;; # any key
           * ) : ;; # continue counting
        esac
      fi
      if flag=true; then printf "\r${prompt} 0 or ${choices}"; printf "🐉 Let the slaying... begin!"; break; fi
   done

}


# sudo check
if [ "$EUID" -ne 0 ]; then
   error "You must run Distraction Destroyer as root.  Quitting..."
   exit
fi

# prompt variables
timeout=7
countdown_message="🐲 Destruction shall commence in"
choices='['"$bold"''"$underline"'e'"$normal"'dit/'"$bold"''"$underline"'r'"$normal"'esurrect/'"$bold"''"$underline"'q'"$normal"'uit]'

# response variables
declare -a tryagain=("Pardon?" "I don't understand..." "What?" "Umm..." "I don't have all day...")
declare -a nochanges=("I found nothing but the ghosts of your enemies." "You woke me up for this?" "Apparently they all died of fright.")
declare -a changesmade=("Destruction completed." "Those distractions won't be bothering you anymore..." "The enemies of focus have been dispatched." "That was too easy..." "Are you not entertained?!")

# format variables
redc='\e[0;31m'
greenc='\e[1;32m'
bluec='\e[1;34m'
bold=$(tput bold)
underline=$(tput smul)
normal=$(tput sgr0)
nonec='\e[0m'

hostfile=/etc/hosts

# get the target domains from the domains file and put into array
targets=( $(cat targets.txt) )

# flag for script logic on flushing DNS
# do not change!
flush=false



ascii_banner "${bluec}      ....
   ,od88888bo.
 ,d88888888888b
,dP\"\"'   \`\"Y888b       ,.
d'         \`\"Y88b     .d8b. ,
'            \`Y88[  , \`Y8P' db
${redc}Distraction${bluec}   \`88b  Ybo,\`',d88)
${redc}Destroyer${bluec}     ]88[ \`Y888888P\"
${redc}v1${bluec}           ,888)  \`Y8888P'
             ,d888[    \`\"\"'
          .od8888P          ...
     ..od88888888bo,      .d888b
          \`\"\"Y888888bo. .d888888b
.             \`Y88b\"Y88888P\"' \`Y8b
:.             \`Y88[ \`\"\"\"'     \`88[
|b              |88b            Y8b.
\`8[             :888[ ,         :88)
 Yb             :888) \`b.       d8P'
 \`8b.          ,d888[  \`Ybo.  .d88[
  Y8b.        .dWARP'   \`Y8888888P
  \`Y88bo.  .od8888P'      \"YWARP'
   \`\"Y8888888888P\"'         \`\"'
      \`\"Y8888P\"\"'  ${nonec}ASCII: warp.tmt.1997${bluec}
         \`\"\"'      ${nonec}https://github.com/matthew-webber/distraction-destroyer
"

# startup prompt
printf "\n\n🐲 Know thy enemies and I shall detroy them.\n"
echo -e "\n${underline}Targets${normal}"
for target in "${targets[@]}"
do
   printf "🎯 $target\n"
done

printf "\n" # formatting

opening_prompt "$countdown_message" "$choices" $timeout

case "$input" in
  "" ) : ;; # continue
  [Ee]* ) echo -e "\n🐲 Change your targets here..."; exit;;
  [Qq]* ) echo -e '\n🐲 Farewell...'; exit;;
esac

## now loop through the above array
for target in "${targets[@]}"
do
   if grep -q $target $hostfile; then
   	printf "💀 $target already destroyed\n"
   else
      echo "127.0.0.1 $target" >> $hostfile
      echo "127.0.0.1 www.$target" >> $hostfile
      printf "💥 $target destroyed! 💥\n"
      flush=true
   fi
done

if [ "$flush" = true ]; then
   printf "\n🚽 Flushing DNS cache\n"
   dscacheutil -flushcache
   quip="$(random "changesmade[@]")";
   printf '\n🐉 '"$quip";
else
   quip="$(random "nochanges[@]")";
   printf '\n🐉 '"$quip";
fi
# quip="$(random "tryagain[@]")"; read -n 1 -r -s -p $'\n🐲 '"$quip" resp;



read -n 1 -r -s -p $'\n🐲 Press enter to quit, r to resurrect all distractions.\n' resp
case "$resp" in
[Rr]* )
   for target in "${targets[@]}"
   do
      sed -i '' "/$target/d" $hostfile
   done
   msg="🌱 All distractions resurrected 🌱\n";;
 * )
   msg="🐲 Stay focused, hero...\n";;
esac

printf "\n$msg\n"