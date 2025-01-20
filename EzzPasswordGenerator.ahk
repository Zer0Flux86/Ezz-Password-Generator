
#SingleInstance Force
#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
Menu, Tray, Icon, %A_ScriptDir%\source\icon.ico

Gui Font, s9, Segoe UI
Gui Add, Button, x8 y184 w90 h29 vGenerate gGenerate, Generate
Gui Add, Text, x0 y0 w120 h23 +0x200, by dormant1337
Gui Add, Text, x112 y0 w120 h23 +0x200 vGitText gGitButton, github repository
Gui Font
Gui Font, s9
Gui Add, CheckBox, x200 y136 w131 h33 vAllowSpecialSymbols, Allow Special Symbols
Gui Font
Gui Font, s9, Segoe UI
Gui Font
Gui Font, s9
Gui Add, CheckBox, x200 y88 w134 h33 vAllowLetters, Allow Letters
Gui Font
Gui Font, s9, Segoe UI
Gui Font
Gui Font, s9
Gui Add, CheckBox, x200 y40 w131 h33 vAllowNumbers, Allow Numbers
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Text, x192 y32 w146 h141 +0x10
Gui Add, Text, x208 y21 w37 h21 +0x200, Allows
Gui Add, Text, x192 y170 w146 h2 +0x10
Gui Add, Text, x336 y32 w2 h140 +0x10
Gui Font
Gui Font, s12, Segoe UI
Gui Add, Text, x8 y32 w69 h23 +0x200, Length:
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Edit, x64 y32 w114 h26 vLength
Gui Add, Button, x104 y184 w90 h29 vCopyOutput gCopyOutput, Copy Output
Gui Add, Edit, x8 y64 w169 h113 vOutput +ReadOnly

Gui Show, w357 h220, Password Generator v1.0 by Dormant1337
Return

GitButton:
Run, https://github.com/Zer0Flux86/Ezz-Password-Generator
Return

Generate:
    password := ""
    GuiControlGet, Length,, Length
    if (Length != "") {
        GuiControlGet, AllowNumbers,, AllowNumbers
        GuiControlGet, AllowLetters,, AllowLetters
        GuiControlGet, AllowSpecialSymbols,, AllowSpecialSymbols
        
        if (AllowNumbers && !AllowLetters && !AllowSpecialSymbols) {
            Loop, %Length% {
                Random, rand, 0, 9
                password := password . rand
            }
        } else if(!AllowNumbers && AllowLetters && !AllowSpecialSymbols) {
            Loop, %Length% {
                password := password . RandomLetter()
            }
        } else if(!AllowNumbers && !AllowLetters && AllowSpecialSymbols) {
            Loop, %Length% {
                password := password . RandomSpecialSymbol()
            }
        } else if(AllowNumbers && AllowLetters && !AllowSpecialSymbols) {
            Loop, %Length% {
                Random, rand, 0, 1
                if(rand) {
                    password := password . RandomLetter()
                } else {
                    Random, rand, 0, 9
                    password := password . rand
                }
            }
        } else if(AllowNumbers && !AllowLetters && AllowSpecialSymbols) {
            Loop, %Length% {
                Random, rand, 0, 1
                if(rand) {
                    Random, rand, 0, 9
                    password := password . rand
                } else {
                    password := password . RandomSpecialSymbol()
                }
            }
        } else if(!AllowNumbers && AllowLetters && AllowSpecialSymbols) {
            Loop, %Length% {
                Random, rand, 0, 1
                if(rand) {
                    password := password . RandomLetter()
                } else {
                    password := password . RandomSpecialSymbol()
                }
            }
        } else if(AllowNumbers && AllowLetters && AllowSpecialSymbols) {
            Loop, %length% {
                Random, rand, 0, 2
                if(rand = 0) {
                    password := password . RandomLetter()
                } else if(rand = 1) {
                    Random, rand, 0, 9
                    password := password . rand
                } else {
                    password := password . RandomSpecialSymbol()
                }
            }
        }
        GuiControl,, Output, %password%
    } else {
        GuiControl,, Output, Please enter a length.
    }
return

CopyOutput:
    Clipboard := password
return

RandomLetter() {
    letters := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    Random, randIndex, 1, % StrLen(letters)
    return SubStr(letters, randIndex, 1)
}

RandomSpecialSymbol() {
    specialSymbols := "!@#$%^&*()_+-=[]{}|;:,.<>?`~"
    Random, randIndex, 1, % StrLen(specialSymbols)
    return SubStr(specialSymbols, randIndex, 1)
}

GuiEscape:
GuiClose:
    ExitApp