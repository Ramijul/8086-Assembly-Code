
org 100h

.data 
    STR DB "ashd@kjash!123di6868nasnfn6sdnf8nsd8fnuHUUNIu%$" 
    MSG DB "The minimum element in the array: $"
    
.code    
    mov ax, @data
    mov ds, ax    
     
    ;print msg 
    mov ah, 9
    lea dx, MSG    
    int 21h
    
    mov si, 0
    mov bl, STR[si]  ; minimum character          
                
nextChar:
    inc si
    mov cl, STR[si]  ; temp char holder
    
    cmp cl, 24h      ; exit if end of string
    je exit
    
    cmp cl, bl       ; if smaller char found, record it
    jl updateBL  
    
    jmp nextChar     ; else move to next char
        
updateBL:
    mov bl, cl
    jmp nextChar 
    
    
exit: 
    mov ah, 2 
    mov dl, bl
    int 21h   
     
    ret




