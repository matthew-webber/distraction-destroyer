#!/bin/bash

# ohm
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

# just for fun
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

# set sed/flush/hosts syntax (Linux v macOS)
hostsfile='/etc/hosts'

case $OSTYPE in
"linux"*)
   case $(uname -a) in
   *[Mm]"icrosoft"*)
      hostsfile="/mnt/c/Windows/System32/drivers${hostsfile}"
      flush_command="cmd.exe /c \"ipconfig /flushdns>nul\"" # silent DNS flush
      ;;
   esac
   sed_syntax='sed -i'
   flush_command='systemd-resolve --flush-caches'
   ;;
"darwin"*)
   sed_syntax='sed -i ""'
   flush_command='dscacheutil -flushcache'
   ;;
esac

# prompt variables
countdown=7
countdown_message="🐲 Destruction shall commence in"
choices='['"$bold"''"$underline"'e'"$normal"'dit/'"$bold"''"$underline"'r'"$normal"'esurrect/'"$bold"''"$underline"'q'"$normal"'uit]'

# response variables
declare -a tryagain=("Pardon?" "I don't understand..." "What?" "Umm..." "I don't have all day...")
declare -a nochanges=("I found nothing but the ghosts of your enemies" "You woke me up for this?" "Apparently they all died of fright")
declare -a changesmade=("Destruction completed" "Those distractions won't be bothering you anymore..." "The enemies of focus have been dispatched" "That was too easy..." "Are you not entertained?!")
declare -a resurrect=("Well you can kiss your focus goodbye!" "Grr...<insert dissuasive cliché here>" "As you wish... weakling...")

# other important variables
this_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)" # for accurate rel. paths
targetsfile="$this_dir"/targets.txt
targets=($(cat "$targetsfile")) # get the target domains from the domains file and put into array
flush=false                     # do not change! flag for script logic on flushing DNS

# for randomizing Destroyer speech
random() {
   local arr=("${!1}")
   echo -e "${arr[$RANDOM % ${#arr[@]}]}"
}

# remove targets from the hosts file
unblock_targets() {
   local arr=("${!1}")
   for target in "${arr[@]}"; do
      $sed_syntax "/$target/d" $hostsfile
   done
   printf "\n🌱 All distractions resurrected 🌱\n"
}

# fn for prompt variables
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
         [Qq]*) # quit
            input="q"
            exitnow=true
            ;;
         [Ee]*) # edit
            input="e"
            exitnow=true
            ;;
         [Rr]*) # resurrect
            input="r"
            exitnow=true
            ;;
         "") # continue
            input=""
            exitnow=true
            ;;
         *) : ;;
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
         printf "${cursorDirectives}${prompt} 0 or ${choices}${x}" # display clean final countdown msg
         break
      fi
   done

}

# startup prompt
printf "\n\n🐲 Know thy enemies and I shall destroy them\n"
echo -e "\n${underline}Targets${normaltput}"
for target in "${targets[@]}"; do
   printf "🎯 $target\n" # list targets
done

printf "\n" # formatting bc i r noob

opening_prompt "$countdown_message" "$choices" $countdown

case "$input" in
"") echo -e "\n" ;; # formatting bc i r noob
[Ee]*)
   # user wanna edit
   echo -e "\n🐲 We'll start again when my objectives are clear..."
   sleep 2
   nano $targetsfile # edit the targets
   echo -e "\n🐲 Let's try that again, shall we?"
   sleep 2
   printf "\e[1J"
   $0 # start the script over again
   exit
   ;;
[Rr]*)
   # distractions come alive
   quip="$(random "resurrect[@]")"
   printf '\n🐲 '"$quip"
   sleep 2
   unblock_targets targets[@]
   sleep 1
   exit
   ;;
[Qq]*)
   # bump this
   echo -e '\n🐲 Farewell...'
   sleep 1
   exit
   ;;
esac

# add comment separator if not already in /etc/hosts
cat /etc/hosts | grep -q "# distraction-destroyer graveyard"
case $? in
0*) : ;;
1*) echo "# distraction-destroyer graveyard (do not remove)" >>/etc/hosts ;;
esac

# /RE/{G;s/$/This line is new/;}

# add domains to hosts file
for target in "${targets[@]}"; do
   if grep -q $target $hostsfile; then
      printf "💀 $target already destroyed\n"
   else
      $sed_syntax "/# distraction-destroyer graveyard/{G;s/$/127.0.0.1 $target/;}" $hostsfile
      $sed_syntax "/# distraction-destroyer graveyard/{G;s/$/127.0.0.1 www.$target/;}" $hostsfile
      printf "💥 $target destroyed!\n"
      flush=true
   fi
done

# flush DNS so stored IPs of distractions get gone
if [ "$flush" = true ]; then
   printf "\n🚽 Flushing DNS cache\n"
   $flush_command
   quip="$(random "changesmade[@]")"
   printf '\n🐉 '"$quip"
else
   quip="$(random "nochanges[@]")"
   printf '\n🐉 '"$quip"
fi

# well wishes for your productivity
printf "\n🐲 Stay focused, hero...\n"
sleep 1
