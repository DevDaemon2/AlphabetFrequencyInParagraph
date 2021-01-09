.model small
.stack 100h
.data
msg2 db 0dh,0ah,"Frequency of character $"

str db "healo ta my nameaaaaaaaaaaaaaaaaaaaaaaaaa$"
counter= $- str
count dw 0

.code
main proc
mov ax,@data
mov ds,ax
mov es,ax

mov bx,'a'
l2:
mov di,offset str
cld
mov cx,0
mov cl,counter
l3:   
 mov al,bl
 Scasb
 jz findCount
 loop l3

nextalphabet: 
 add bl,1
 cmp bl,'z'
 jle l2
jmp end



findCount:
mov di,offset str
cld
mov cx,0
mov cl,counter
l:   
 mov al,bl
 Scasb
 jz alphabet;1
 jmp notalphabet
 
alphabet: 
  add count,1
  
notalphabet:
    
  loop l

mov ah,9
mov dx,offset msg2
int 21h

mov ah,2
mov dl,bl
int 21h

mov ah,2
mov dl,'='
int 21h

mov ax,count;add count,30h
call OUTDEC

mov count,0 
jmp nextalphabet

    
end:    
mov ah,4ch
int 21h    
main endp 

OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none
   ; uses : MAIN

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

  @START:                        ; jump label

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   @DISPLAY:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 OUTDEC ENDP

end main
