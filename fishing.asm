INCLUDE Irvine32.inc
main EQU start@0

.data
    startMsg  BYTE "Press Space to start...", 0
    beginMsg  BYTE "Fishing Game Start", 0

.code
main PROC
    WaitForSpace:
        call Clrscr
        mov edx, OFFSET startMsg
        call WriteString

    CheckKey:
        call ReadKey         ; AL = char, AH = scanner
        cmp al, ' '          ; is == space
        jne CheckKey         ; != -> keep waiting

    GameStart:
        call Clrscr
        mov edx, OFFSET beginMsg
        call WriteString

        ; FishGame PROC
        ; call FishGame
        call WaitMsg
        call Clrscr
        exit
main ENDP
END main
