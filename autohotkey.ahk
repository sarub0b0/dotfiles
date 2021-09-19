#NoEnv
#Persistent
#SingleInstance Force

#InstallKeybdHook
#UseHook

SendMode Input
SetKeyDelay 0

LWin::F13
RWin::F14


LWin & c::Send ^{c}
LWin & v::Send ^{v}

LWin & a::Send ^{a}


#IfWinActive ahk_exe WindowsTerminal.exe
LWin & v::Send ^+{v}


#IfWinNotActive ahk_exe WindowsTerminal.exe
^h::Send {Backspace}

^p::Send {Up}
^n::Send {Down}

^f::Send {Right}
^+f::Send +{Right}

^b::Send {Left}
^+b::Send +{Left}

^k::Send {Shift down}{END}{Shift up}{Backspace}

^a::Send {Home}
^+a::Send +{Home}

^e::Send {End}
^+e::Send +{End}
