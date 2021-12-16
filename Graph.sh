#!/usr/bin/env bash
source UI.sh
# ┼
# ◄
# ►
# ▼
# ▲
# ─
# │
# ┌
# └
# ┘
# ┐
export ASCIILINES=(
     '─'
     '│'
     '╰'
     '╯'
     '├'
     '┤'
     '╭'
     '╮'
     '◄'
     '►'
     '▼'
     '▲'
)
Window::WipeScreen
Window::Draw
Window::SetTitle "Graph"
Window::Write 1 1 "Hello World"
