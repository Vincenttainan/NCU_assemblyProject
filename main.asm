INCLUDE Irvine32.inc
main EQU start@0

canMove PROTO,
    xnow: DWORD,
    ynow: DWORD

.data
    x DWORD 1
    y DWORD 1
    msg BYTE "(x,y): ",0
    comma BYTE ", ",0

    mazex DWORD 8
    mazey DWORD 6
    maze BYTE \
    "########",0dh,0ah,\
    "#      #",0dh,0ah,\
    "# ###  #",0dh,0ah,\
    "#   #  #",0dh,0ah,\
    "#      #",0dh,0ah,\
    "########",0dh,0ah,0

.code
main PROC
    call Clrscr

    MainLoop:
        mov edx, OFFSET msg
        call WriteString
        mov eax, x
        call WriteDec
        mov edx, OFFSET comma
        call WriteString
        mov eax, y
        call WriteDec
        call Crlf
        
        call ReadChar
        cmp al, 'w'
        je TryUp
        cmp al, 's'
        je TryDown
        cmp al, 'a'
        je TryLeft
        cmp al, 'd'
        je TryRight
        jmp MainLoop

    TryUp:
        mov eax, x
        mov ebx, y
        dec ebx
        INVOKE canMove, eax, ebx
        cmp eax, 1
        je MoveUp
        jmp ClearAndLoop

    TryDown:
        mov eax, x
        mov ebx, y
        inc ebx
        INVOKE canMove, eax, ebx
        cmp eax, 1
        je MoveDown
        jmp ClearAndLoop

    TryLeft:
        mov eax, x
        mov ebx, y
        dec eax
        INVOKE canMove, eax, ebx
        cmp eax, 1
        je MoveLeft
        jmp ClearAndLoop

    TryRight:
        mov eax, x
        mov ebx, y
        inc eax
        INVOKE canMove, eax, ebx
        cmp eax, 1
        je MoveRight
        jmp ClearAndLoop

    MoveUp:
        dec y
        jmp ClearAndLoop
    MoveDown:
        inc y
        jmp ClearAndLoop
    MoveLeft:
        dec x
        jmp ClearAndLoop
    MoveRight:
        inc x
        jmp ClearAndLoop

    ClearAndLoop:
        call Clrscr
        jmp MainLoop

main ENDP

; ------------------------------------
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
; Return:
;   EAX = 1 : can go
;   EAX = 0 : can't go
; ------------------------------------
canMove PROC USES ebx,
    xnow: DWORD,
    ynow: DWORD

    mov eax, mazex
    add eax, 2
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
