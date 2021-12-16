#!/usr/bin/env bash

# Asset's
export ASCIILINES=( '━' '│' '╰' '╯' '├' '┤' '╭' '╮' )

shopt -s checkwinsize # Fetch Console-Data #
    (
        :
        :
    )
export ConsoleX=${COLUMNS}
export ConsoleY=${LINES}
export Y="${LINES}"
export X="${COLUMNS}"
export TitleLine=2
ChooseRandom() {
    if [[ -z "${1}" ]]; then
        echo -e "[\e[1m\e[7m${FUNCNAME[0]}\e[m]:\e[5m\e[41mError\e[m\e[1m Line:(\e[4m${BASH_LINENO[0]}\e[m\e[1m) Missing value\e[m"
    else
        local arr=("$@")
        printf '%s\n' "${arr[RANDOM % $#]}"
    fi
}
Window::Draw() {

    for ((a = 0; a <= ConsoleY; a++)); do
        echo -ne "\e[${a};${ConsoleX}H${ASCIILINES[1]}"
        echo -ne "\e[${a};0H${ASCIILINES[1]}"
    done # Draw down ConsoleX: Limit to ConsoleY: Max edge down line

    for ((a = 0; a <= ConsoleX; a++)); do
        echo -ne "\e[${ConsoleX};${a}H${ASCIILINES[0]}" # Drawns total down line
        if [[ "${a}" == "${ConsoleX}" ]]; then
            echo -ne "\e[${ConsoleX};${a}H${ASCIILINES[3]}" # Draws Left face border
            echo -ne "\e[${ConsoleX};0H${ASCIILINES[2]}"    # Draws Right face border
        fi
    done

    for ((a = 0; a <= ConsoleX; a++)); do
        echo -ne "\e[3;${a}H${ASCIILINES[0]}" # MAIN
    done                                      # Draw straight ConsoleX cord in line 3

    echo -ne "\e[3;0H${ASCIILINES[4]}"    # Draws Index[4] at line 3
    echo -ne "\e[3;${ConsoleX}H${ASCIILINES[5]}" # Draws Index[5] at line 3

    for ((a = 0; a <= ConsoleX; a++)); do
        echo -ne "\e[0;${a}H${ASCIILINES[0]}"
        if [[ "${a}" == "${ConsoleX}" ]]; then
            echo -ne "\e[0;0H${ASCIILINES[6]}"
            echo -ne "\e[0;${ConsoleX}H${ASCIILINES[7]}"
        fi
    done # Draw straight ConsoleX cord in line 0
    printf "\n\n\n"
}

Window::SetTitle(){
    local Title="${1}"
    local TitleCord="$(( ConsoleX / 2 - $(( ${#Title} / 2 )) ))"
    echo -ne "\e[${TitleLine};${TitleCord}H${Title}"
}
Window::Write(){
    local LocationY="$(( ${1} + 4 ))"
    local LocationX="$(( ${2} + 2 ))"
    local Text="${3}"
    echo -ne "\e[${LocationY};${LocationX}H${Text}"
}
Window::WriteRaw(){
    echo -ne "\e[${1};${2}H${3}"
}
Window::WipeScreen(){
    printf "\e[2J\e[f"
}
Window::WipeLine(){
    printf "\e[2K"
}
System::Pause(){
    read -rt "${1}" <> <(:) || :
}
