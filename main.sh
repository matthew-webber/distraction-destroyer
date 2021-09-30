#!/bin/bash

ascii_banner() {
   printf "$@"
}

# format variables
redc='\e[0;31m'
greenc='\e[1;32m'
bluec='\e[1;34m'
normal='\e[0m'
bold=$(tput bold)
underline=$(tput smul)
normaltput=$(tput sgr0)

error() {
   printf "$redc$@$normal\n"
}

# sudo check
if [ "$EUID" -ne 0 ]; then
   error "You must run Distraction Destroyer as root.  Quitting..."
   exit
fi

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
      \`\"Y8888P\"\"'  ${normal}ASCII: warp.tmt.1997${bluec}
         \`\"\"'      ${normal}https://github.com/matthew-webber/distraction-destroyer
"

# prompt variables
countdown=7
countdown_message="🐲 Destruction shall commence in"
choices='['"$bold"''"$underline"'e'"$normal"'dit/'"$bold"''"$underline"'r'"$normal"'esurrect/'"$bold"''"$underline"'q'"$normal"'uit]'

# response variables
declare -a tryagain=("Pardon?" "I don't understand..." "What?" "Umm..." "I don't have all day...")
declare -a nochanges=("I found nothing but the ghosts of your enemies" "You woke me up for this?" "Apparently they all died of fright")
declare -a changesmade=("Destruction completed" "Those distractions won't be bothering you anymore..." "The enemies of focus have been dispatched" "That was too easy..." "Are you not entertained?!")
declare -a resurrect=("Well you can kiss your focus goodbye!" "Grr...<insert dissuasive cliché here>" "As you wish... weakling...")
hostfile=/etc/hosts

# get the target domains from the domains file and put into array
targets=($(cat targets.txt))

# flag for script logic on flushing DNS
# do not change!
flush=false

random() {
   local arr=("${!1}")
   echo -e "${arr[$RANDOM % ${#arr[@]}]}"
}

unblock_targets() {
   for target in "${targets[@]}"; do
      sed -i '' "/$target/d" $hostfile
   done
   msg="🌱 All distractions resurrected 🌱\n"
}

# pairs w/ prompt variables
opening_prompt() {
   # timed prompt before script begins
   exitnow=false
   local prompt=$1
   local choices=$2
   local countdown=$3
   local x=""
   # countdown starts
   for ((i = $countdown; i >= 0; i--)); do
      # warning message
      case "$i" in
      [4-6]*) printf "\e[K\r${prompt} ${i} or ${choices}${x}\e[K" ;;
      [3]*)
         x="\n🐉 Let the slaying.."
         printf "\e[K\r${prompt} ${i} or ${choices}${x}"
         ;;
      [2]*)
         x+=.
         printf "\e[K\e[A\e[K\r${prompt} ${i} or ${choices}${x}"
         ;;
      [1]*)
         x+=.
         printf "\e[K\e[A\e[K\r${prompt} ${i} or ${choices}${x}"
         ;;
      [0]*)
         x+=" begin!"
         printf "\e[K\e[A\e[K\r${prompt} ${i} or ${choices}${x}"
         ;;
      esac
      read -s -n 1 -t 1 waitresponse
      if [ $? -eq 0 ]; then
         case "$waitresponse" in
         [Qq]*)
            input="q"
            exitnow=true
            ;; # quit
         [Ee]*)
            input="e"
            exitnow=true
            ;; # edit
         [Rr]*)
            input="r"
            exitnow=true
            ;; # resurrect
         "")
            input=""
            exitnow=true
            ;;     # any key
         *) : ;; # continue counting
         esac
      fi
      if [ $exitnow = true ]; then
         case "$i" in
         [4-6]*) cursorDirectives="\e[K\r" ;;
         *)
            cursorDirectives="\e[K\e[A\e[K\r"
            ;;
         esac
         case "$input" in
         "")
            x="\n🐉 Let the slaying... begin!"
            ;;
         *) x="\n🐉 Let the slaying... oops nm!" ;;
         esac
         printf "${cursorDirectives}${prompt} 0 or ${choices}${x}"
         break
      fi
   done

}

# startup prompt
printf "\n\n🐲 Know thy enemies and I shall detroy them\n"
echo -e "\n${underline}Targets${normaltput}"
for target in "${targets[@]}"; do
   printf "🎯 $target\n"
done

printf "\n" # formatting

opening_prompt "$countdown_message" "$choices" $countdown

case "$input" in
"") : ;; # continue
[Ee]*)
   echo -e "\n🐲 We'll start again when my objectives are clear..."
   sleep 2
   nano targets.txt # edit the targets
   echo -e "\n🐲 Let's try that again, shall we?"
   sleep 2
   printf "\e[1J"
   $0 # start the script over again
   exit
   ;;
[Rr]*)
   quip="$(random "resurrect[@]")"
   printf '\n🐲 '"$quip"
   sleep 2
   # unblock_targets
   for target in "${targets[@]}"; do
      sed -i '' "/$target/d" $hostfile
   done
   printf "\n🌱 All distractions resurrected 🌱\n"
   sleep 1
   exit
   ;;
[Qq]*)
   echo -e '\n🐲 Farewell...'
   sleep 1
   exit
   ;;
esac

echo -e "\n" # formatting bc noob

## now loop through the above array
for target in "${targets[@]}"; do
   if grep -q $target $hostfile; then
      printf "💀 $target already destroyed\n"
   else
      echo "127.0.0.1 $target" >>$hostfile
      echo "127.0.0.1 www.$target" >>$hostfile
      printf "💥 $target destroyed! 💥\n"
      flush=true
   fi
done

if [ "$flush" = true ]; then
   printf "\n🚽 Flushing DNS cache\n"
   dscacheutil -flushcache
   quip="$(random "changesmade[@]")"
   printf '\n🐉 '"$quip"
else
   quip="$(random "nochanges[@]")"
   printf '\n🐉 '"$quip"
fi

printf "\n🐲 Stay focused, hero...\n"
sleep 1
