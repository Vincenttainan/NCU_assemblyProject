INCLUDE Irvine32.inc
main EQU start@0

MyRandomRange PROTO,
    maxNum: DWORD

.data
    startMsg    BYTE "Press Space to start...", 0
    beginMsg    BYTE "Fishing Game Start", 0
    successMsg  BYTE "Fishing Success!!!", 0
    failMsg     BYTE "Fishing Failed !!!", 0
    frame       BYTE "+--------------------------------------------------+", 0
    fishGameTitle   BYTE    "  ___ _    _    _              ___                ", 0Dh, 0Ah,
                            " | __(_)__| |_ (_)_ _  __ _   / __|__ _ _ __  ___ ", 0Dh, 0Ah,
                            " | _|| (_-< ' \| | ' \/ _` | | (_ / _` | '  \/ -_)", 0Dh, 0Ah,
                            " |_| |_/__/_||_|_|_||_\__, |  \___\__,_|_|_|_\___|", 0Dh, 0Ah,
                            "                      |___/                       ", 0
    unStartFishing  BYTE    "    +----------------------------------------+", 0Dh, 0Ah,
                            "    | .-..-..-..-..-.  .-..-..-.. ..-.. ..-. |", 0Dh, 0Ah,
                            "    | `-. | |-||(  |   |-  | `-.|-| | |\||.. |", 0Dh, 0Ah,
                            "    | `-' ' ' '' ' '   '  `-'`-'' ``-'' ``-' |", 0Dh, 0Ah,
                            "    +----------------------------------------+", 0
    slStartFishing  BYTE    "    #========================================#", 0Dh, 0Ah,
                            "    H .-..-..-..-..-.  .-..-..-.. ..-.. ..-. H", 0Dh, 0Ah,
                            "    H `-. | |-||(  |   |-  | `-.|-| | |\||.. H", 0Dh, 0Ah,
                            "    H `-' ' ' '' ' '   '  `-'`-'' ``-'' ``-' H", 0Dh, 0Ah,
                            "    #========================================#", 0
    unFishGuide     BYTE    "    +----------------------------------------+", 0Dh, 0Ah,
                            "    |     .-..-..-.. .  .-.. ..-..-. .-.     |", 0Dh, 0Ah,
                            "    |     |-  | `-.|-|  |..| | | |  )|-      |", 0Dh, 0Ah,
                            "    |     '  `-'`-'' `  `-'`-'`-'`-' `-'     |", 0Dh, 0Ah,
                            "    +----------------------------------------+", 0
    slFishGuide     BYTE    "    #========================================#", 0Dh, 0Ah,
                            "    H     .-..-..-.. .  .-.. ..-..-. .-.     H", 0Dh, 0Ah,
                            "    H     |-  | `-.|-|  |..| | | |  )|-      H", 0Dh, 0Ah,
                            "    H     '  `-'`-'' `  `-'`-'`-'`-' `-'     H", 0Dh, 0Ah,
                            "    #========================================#", 0
    ; for random
    randSeed DWORD ?

    ; for lake
    lakeSiz   DWORD 50

    ; for hook
    hookSiz   DWORD 5       ; 5 <= hookSiz <= lakeSiz
    hookPos   SDWORD 0      ; 0 <= hookPos <= lakeSiz - hookSiz
    velocity  SDWORD 0      ; hook's velocity
    gravity   SDWORD -1     ; + <gravity> per tick
    jumpForce SDWORD 2      ; + <jumpForce> per tick if space is pressed

    ; for fish
    fishPos     SDWORD 1      ; 1 <= hookPos <= lakeSiz - 1
    fishDir     SDWORD 1      ; -1, 0, 1 -> down, stop, up
    difficulty   DWORD 5      ; move every <difficulty> tick
    fishCooldown DWORD 0      ; count steps

    ; for process
    process   DWORD 10      ; 0 -> fial, 100 -> success

    ; for selecting bar
    selecting DWORD 1

