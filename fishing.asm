INCLUDE Irvine32.inc
main EQU start@0

MyRandomRange PROTO,
    maxNum: DWORD

.data
    startMsg  BYTE "Press Space to start...", 0
    beginMsg  BYTE "Fishing Game Start", 0

    randSeed DWORD ?

    lakeSiz   DWORD 50

    hookSiz   DWORD 3       ; 3 <= hookSiz <= lakeSiz
    hookPos   SDWORD 0       ; 0 <= hookPos <= lakeSiz - hookSiz
    velocity  SDWORD 0      ; hook's velocity
    gravity   SDWORD -1     ; + <gravity> per tick
    jumpForce SDWORD 2      ; + <jumpForce> per tick if space is pressed

.code
main PROC
    SetUp:
        ; set randSeed with time
        call    GetTickCount
        mov     randSeed, eax

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
        ; output for debug
        call Clrscr
        mov eax, hookPos
        call WriteInt
        call crlf

        HookCaculate:
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

        ; delay
        mov eax, 1000
        call Delay
        
        jmp FishingGame
    exit
main ENDP

; ---------------------------------------------------------
; MyRandomRange
; generate a number between 0 and maxNum
; return：EAX = random number
; need：defined randSeed in .data
; ---------------------------------------------------------
MyRandomRange PROC USES ebx ecx edx,
    maxNum: DWORD

    mov eax, maxNum
    cmp eax, 0
    je _return_zero

    mov eax, randSeed
    
    imul eax, eax, 1664525
    add eax, 1013904223
    
    mov randSeed, eax

    mov edx, 0
    mov ecx, maxNum
    inc ecx
    div ecx
    mov eax, edx

    ret

    _return_zero:
        xor eax, eax
        ret

MyRandomRange ENDP


END main
