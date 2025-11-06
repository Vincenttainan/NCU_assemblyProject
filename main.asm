INCLUDE Irvine32.inc
main EQU start@0

canMove PROTO,
    xnow: DWORD,
    ynow: DWORD

Move PROTO,
    command: BYTE

DrawMaze PROTO

.data
    x DWORD 1
    y DWORD 1
    msg BYTE "(x,y): ",0
    comma BYTE ", ",0

    mazex DWORD 12
    mazey DWORD 6
    maze BYTE \
    "############",\
    "#          #",\
    "# ###  ##  #",\
    "#   ##    ##",\
    "##     ##  #",\
    "############",0

    playerPaint BYTE \
    "/\/\",\
    "|oo|",\
    "\__/",\
    "/  \",0

    wallPaint BYTE \
    "+--+",\
    "|  |",\
    "|  |",\
    "+--+",0

    airPaint BYTE \
    "    ",\
    "    ",\
    "    ",\
    "    ",0

.code
main PROC
    MainLoop:
        call Clrscr
        INVOKE DrawMaze
        
        call ReadChar
        INVOKE Move, al
        jmp MainLoop
main ENDP

; ------------------------------------------------------------------------
; void DrawMaze()
;
; Description:
;   Draws the entire maze to the screen using a 4x4 pixel representation for
;   each maze cell. Iterates through the "pixel" rows and columns rather than
;   just maze cells.
;   - Uses wallPaint for '#' cells.
;   - Uses airPaint for ' ' cells.
;   - Uses playerPaint for the current player position (x, y).
;   Calculates the correct pixel within the 4x4 paint block for each maze cell.
;
; Parameters:
;   None
;
; Globals Used:
;   x, y        - Player's current maze coordinates.
;   mazex       - Width of the maze (number of columns).
;   mazey       - Height of the maze (number of rows).
;   maze        - The maze array (layout of walls and spaces).
;   playerPaint - 4x4 pixel pattern representing the player.
;   wallPaint   - 4x4 pixel pattern representing walls.
;   airPaint    - 4x4 pixel pattern representing empty spaces.
;
; Globals Modified:
;   None
;
; Return:
;   None
;
; Notes:
;   - Each maze cell is drawn as a 4x4 block of characters.
;   - Pixel indices are calculated using modulo 4 to map to the correct paint.
; ------------------------------------------------------------------------
DrawMaze PROC USES eax ebx ecx esi edi edx
    mov ebx, 0
    mov esi, 0
    mov edi, mazey
    shl edi, 2
    mov edx, mazex
    shl edx, 2
    row:
        cmp ebx, edi
        je end_row
        mov ecx, 0

        col:
            cmp ecx, edx
            je end_col

            push ebx
            push ecx
            shr ebx, 2
            shr ecx, 2

            mov  esi, mazex
            imul esi, ebx
            add  esi, ecx

            mov al, maze[esi]
            cmp ecx, x
            jne draw_calculate
            cmp ebx, y
            jne draw_calculate
            mov al, '@' 

            draw_calculate:
                pop ecx
                pop ebx
                push ebx
                push ecx
                push esi

                and ebx, 3
                and ecx, 3
                mov  esi, 4
                imul esi, ebx
                add  esi, ecx

                cmp al, '#'
                je draw_wall
                cmp al, ' '
                je draw_air
                cmp al, '@'
                je draw_player

                draw_wall:
                    mov al, wallPaint[esi]
                    jmp draw
                draw_air:
                    mov al, airPaint[esi]
                    jmp draw
                draw_player:
                    mov al, playerPaint[esi]
                    jmp draw

            draw:
                call WriteChar

                pop esi
                pop ecx
                pop ebx
                inc ecx
                jmp col

        end_col:
            call Crlf
            inc ebx
            jmp row

    end_row:
        ret
DrawMaze ENDP

; ------------------------------------------------------------------------
; void Move(command)
; 
; Description:
;   move the player according to input key
;   reads in one character 'w', 'a', 's', 'd'
;   if the destination cell is not blocked
;   updates player's position (x, y)
;
; Parameters:
;   command   - the input key character
;
; Globals Used:
;   x, y      - current player coordinates
;   canMove() - function to check if the target cell is accessible
;
; Globals Modified:
;   x, y      - updates player's position if movement is valid
;
; Return:
;   None
;
; Notes:
;   None
; ------------------------------------------------------------------------
Move PROC USES eax ebx,
    command: BYTE

    movzx eax, command
    cmp al, 'w'
    je MoveUp
    cmp al, 's'
    je MoveDown
    cmp al, 'a'
    je MoveLeft
    cmp al, 'd'
    je MoveRight
    ret

    MoveUp:
        mov eax, x
        mov ebx, y
        dec ebx
        INVOKE canMove, eax, ebx
        cmp eax, 1
        jne retMove
        dec y
        jmp retMove

    MoveDown:
        mov eax, x
        mov ebx, y
        inc ebx
        INVOKE canMove, eax, ebx
        cmp eax, 1
        jne retMove
        inc y
        jmp retMove

    MoveLeft:
        mov eax, x
        mov ebx, y
        dec eax
        INVOKE canMove, eax, ebx
        cmp eax, 1
        jne retMove
        dec x
        jmp retMove

    MoveRight:
        mov eax, x
        mov ebx, y
        inc eax
        INVOKE canMove, eax, ebx
        cmp eax, 1
        jne retMove
        inc x
        jmp retMove

    retMove:
        ret
Move ENDP

; ------------------------------------------------------------------------
; bool canMove(xnow, ynow)
;
; Description:
;   check if the player can move to position (xnow, ynow)
;   if the target cell in the maze is not '#', movement is allowed
;
; Parameters:
;   xnow - target X position
;   ynow - target Y position
;
; Globals Used:
;   maze    - the maze array containing walls '#' and empty spaces ' '
;   mazex   - width of the maze (number of columns)
;
; Globals Modified:
;   None
;
; Return:
;   EAX = 1 : can go
;   EAX = 0 : can't go
;
; Notes:
;   index = ynow * mazex + xnow
; ------------------------------------------------------------------------
canMove PROC USES ebx,
    xnow: DWORD,
    ynow: DWORD

    mov eax, mazex
    mov ebx, ynow
    imul eax, ebx
    add eax, xnow

    mov bl, maze[eax]
    cmp bl, '#'
    jne can_move_ok
    mov eax, 0
    ret

    can_move_ok:
        mov eax, 1
        ret
canMove ENDP

END main
