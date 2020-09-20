; Title: Colours Blinking routine 
;	Name: Muhammad Hasan
;	ID: CSC-18F-087
cseg segment
assume cs:cseg, ds:cseg
org 100H
begin:
                mov es,cs:[video]

                mov ax,3
                int 10h
                mov cs:[col],0fh
                mov di,18
                lea si,colr2
                call mess

                mov cx,16
                mov di,160
                xor al,al
rec1:
                push cx

                push di
                lea si,colour
                call mess
                call hex2

                mov bh,al
                push cx
                mov cx,16
col2:
                mov es:[di],byte ptr "#"
                mov es:[di+1],bh
                inc bh
                add di,2

                loop col2
                pop cx


                pop di
                add di,160
                add al,10h

                add cs:[col],10h
                pop cx
                loop rec1


                mov ah,2
                mov bh,0
                mov dh,17
                mov dl,0
                int 10h


                mov ah,4ch
                int 21h

col             db 0
colour          db "Colour ",0
colr2           db "Colour Blinking Routine 0123456789ABCDEF",0
colnum          db 0

video           dw 0b800h

hex2            proc near
                push ax
                and al,011110000b
                shr al,4
                call hex1
                pop ax
                push ax
                and al,01111b
                call hex1
                pop ax
                ret
hex2            endp
hex1            proc near
                mov ah,cs:[col]
                cmp al,10
                jb hnum1
                add al,'A'-10
                jmp hnum2
hnum1:
                add al,'0'
hnum2:
                mov es:[di],ax
                add di,2
                ret
hex1            endp
mess            proc
                push ax
                mov ah,cs:[col]
conmess:
                mov al,cs:[si]
                or al,al
                jz endmess
                mov es:[di],ax
                inc si
                add di,2
                jmp conmess
endmess:
                pop ax
                ret
mess            endp


cseg ends
end begin