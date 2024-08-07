#NoEnv
#Persistent
#SingleInstance Force

#InstallKeybdHook
#UseHook

SendMode Input
SetKeyDelay 0

; https://w.atwiki.jp/eamat/pages/17.html
IME_SET(SetSts, WinTitle="A")    {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")  ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283 ;Message : WM_IME_CONTROL
          ,  Int, 0x006  ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}

GroupAdd, Terminal, ahk_class org.wezfurlong.wezterm        ; wezterm
GroupAdd, Terminal, ahk_class CASCADIA_HOSTING_WINDOW_CLASS ; windows terminal

LWin::F13
RWin::F14


LWin & c::Send ^{c}
LWin & v::Send ^{v}

LWin & a::Send ^{a}
LWin & f::Send ^{f}

^[::ESCAPE_AND_IME_OFF()
Esc::ESCAPE_AND_IME_OFF()


ESCAPE_AND_IME_OFF(){
    IME_SET(0)
    Send {Esc}
}

LWin::IME_SET(0)
RWin::IME_SET(1)

#IfWinActive ahk_exe WindowsTerminal.exe
LWin & v::Send ^+{v}

#IfWinActive ahk_exe wezterm-gui.exe
LWin & v::Send ^+{v}
LWin & c::Send ^+{c}

#IfWinActive ahk_group Terminal
Alt & Backspace::Send {Del}

#IfWinNotActive ahk_group Terminal
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

#IfWinActive
