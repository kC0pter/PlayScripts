SetTimer Click, 650

F2::Toggle := !Toggle

Click:
    If (!Toggle)
        Return
    Send q
    Send w
    Send e
    Send r
return

^LButton::
while (GetKeyState("LButton", "P"))
{
        SendInput {Blind}{LButton}
        Sleep 25
}
return

~t::
    If(!Toggle)
       return
    Send {F2}
return

~m::
    If(!Toggle)
        return
    Send {F2}
return

~Enter::
    If(!Toggle)
        return
    Send {F2}
return