INCLUDE Irvine32.inc
main EQU start@0

.data
    startMsg  BYTE "Press Space to start...", 0
    beginMsg  BYTE "Fishing Game Start", 0

    lakeSiz   DWORD 50

    hookSiz   DWORD 3       ; 3 <= hookSiz <= lakeSiz
    hookPos   SDWORD 0       ; 0 <= hookPos <= lakeSiz - hookSiz
    velocity  SDWORD 0      ; hook's velocity
    gravity   SDWORD -1     ; + <gravity> per tick
    jumpForce SDWORD 2      ; + <jumpForce> per tick if space is pressed

.code
main PROC
    WaitForSpace:
        call Clrscr
        mov edx, OFFSET startMsg
        call WriteString

    WaitKey:
        call ReadKey
        cmp al, ' '
        jne WaitKey

        call Clrscr
        mov edx, OFFSET beginMsg
        call WriteString

        mov eax, 100
        call Delay

    FishingGame:
        call Clrscr
        mov eax, hookPos
        call WriteInt

        mov eax, hookPos
        add eax, gravity
        mov hookPos, eax
        call ReadKey
        .IF al == ' '
            mov eax, hookPos
            add eax, jumpForce
            mov hookPos, eax
        .ENDIF

        mov eax, lakeSiz
        sub eax, hookSiz
        .IF hookPos < 0
            mov hookPos, 0
        .ELSEIF hookPos > eax
            mov hookPos, eax
        .ENDIF

        mov eax, 100
        call Delay
        jmp FishingGame
    exit
main ENDP
END main
