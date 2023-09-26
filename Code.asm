.MODEL SMALL
.STACK 100H
.DATA 
QQQ db ">>> $"
WELCOME DB "Welcome to Python Interpreter!$"
NOTE DB 10,13,"There are limited features. You can do operations like print, input-output(integer & charecter) and basic arithmetic operations only. You can take only 5 inputs named a,b,c,d & e.$"

DISP1 DB 10,13,"Write your python code (Press x for exit):$" 
ERROR DB 10,13,"Syntax error! Press i to read the instructions.$"

STRING DB 60 DUP(?)
A DB '0'
B DB '0'
C DB '0'
D DB '0'
E DB '0'

EQ DB '0' 

VAR DB ?


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH,9
    LEA DX, WELCOME
    INT 21H
    
    MOV AH,9
    LEA DX, NOTE
    INT 21H
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    MOV AH,9
    LEA DX, DISP1
    INT 21H
    
    
    START: 
                  
    MOV SI, OFFSET STRING 
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    MOV AH,9
    LEA DX,QQQ
    INT 21H
    
    MOV AH,1
    INT 21H
    
    CMP AL, 'x'       ;CHECK EXIT COMMAND
    JE EXIT
    
    CMP AL, 'p'       ;CHECK PRINT FUNCTION
    JNE ARITHMETIC
     
     
    ;WORK WITH PRINT FUNCTION
    INPUT_OUTPUT:
    
    MOV AH,1
    INT 21H
    
    CMP AL, 'r'
    JE INPUT_OUTPUT
    CMP AL, 'i'
    JE INPUT_OUTPUT
    CMP AL, 'n'
    JE INPUT_OUTPUT
    CMP AL, 't'
    JE INPUT_OUTPUT
    CMP AL, '('
    JE INPUT_OUTPUT
    CMP AL, '"'
    JE INPUT
    JMP DISPLAY2
    
    
    
    
    INPUT:
    
    MOV AH,1
    INT 21H
    
    CMP AL, 13       ;CHECK CARRAGE RETURN
    JE DISPLAY
    
    MOV [SI],AL
    INC SI
    JMP INPUT
    
    
    
    DISPLAY:
    MOV [SI], '$' 
    MOV DI, OFFSET STRING  
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    AGAIN:
    CMP [DI], '"'       
    JE END 
    CMP [DI], ')'       
    JE END
                 
     
    
    
    
    MOV DL, [DI]
    MOV AH,2
    INT 21H
    INC DI
    JMP AGAIN
    
    
    
    
    ARITHMETIC:
    
    MOV [SI],AL
    INC SI
    MOV VAR, AL
    
    INP:
    
    MOV AH,1
    INT 21H
    
    CMP AL, 13              ;CHECK CARRAGE RETURN
    JE NEXT
    
    MOV [SI],AL
    INC SI
    JMP INP
    
    NEXT:
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    ;INC SI
    MOV [SI], '$'
    MOV DI, OFFSET STRING     
    CLD
    
    MOV BL, [DI]
    
    CMP BL, 'a'
    JE LA
    
    CMP BL, 'b'
    JE LB
    
    CMP BL, 'c'
    JE LC 
    
    CMP BL, 'd'
    JE LD  
    
    CMP BL, 'e'
    JE LE
    
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    
    
    ;WORK WITH VARIABLE A
    LA:
    INC DI
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END              
    MOV BL, [DI]
    CMP BL, '='             ;CHECK FOR EQUAL SIGN
    JE EQA
    
    
    JMP END
    
    EQA:
    INC DI
    MOV BL, [DI] 
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_A:
    MOV A, BL  
    
    
    OP_A:
    
    INC DI
    MOV BL, [DI]
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END
    
    ;CHECK ARITHMETIC SIGNS
    
    
    CMP BL, '+'     
    JE ADD_A
    CMP BL, '-'
    JE SUB_A
    ;CMP BL, '*'     
    ;JE MUL_A
    ;CMP BL, '/'
    ;JE DIV_A
    
 
    
    ADD_A:
     
    INC DI
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    ADD A, BL
    SUB A, 48
    JMP OP_A
    
    SUB_A:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB A, BL
    ADD A, 48
    JMP OP_A
    
    ;MUL_A:
    ;INC DI
    ;CMP [DI],'$'           ;CHECK RETURN
    ;JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ;MOV BL, [DI]
    ;MUL A, BL
    ;JMP OP_A
    
    ;DIV_A:
    ;INC DI
    ;CMP [DI],'$'           ;CHECK RETURN
    ;JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
                    
    ;MOV BL, [DI]                
    ;DIV A, BL
    ;JMP OP_A
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    
    LB:
    
    LC:
    
    LD:
    
    LE:
    
    
    
    ;PRINT VARIABLE
    DISPLAY2:
    CMP AL, 'A'
    JE PRINT_A 
    
    CMP AL, 'B'
    JE PRINT_B 
    
    CMP AL, 'C'
    JE PRINT_C 
    
    CMP AL, 'D'
    JE PRINT_D 
    
    CMP AL, 'E'
    JE PRINT_E
    
    
    
    PRINT_A:
    MOV BL, A
    JMP REST
    
    PRINT_B:
    MOV BL, B
    JMP REST
    
    PRINT_C:
    MOV BL, C 
    JMP REST  
    
    PRINT_D:
    MOV BL, D
    JMP REST  
    
    PRINT_E:
    MOV BL, E
    JMP REST
    
    
    ;WRITE REST OF THE CODE
    REST:
    MOV AH,1
    INT 21H
               
    CMP AL,13       ;CHECK CARRAGE RETURN
    JNE REST
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    MOV DL,BL
    MOV AH,2        ;PRINT THE VALUE
    INT 21H
    
    JMP END
    
    SYNTAX_ERROR:
    MOV AH,2
    MOV DL,7
    INT 21H
    MOV AH,9        ;SYNTAX ERROR MESSAGE
    LEA DX, ERROR
    INT 21H
    
    END:
    
    JMP START
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    