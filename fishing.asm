INCLUDE Irvine32.inc
main EQU start@0

MyRandomRange PROTO,
    maxNum: DWORD

.data
    startMsg        BYTE    "Press Space to select.        Press w/s to up/down", 0
    guideMsg        BYTE    "Press Space to exit.        Press a/d to turn page", 0
    successFailMsg  BYTE    "                Press Space to exit", 0
    frame           BYTE    "+--------------------------------------------------+", 0
    fishGameTitle   BYTE    "  ___ _    _    _              ___                ", 0Dh, 0Ah,
                            " | __(_)__| |_ (_)_ _  __ _   / __|__ _ _ __  ___ ", 0Dh, 0Ah,
                            " | _|| (_-< ' \| | ' \/ _` | | (_ / _` | '  \/ -_)", 0Dh, 0Ah,
                            " |_| |_/__/_||_|_|_||_\__, |  \___\__,_|_|_|_\___|", 0Dh, 0Ah,
                            "                      |___/                       ", 0
    fishGuideUnk1   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|       _   _      _                             |", 0Dh, 0Ah,
                            "|      | | | |_ _ | |___ _  _____ __ ___ _       |", 0Dh, 0Ah,
                            "|      | |_| | ' \| / / ' \/ _ \ V  V / ' \      |", 0Dh, 0Ah,
                            "|       \___/|_||_|_\_\_||_\___/\_/\_/|_||_|     |", 0Dh, 0Ah
    fishGuideUnk2   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "| _____           _                 _      _     |", 0Dh, 0Ah,
                            "||_   _| _ _  _  | |_ ___   __ __ _| |_ __| |_   |", 0Dh, 0Ah,
                            "|  | || '_| || | |  _/ _ \ / _/ _` |  _/ _| ' \  |", 0Dh, 0Ah,
                            "|  |_||_|  \_, |  \__\___/ \__\__,_|\__\__|_||_| |", 0Dh, 0Ah
    fishGuideUnk3   BYTE    "|          |__/                                  |", 0Dh, 0Ah,
                            "|                                                |", 0Dh, 0Ah,
                            "|           _   _           __ _    _            |", 0Dh, 0Ah,
                            "|          | |_| |_  ___   / _(_)__| |_          |", 0Dh, 0Ah,
                            "|          |  _| ' \/ -_) |  _| (_-< ' \         |", 0Dh, 0Ah
    fishGuideUnk4   BYTE    "|           \__|_||_\___| |_| |_/__/_||_|        |", 0Dh, 0Ah,
                            "|                                                |", 0Dh, 0Ah,
                            "|           __ _        _     _   _   _          |", 0Dh, 0Ah,
                            "|          / _(_)_ _ __| |_  | | | | | |         |", 0Dh, 0Ah,
                            "|         |  _| | '_(_-<  _| |_| |_| |_|         |", 0Dh, 0Ah
    fishGuideUnk5   BYTE    "|         |_| |_|_| /__/\__| (_) (_) (_)         |", 0Dh, 0Ah,
                            "|                                                |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0Dh, 0Ah,
                            "|   __    |An  unknown  fish  lived  in|    __   |", 0Dh, 0Ah,
                            "|  / /__  |an unknown place. Feefing on|  __\ \  |", 0Dh, 0Ah
    fishGuideUnk6   BYTE    "| < <___| |unknown things. Can catch it| |___> > |", 0Dh, 0Ah,
                            "|  \_\    |by  using  an  unknown  way.|    /_/  |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0
    fishGuideCat1   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|            ___      _    __ _    _             |", 0Dh, 0Ah,
                            "|           / __|__ _| |_ / _(_)__| |_           |", 0Dh, 0Ah,
                            "|          | (__/ _` |  _|  _| (_-< ' \          |", 0Dh, 0Ah,
                            "|           \___\__,_|\__|_| |_/__/_||_|         |", 0Dh, 0Ah
    fishGuideCat2   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|                            ..                  |", 0Dh, 0Ah,
                            "|                      .%%%%%%%%%%%%%..          |", 0Dh, 0Ah,
                            "|                .%%%%%%%%%%%%%%%%%%%%%%%%..     |", 0Dh, 0Ah,
                            "|              .%%%%%%%%%%%%%%%%%%%%%%%%%%%%.    |", 0Dh, 0Ah
    fishGuideCat3   BYTE    "|             %%%%%%%%%%%%%:          .%%%%%%    |", 0Dh, 0Ah,
                            "|           :%%%%%%%%%%%%%:             .%%%%%.  |", 0Dh, 0Ah,
                            "|         :%%%%%%%%%%%%%%%%              .%%%%%. |", 0Dh, 0Ah,
                            "|         :%%%%%%%%%%%%%%%                .%%%%% |", 0Dh, 0Ah,
                            "|          %%%%%%%%%%%%%%                  :%%%%.|", 0Dh, 0Ah
    fishGuideCat4   BYTE    "| ....     %%%%%%%%%%%%%%   :.             %%%%% |", 0Dh, 0Ah,
                            "|.    ..    %%%%%%%%%%%%   :   ..         %%%%%. |", 0Dh, 0Ah,
                            "|      ..    %%%%%%%%%%   :. ..         .%%%%.   |", 0Dh, 0Ah,
                            "|       ..   .%%%%%%%% ... ..          .%%%%%.   |", 0Dh, 0Ah,
                            "|        .......%%%%    ...           .%%%%.     |", 0Dh, 0Ah
    fishGuideCat5   BYTE    "|    ..     ...     ...               .%%%.      |", 0Dh, 0Ah,
                            "|      ....                            %%        |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0Dh, 0Ah,
                            "|   __    |Catfish   are   medium-sized|    __   |", 0Dh, 0Ah,
                            "|  / /__  |fish  that  dwell  near  the|  __\ \  |", 0Dh, 0Ah
    fishGuideCat6   BYTE    "| < <___| |bottom  of  rivers or lakes,| |___> > |", 0Dh, 0Ah,
                            "|  \_\    |using whiskers to sense prey|    /_/  |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0
    fishGuideSar1   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|          ___              _ _                  |", 0Dh, 0Ah,
                            "|         / __| __ _ _ _ __| (_)_ _  ___         |", 0Dh, 0Ah,
                            "|         \__ \/ _` | '_/ _` | | ' \/ -_)        |", 0Dh, 0Ah,
                            "|         |___/\__,_|_| \__,_|_|_||_\___|        |", 0Dh, 0Ah
    fishGuideSar2   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|               @@@@                             |", 0Dh, 0Ah,
                            "|              @@@@@@@                     +@@@. |", 0Dh, 0Ah,
                            "|..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#..  .@@@@@.    |", 0Dh, 0Ah,
                            "|-.@ ..@.@ .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.       |", 0Dh, 0Ah
    fishGuideSar3   BYTE    "|  @@. ..@                     ..@@@.  @@@.      |", 0Dh, 0Ah,
                            "|     .@@.               .#@@@..         .@@     |", 0Dh, 0Ah,
                            "|         . .@@@@@@@@:                           |", 0Dh, 0Ah,
                            "|               .@@.                             |", 0Dh, 0Ah,
                            "|               @@@@                             |", 0Dh, 0Ah
    fishGuideSar4   BYTE    "|              @@@@@@@                     +@@@. |", 0Dh, 0Ah,
                            "|..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#..  .@@@@@.    |", 0Dh, 0Ah,
                            "|-.@ ..@.@ .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.       |", 0Dh, 0Ah,
                            "|  @@. ..@                     ..@@@.  @@@.      |", 0Dh, 0Ah,
                            "|     .@@.               .#@@@..         .@@     |", 0Dh, 0Ah
    fishGuideSar5   BYTE    "|         . .@@@@@@@@:                           |", 0Dh, 0Ah,
                            "|               .@@.                             |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0Dh, 0Ah,
                            "|   __    |Sardines   are  small   fish|    __   |", 0Dh, 0Ah,
                            "|  / /__  |that  swim  in large schools|  __\ \  |", 0Dh, 0Ah
    fishGuideSar6   BYTE    "| < <___| |silver    bodies    glinting| |___> > |", 0Dh, 0Ah,
                            "|  \_\    |in   the   ocean   sunlight.|    /_/  |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0
    fishGuidePuf1   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|     ___       __  __          __ _    _        |", 0Dh, 0Ah,
                            "|    | _ \_  _ / _|/ _|___ _ _ / _(_)__| |_      |", 0Dh, 0Ah,
                            "|    |  _/ || |  _|  _/ -_) '_|  _| (_-< ' \     |", 0Dh, 0Ah,
                            "|    |_|  \_,_|_| |_| \___|_| |_| |_/__/_||_|    |", 0Dh, 0Ah
    fishGuidePuf2   BYTE    "+------------------------------------------------+", 0Dh, 0Ah,
                            "|                     @@@@@@@@@@@   @@           |", 0Dh, 0Ah,
                            "|                @@@@@@@@@@@@@@@@@@@@@@          |", 0Dh, 0Ah,
                            "|             @@@@@@               @@@@@         |", 0Dh, 0Ah,
                            "|@@@@@@@@@@@@@     @       @@          @@@@@@@   |", 0Dh, 0Ah
    fishGuidePuf3   BYTE    "|@@@   @@@   @@            @@   @@@  @@@@ @@@    |", 0Dh, 0Ah,
                            "|@@@   @@@   @@    @@@     @@   @@@@ @@@@  @@@   |", 0Dh, 0Ah,
                            "|@@@@@@@ @@@           @@                  @@@@@ |", 0Dh, 0Ah,
                            "|@@@      @@@  @@@   @@@@@@@@@             @@@@@ |", 0Dh, 0Ah,
                            "|         @@@   @    @@@  @@@@@@@@@@@@@@@@@@@@@@@|", 0Dh, 0Ah
    fishGuidePuf4   BYTE    "|         @@@        @@@     @@@@@@@@@     @@@   |", 0Dh, 0Ah,
                            "|          @@@@@@@@@@@@@@@@@             @@@@    |", 0Dh, 0Ah,
                            "|        @@@@@@@                       @@@@@@@   |", 0Dh, 0Ah,
                            "|             @@@@                    @@@@       |", 0Dh, 0Ah,
                            "|               @@@@@              @@@@@         |", 0Dh, 0Ah
    fishGuidePuf5   BYTE    "|                @@@@@@@@@@@@@@@@@@@@@@          |", 0Dh, 0Ah,
                            "|                @@@   @@@@@@@@@@   @@@          |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0Dh, 0Ah,
                            "|   __    |Pufferfish are small, unique|    __   |", 0Dh, 0Ah,
                            "|  / /__  |marine  creatures  known for|  __\ \  |", 0Dh, 0Ah
    fishGuidePuf6   BYTE    "| < <___| |their ability to inflate for| |___> > |", 0Dh, 0Ah,
                            "|  \_\    |bright colors signal danger.|    /_/  |", 0Dh, 0Ah,
                            "+---------+----------------------------+---------+", 0
    fishSuccess     BYTE    "    ___                       __      _ _      ", 0Dh, 0Ah,
                            "   / __|_  _ __ __ ___ ______/ _|_  _| | |_  _ ", 0Dh, 0Ah,
                            "   \__ \ || / _/ _/ -_|_-<_-<  _| || | | | || |", 0Dh, 0Ah,
                            "   |___/\_,_\__\__\___/__/__/_|  \_,_|_|_|\_, |", 0Dh, 0Ah,
                            "                                          |__/ ", 0
    fishCaught      BYTE    "    ___ _    _                        _   _   ", 0Dh, 0Ah,
                            "   | __(_)__| |_    __ __ _ _  _ __ _| |_| |_ ", 0Dh, 0Ah,
                            "   | _|| (_-< ' \  / _/ _` | || / _` | ' \  _|", 0Dh, 0Ah,
                            "   |_| |_/__/_||_| \__\__,_|\_,_\__, |_||_\__|", 0Dh, 0Ah,
                            "                                |___/         ", 0
    itIsA           BYTE    "              ___ _     _           ", 0Dh, 0Ah,
                            "             |_ _| |_  (_)___  __ _ ", 0Dh, 0Ah,
                            "              | ||  _| | (_-< / _` |", 0Dh, 0Ah,
                            "             |___|\__| |_/__/ \__,_|", 0
    pufferString    BYTE    "      ___       __  __          __ _    _    ", 0Dh, 0Ah,
                            "     | _ \_  _ / _|/ _|___ _ _ / _(_)__| |_  ", 0Dh, 0Ah,
                            "     |  _/ || |  _|  _/ -_) '_|  _| (_-< ' \ ", 0Dh, 0Ah,
                            "     |_|  \_,_|_| |_| \___|_| |_| |_/__/_||_|", 0
    sardineString   BYTE    "           ___              _ _          ", 0Dh, 0Ah,
                            "          / __| __ _ _ _ __| (_)_ _  ___ ", 0Dh, 0Ah,
                            "          \__ \/ _` | '_/ _` | | ' \/ -_)", 0Dh, 0Ah,
                            "          |___/\__,_|_| \__,_|_|_||_\___|", 0
    catfishString   BYTE    "             ___      _    __ _    _    ", 0Dh, 0Ah,
                            "            / __|__ _| |_ / _(_)__| |_  ", 0Dh, 0Ah,
                            "           | (__/ _` |  _|  _| (_-< ' \ ", 0Dh, 0Ah,
                            "            \___\__,_|\__|_| |_/__/_||_|", 0
    fishFailOhNo    BYTE    "               ___  _               ", 0Dh, 0Ah,
                            "              / _ \| |_    _ _  ___ ", 0Dh, 0Ah,
                            "             | (_) | ' \  | ' \/ _ \", 0Dh, 0Ah,
                            "              \___/|_||_| |_||_\___/", 0
    fishEscaped     BYTE    "  ___ _    _                                   _ ", 0Dh, 0Ah,
                            " | __(_)__| |_    ___ ___ __ __ _ _ __  ___ __| |", 0Dh, 0Ah,
                            " | _|| (_-< ' \  / -_|_-</ _/ _` | '_ \/ -_) _` |", 0Dh, 0Ah,
                            " |_| |_/__/_||_| \___/__/\__\__,_| .__/\___\__,_|", 0Dh, 0Ah,
                            "                                 |_|             ", 0
    baitingTitle1   BYTE    "        ___       _ _   _               ", 0Dh, 0Ah,
                            "       | _ ) __ _(_) |_(_)_ _  __ _     ", 0Dh, 0Ah,
                            "       | _ \/ _` | |  _| | ' \/ _` |  _ ", 0Dh, 0Ah,
                            "       |___/\__,_|_|\__|_|_||_\__, | (_)", 0Dh, 0Ah,
                            "                              |___/     ", 0
    baitingTitle2   BYTE    "        ___       _ _   _                   ", 0Dh, 0Ah,
                            "       | _ ) __ _(_) |_(_)_ _  __ _         ", 0Dh, 0Ah,
                            "       | _ \/ _` | |  _| | ' \/ _` |  _   _ ", 0Dh, 0Ah,
                            "       |___/\__,_|_|\__|_|_||_\__, | (_) (_)", 0Dh, 0Ah,
                            "                              |___/         ", 0
    baitingTitle3   BYTE    "        ___       _ _   _                       ", 0Dh, 0Ah,
                            "       | _ ) __ _(_) |_(_)_ _  __ _             ", 0Dh, 0Ah,
                            "       | _ \/ _` | |  _| | ' \/ _` |  _   _   _ ", 0Dh, 0Ah,
                            "       |___/\__,_|_|\__|_|_||_\__, | (_) (_) (_)", 0Dh, 0Ah,
                            "                              |___/             ", 0  
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
    randSeed        DWORD  ?

    ; for lake
    lakeSiz         DWORD  50

    ; for hook
    hookSiz         DWORD  5       ; 5 <= hookSiz <= lakeSiz
    hookPos         SDWORD 0      ; 0 <= hookPos <= lakeSiz - hookSiz
    velocity        SDWORD 0      ; hook's velocity
    gravity         SDWORD -1     ; + <gravity> per tick
    jumpForce       SDWORD 2      ; + <jumpForce> per tick if space is pressed

    ; for fish
    ; i = 0 -> puf
    ; i = 1 -> sar
    fishDict        DWORD  0,0,0  ; 0 -> uncatch, 1 -> catch
    fishPos         SDWORD 1      ; 1 <= hookPos <= lakeSiz - 1
    fishDir         SDWORD 1      ; -1, 0, 1 -> down, stop, up
    difficulty      DWORD  5      ; move every <difficulty> tick
    fishCooldown    DWORD  0      ; count steps

    ; for process
    process         DWORD  10      ; 0 -> fial, 100 -> success

    ; for selecting bar
    selecting       DWORD  1

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
        mov     eax, 0

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
        mov edx, OFFSET startMsg
        call WriteString
        call crlf
        mov eax, 100
        call Delay

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
        jmp WaitKey

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
            jmp FishGuide
        .ENDIF
    
    FishGuide:
        mov selecting, 1
        jmp EndPressed
        FishGuideLoop:
            call ReadKey
            cmp al, ' '
            je SetUp
            cmp al, 'a'
            je PressA
            cmp al, 'd'
            je PressD
            jmp FishGuideLoop

            PressA:
                mov eax, selecting
                dec eax
                .IF eax == 0
                    mov eax, 3
                .ENDIF
                mov selecting, eax
                jmp EndPressed
            
            PressD:
                mov eax, selecting
                inc eax
                .IF eax == 4
                    mov eax, 1
                .ENDIF
                mov selecting, eax
                jmp EndPressed

            EndPressed:
                mov ebx, selecting
                dec ebx
                shl ebx, 2
                mov ecx, DWORD PTR fishDict[ebx]
                cmp ecx, 1
                jne FishUnkown
                FishKnown:
                    .IF selecting == 1
                        call Clrscr
                        mov edx, OFFSET fishGuidePuf1
                        call WriteString
                        call crlf
                    .ELSEIF selecting == 2
                        call Clrscr
                        mov edx, OFFSET fishGuideSar1
                        call WriteString
                        call crlf
                    .ELSEIF selecting == 3
                        call Clrscr
                        mov edx, OFFSET fishGuideCat1
                        call WriteString
                        call crlf
                    .ENDIF
                    jmp EndFishKnUn

                FishUnkown:
                    call Clrscr
                    mov edx, OFFSET fishGuideUnk1
                    call WriteString
                    call crlf

                EndFishKnUn:

            mov edx, OFFSET guideMsg
            call WriteString
            call crlf
            mov eax, 100
            call Delay
            jmp FishGuideLoop

    FishingGame:
        FishingGameBaiting:
            mov ebx, 1
            mov ecx, 0
            INVOKE MyRandomRange, 5
            add eax, 5
            mov esi, eax
            WaitBait:
                inc ecx

                .IF ecx == esi
                    jmp EndWaitBait
                .ENDIF

                call Clrscr
                mov edx, OFFSET fishGameTitle
                call WriteString
                call crlf
                call crlf

                .IF ebx == 1
                    mov edx, OFFSET baitingTitle1
                    call WriteString
                    call crlf
                    inc ebx
                .ELSEIF ebx ==2
                    mov edx, OFFSET baitingTitle2
                    call WriteString
                    call crlf
                    inc ebx
                .ELSE
                    mov edx, OFFSET baitingTitle3
                    call WriteString
                    call crlf
                    mov ebx, 1
                .ENDIF

                mov eax, 500
                call Delay
                jmp WaitBait
            EndWaitBait:

        FishingGameLoop:
            call Clrscr
            mov edx, OFFSET fishGameTitle
            call WriteString
            call crlf
            call crlf
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
                mov edx, OFFSET fishGameTitle
                call WriteString
                call crlf
                call crlf
                mov edx, OFFSET fishSuccess
                call WriteString
                call crlf
                mov edx, OFFSET fishCaught
                call WriteString
                call crlf
                mov edx, OFFSET itIsA
                call WriteString
                call crlf
                INVOKE MyRandomRange, 3
                cmp eax, 0
                je caughtPuf
                cmp eax, 1
                je caughtSar
                cmp eax, 2
                je caughtCat
                caughtPuf:
                    mov edx, OFFSET pufferString
                    call WriteString
                    call crlf
                    jmp endCaught
                caughtSar:
                    mov edx, OFFSET sardineString
                    call WriteString
                    call crlf
                    jmp endCaught
                caughtCat:
                    mov edx, OFFSET catfishString
                    call WriteString
                    call crlf
                    jmp endCaught
                endCaught:

                shl eax, 2
                mov DWORD PTR fishDict[eax], 1
                mov edx, OFFSET successFailMsg
                call WriteString
                call crlf
                mov eax, 1000
                call Delay
                waitSpaceS:
                    call ReadKey
                    cmp al, ' '
                    je SetUp
                    jmp waitSpaceS
            .ELSEIF process == 0
                call Clrscr
                mov edx, OFFSET fishGameTitle
                call WriteString
                call crlf
                call crlf
                mov edx, OFFSET fishFailOhNo
                call WriteString
                call crlf
                mov edx, OFFSET fishEscaped
                call WriteString
                call crlf
                mov edx, OFFSET successFailMsg
                call WriteString
                call crlf
                mov eax, 1000
                call Delay
                waitSpaceF:
                    call ReadKey
                    cmp al, ' '
                    je SetUp
                    jmp waitSpaceF
            .ENDIF

        ; delay
        mov eax, 100
        call Delay

        jmp FishingGameLoop
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
    div ecx
    mov eax, edx

    ret

    _return_zero:
        xor eax, eax
        ret
MyRandomRange ENDP

END main
