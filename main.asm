INCLUDE Irvine32.inc
main EQU start@0

.data
    x BYTE 0
    y BYTE 0
    msg BYTE "(x,y): ",0
    comma BYTE ", ",0

.code
main PROC
    call Clrscr

MainLoop:
    mov edx, OFFSET msg
    call WriteString
    movzx eax, x
    call WriteDec

    mov edx, OFFSET comma
    call WriteString
    movzx eax, y
    call WriteDec
    call Crlf
    
    call ReadChar
    cmp al, 'w'
    je MoveUp
    cmp al, 's'
    je MoveDown
    cmp al, 'a'
    je MoveLeft
    cmp al, 'd'
    je MoveRight

    jmp MainLoop

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
END main
