
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data
    enter db "Enter a Hex digit: $" 
    decimal db "The decimal value of $" 
    is db " is $"  
    NEWL DB 0AH, 0DH, ‘$’
    
.code   
    
    ; Assumes inputs to be only 0...9 or A...F (uppercase only) 
    ; Lowecase values won't give the correct output
    
    mov ah, 9        ;prompt text
    lea dx, enter
    int 21h
    
    mov ah, 1
    int 21h
    mov cl, al
                
    mov ah, 9
    lea dx, newl
    int 21h  
    
    lea dx, decimal   ; decimal display text
    int 21h     
    
    mov ah, 2
    mov dl, cl   ; display text entered
    int 21h      
    
    mov ah, 9
    lea dx, is   ; last part of the decimal display text
    int 21h
          
    cmp cl, 39h
    jg hexletter ; letter was provided (A...F) 
                
    mov ah, 2  ; print itself if a number was entered (0...9)
    mov dl, cl      
    int 21h 
    jmp exit 
    

hexletter:   

    mov ah, 2    ; first digit of A...F
    mov dl, 31h      
    int 21h    
    
    sub cl, 11h  ; last digit
    mov dl, cl
    int 21h

     
exit:  
    ret




