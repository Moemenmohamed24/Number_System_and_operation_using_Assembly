org 100h

; Display menu
mov dx, offset menu
mov ah, 9
int 21h

; Read choice
mov ah, 1
int 21h

cmp al, '1'
je addition
 

cmp al, '2'
je Subtraction

             
cmp al,'3'
je Multiplication


cmp al,'4'
je Division

  
  
cmp al,5
je ANDOperation  
  
  
cmp al,6
je OROperation               


cmp al,7
je XOROperation 

cmp al,8
je NOTOperation  

    
;<________________________________________>;     
cmp al,9
jmp exit     
;<________________________________________>;  
                                                 
NOTOperation:
                                                 
mov dx,offset msg1    
mov ah,9
INT 21h

  
call read_num

NOT ax  

mov dx,offset result
mov ah,9
INT 21h   
     
         
call print_num
        
 mov ah, 0
  int 16h        
  jmp exit 

;<________________________________________>;  
                                                 
XOROperation:
                                                 
mov dx,offset msg1    
mov ah,9
INT 21h

  
call read_num
push ax

mov dx,offset msg2
mov ah,9
INT 21h      


call read_num
pop bx
XOR ax,bx

mov dx,offset result
mov ah,9
INT 21h   
     
         
call print_num
        
 mov ah, 0
  int 16h        
  jmp exit 
;<________________________________________>;  
OROperation:          

mov dx,offset msg1    
mov ah,9
INT 21h

  
call read_num
push ax

mov dx,offset msg2
mov ah,9
INT 21h      


call read_num
pop bx
OR ax,bx

mov dx,offset result
mov ah,9
INT 21h   
     
         
call print_num
        
 mov ah, 0
  int 16h        
  jmp exit 

;<________________________________________>;    
ANDOperation:

mov dx,offset msg1    
mov ah,9
INT 21h

  
call read_num
push ax

mov dx,offset msg2
mov ah,9
INT 21h      


call read_num
pop bx
AND ax,bx

mov dx,offset result
mov ah,9
INT 21h   
     
         
call print_num
        
 mov ah, 0
  int 16h        
  jmp exit        

;<________________________________________>;  
Division:

mov dx,offset msg1
mov ah,9
INT 21h      


call read_num   
 push ax 


mov dx,offset msg2
mov ah,9
INT 21h      



            
call read_num    
mov bx,ax   
pop ax  
xor dx, dx;we want dx = 0 and ax/bx = 16bit/16bit
div bx
         
         
mov dx,offset result
mov ah,9
INT 21h
        
         
call print_num
        
 mov ah, 0
  int 16h        
  jmp exit          
         
              
;<________________________________________>;              
Multiplication:

mov dx,offset msg1
mov ah,9
INT 21h
     
call read_num
push ax

      
mov dx,offset msg2
mov ah,9
INT 21h       
       
       
call read_num
pop bx
       
mul bx

     
mov dx,offset result
mov ah,9
INT 21h       
       
       
call print_num       
       
       
 mov ah, 0
  int 16h        
  jmp exit      
       
           
;<________________________________________>;
Subtraction:  
  
mov dx,offset msg1     
mov ah,9
INT 21h

call read_num
push ax


mov dx,offset msg2     
mov ah,9
INT 21h

call read_num
pop bx
sub bx,ax
            
mov ax,bx
            
mov dx,offset result   
mov ah,9
INT 21h  
  
  
call print_num 
  
           
  mov ah, 0
    int 16h        
    jmp exit

;<________________________________________>;
addition:
    ; First number
    mov dx, offset msg1
    mov ah, 9
    int 21h
    
    call read_num
    push ax
    
    ; Second number
    mov dx, offset msg2
    mov ah, 9
    int 21h
    
    call read_num
    pop bx
    add ax, bx
    
    ; Show result
    mov dx, offset result
    mov ah, 9
    int 21h
    
    call print_num
    
    ; Wait for key
    mov ah, 0
    int 16h
    
    jmp exit     
    


read_num:
    mov bx, 0
digit_loop:
    mov ah, 1
    int 21h
    
    cmp al, 13
    je done
    
    sub al, '0'
    mov cl, al
    mov al, bl
    mov dl, 10
    mul dl
    add al, cl
    mov bl, al
    jmp digit_loop
done:
    mov ax, bx
    ret

print_num:
    mov bx, 10
    mov cx, 0
divide:
    mov dx, 0 
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne divide
    
print:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print
    ret   
    

menu db 13,10,'Calculator Menu:',13,10,13,10
     db '1. Addition',13,10  
     db '2. Subtraction',13,10    
     db '3. Multiplication',13,10    
     db '4. Division',13,10
     db '5. AND',13,10
     db '6. OR',13,10
     db '7. XOR',13,10
     db '8. NOT',13,10
     db '9. Exit',13,10
     db 'Choice: $'
     
msg1 db 13,10,10,'Enter first number: $'
msg2 db 13,10,'Enter second number: $'
result db 13,10,'Result: $'

exit:
    mov ax, 4c00h
    int 21h
