```asm
.model tiny
.code
org 100h

start:
    push cs
    pop ds
    mov si, offset song_data

next_note:
    mov bx, [si]
    cmp bx, 0
    je done_song

    add si, 2
    mov cx, [si]
    add si, 2

    call play_note
    jmp next_note

done_song:
    mov ah, 4Ch
    int 21h

play_note proc

    mov al, 0B6h
    out 43h, al

    mov al, bl
    out 42h, al

    mov al, bh
    out 42h, al

    in al, 61h
    or al, 03h
    out 61h, al

delay_out:
    mov dx, 0FFFFh

delay_in:
    dec dx
    jnz delay_in

    loop delay_out

    in al, 61h
    and al, 0FCh
    out 61h, al

    ret

play_note endp

song_data dw 4560,25
          dw 3800,25
          dw 3421,25
          dw 2850,25
          dw 2535,25
          dw 2280,25
          dw 2280,25
          dw 2535,25
          dw 2850,25
          dw 3421,25
          dw 3800,25
          dw 4560,25
          dw 0,0

end start
```
