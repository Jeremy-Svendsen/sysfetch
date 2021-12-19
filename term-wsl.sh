wslproc=$(tasklist.exe &>/dev/null | grep wsl.exe | awk '{print $2}' | head -1)
ppid=$(wmic.exe &>/dev/null process where "(processid=$wslproc)" get parentprocessid)
ppid=$(echo $ppid | sed 's/[a-zA-Z]//g')
term=$(wmic.exe &>/dev/null process where "(processid=$ppid)" get name)
echo -ne "${GREEN}term${NC} ~ "
echo -ne $term | sed 's/.exe//'