.code
main PROC
    ; set randSeed with time
    call    GetTickCount
    mov     randSeed, eax
    
    SetUp:
        mov     hookPos, 0
        mov     fishPos, 1
        mov     fishCooldown, 0
        mov     process, 10
        mov     selecting, 1

    WaitForSpace:
        call Clrscr
        mov edx, OFFSET fishGameTitle
        call WriteString
        call crlf
        call crlf
        .IF selecting == 1
            mov edx, OFFSET slStartFishing
            call WriteString
            call crlf
        .ELSE
            mov edx, OFFSET unStartFishing
            call WriteString
            call crlf
        .ENDIF
        .IF selecting == 2
            mov edx, OFFSET slFishGuide
            call WriteString
            call crlf
        .ELSE
            mov edx, OFFSET unFishGuide
            call WriteString
            call crlf
        .ENDIF

    WaitKey:
        call ReadKey
        cmp al, 'w'
        je PressW
        cmp al, 's'
        je PressS
        cmp al, ' '
        je PressedSpace

        mov eax, 100
        call Delay
        jmp WaitForSpace

        PressW:
            mov eax, selecting
            dec eax
            .IF eax < 1
                mov eax, 1
            .ENDIF
            mov selecting, eax
            mov eax, 100
            call Delay
            jmp WaitForSpace
        
        PressS:
            mov eax, selecting
            inc eax
            .IF eax > 2
                mov eax, 2
            .ENDIF
            mov selecting, eax
            mov eax, 100
            call Delay
            jmp WaitForSpace
    
    PressedSpace:
        .IF selecting == 1
            jmp FishingGame
        .ELSE
            ; need to be replace by fish guide !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            jmp WaitForSpace
        .ENDIF

    FishingGame:
        Output:
            call Clrscr
            UpperFrame:
            ; 1st    +----------+
                mov edx, OFFSET frame
                call WriteString
                call crlf

            ProcessBar:
            ;  proc: |###       |
                mov al, '|'
                call WriteChar

                DoneLeftProcessBar:
                    mov ecx, process
                    shr ecx, 1
                    mov al, '#'
                LoopProcess:
                    cmp ecx, 0
                    jle DoneProcess

                    call WriteChar
                    dec ecx
                    jmp LoopProcess
                
                DoneProcess:
                    mov ecx, 50
                    mov ebx, process
                    shr ebx, 1
                    sub ecx, ebx
                    mov al, ' '
                LoopUnprocess:
                    cmp ecx, 0
                    jle DoneUnprocess
                    
                    call WriteChar
                    dec ecx
                    jmp LoopUnprocess

                DoneUnprocess:
                    mov al, '|'
                    call WriteChar
                    call crlf

            MidFrame:
            ; 2nd    +----------+
                mov edx, OFFSET frame
                call WriteString
                call crlf
            
            UpperHook:
            ; 1st    | +-+      |
                mov al, '|'
                call WriteChar
            
                DoneUpperLeftHookBar:
                    mov ecx, hookPos
                    mov al, ' '

                UpperLeftHook:
                    cmp ecx, 0
                    jle DoneUpperLeftHook

                    call WriteChar
                    dec ecx
                    jmp UpperLeftHook
                
                DoneUpperLeftHook:
                    mov al, '+'
                    call WriteChar

                    mov ecx, hookSiz
                    sub ecx, 2
                    mov al, '-'

                UpperLoopHook:
                    cmp ecx, 0
                    jle DoneUpperLoopHook

                    call WriteChar
                    dec ecx
                    jmp UpperLoopHook

                DoneUpperLoopHook:
                    mov al, '+'
                    call WriteChar
                    
                    mov ecx, lakeSiz
                    sub ecx, hookPos
                    sub ecx, hookSiz
                    mov al, ' '

                UpperRightHook:
                    cmp ecx, 0
                    jle DoneUpperRightHook

                    call WriteChar
                    dec ecx
                    jmp UpperRightHook

                DoneUpperRightHook:
                    mov al, '|'
                    call WriteChar
                    call crlf

            Fish:
            ;        | [F]      |
                mov al, '|'
                call WriteChar
                
                mov ecx, fishPos
                sub ecx, 2
                mov al, ' '

                LoopFishLeft:
                    cmp ecx, 0
                    jle DoneLoopFishLeft

                    call WriteChar
                    dec ecx
                    jmp LoopFishLeft

                DoneLoopFishLeft:
                    mov al, '['
                    call WriteChar
                    mov al, 'F'
                    call WriteChar
                    mov al, ']'
                    call WriteChar

                    mov ecx, lakeSiz
                    sub ecx, fishPos
                    dec ecx
                    mov al, ' '

                LoopFishRight:
                    cmp ecx, 0
                    jle DoneLoopFishRight

                    call WriteChar
                    dec ecx
                    jmp LoopFishRight

                DoneLoopFishRight:
                    mov al, '|'
                    call WriteChar
                    call crlf

            LowerHook:
            ; 2nd    | +-+      |
                mov al, '|'
                call WriteChar
            
                DoneLowerLeftHookBar:
                    mov ecx, hookPos
                    mov al, ' '

                LowerLeftHook:
                    cmp ecx, 0
                    jle DoneLowerLeftHook

                    call WriteChar
                    dec ecx
                    jmp LowerLeftHook
                
                DoneLowerLeftHook:
                    mov al, '+'
                    call WriteChar

                    mov ecx, hookSiz
                    sub ecx, 2
                    mov al, '-'

                LowerLoopHook:
                    cmp ecx, 0
                    jle DoneLowerLoopHook

                    call WriteChar
                    dec ecx
                    jmp LowerLoopHook

                DoneLowerLoopHook:
                    mov al, '+'
                    call WriteChar
                    
                    mov ecx, lakeSiz
                    sub ecx, hookPos
                    sub ecx, hookSiz
                    mov al, ' '

                LowerRightHook:
                    cmp ecx, 0
                    jle DoneLowerRightHook

                    call WriteChar
                    dec ecx
                    jmp LowerRightHook

                DoneLowerRightHook:
                    mov al, '|'
                    call WriteChar
                    call crlf

            BotFrame:
            ; 3rd    +----------+
                mov edx, OFFSET frame
                call WriteString
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

        FishCaculate:
            .IF fishCooldown == 0
                mov eax, difficulty
                mov fishCooldown, eax
            .ELSE
                jmp SkipFishMove
            .ENDIF

            INVOKE MyRandomRange, lakeSiz
            .IF eax < fishPos
                mov fishDir, -1
            .ELSEIF eax == fishPos
                mov fishDir, 0
            .ELSE
                mov fishDir, 1
            .ENDIF

            mov eax, fishPos
            add eax, fishDir
            mov fishPos, eax

            mov eax, lakeSiz
            dec eax
            .IF fishPos < 1
                mov fishPos, 1
            .ELSEIF fishPos > eax
                mov fishPos, eax
            .ENDIF
            SkipFishMove:
                dec fishCooldown
            
        ProcessCaculate:
            mov eax, hookPos
            mov ebx, hookPos
            add ebx, hookSiz

            .IF eax <= fishPos
                .IF fishPos <= ebx
                    mov ecx, process
                    inc ecx
                    mov process, ecx
                .ELSE
                    mov ecx, process
                    dec ecx
                    mov process, ecx
                .ENDIF
            .ELSE
                mov ecx, process
                dec ecx
                mov process, ecx
            .ENDIF

            .IF process == 100
                call Clrscr
                mov edx, OFFSET successMsg
                call WriteString
                mov eax, 1000
                call Delay
                jmp SetUp
            .ELSEIF process == 0
                call Clrscr
                mov edx, OFFSET failMsg
                call WriteString
                mov eax, 1000
                call Delay
                jmp SetUp
            .ENDIF

        ; delay
        mov eax, 100
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
