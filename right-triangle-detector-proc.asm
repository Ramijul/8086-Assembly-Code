include 'emu8086.inc'  

org 100h   

.model small
.stack 100h
.data
    msg db "Enter the sides of a triangle:", 0ah, 0dh, 0               ;ter the sides of a triangle:
    isRight db "It is a right-angled triangle.", 0
    isNotRight db "It is not a right-angled triangle.", 0 
    newl db 0ah, 0dh, 0 

.code
 main proc 
    mov ax, @data
    mov ds, ax
    
    lea si, msg 
    call print_string  
    
    mov di, 0
    
    input:
        call scan_num
        push cx    
        lea si, newl 
        call print_string 
        inc di
        cmp di, 3
        jne input 
        
    call triangle 
    
    cmp cl, 1                   ;0/1 = False/True returned from triangle proc
    je printIsRight  
    
    printIsNotRight:              
        lea si, isNotRight 
        call print_string  
        jmp exit
                          
    printIsRight: 
        lea si, isRight 
        call print_string
    
    exit:    
        mov ah, 4ch
        int 21h
    
 main endp  
 
 triangle proc    
    push bp
    mov bp, sp
    
    mov ax, [bp + 8]    ; c^2
    call square     
    mov cx, ax
    
    mov ax, [bp + 6]    ; b^2
    call square        
    mov bx, ax
    
    mov ax, [bp + 4]    ; a^2
    call square   
    
    
    ; check if c^2 = a^2 + b^2
    mov dx, 0
    add dx, ax
    add dx, bx          ; a^2 + b^2
    cmp dx, cx          
    je isRightAngled      
    
    
    ; check if a^2 = c^2 + b^2
    mov dx, 0
    add dx, cx
    add dx, bx          ; c^2 + b^2
    cmp dx, ax          
    je isRightAngled  
    
    
    ; check if b^2 = c^2 + a^2
    mov dx, 0
    add dx, cx
    add dx, ax          ; c^2 + a^2
    cmp dx, bx          
    je isRightAngled
    
    
    ; else not right angled
    mov cl, 0           ; returns false
    jmp return 
    
    isRightAngled:
        mov cl, 1       ; returns true
        
    return:
        pop bp
        ret
 triangle endp  
 
 
 square proc  
    mul al
    ret
 square endp
    
 
 define_print_string  
 define_scan_num   
 define_print_num 
 DEFINE_PRINT_NUM_UNS
 

end main
 




