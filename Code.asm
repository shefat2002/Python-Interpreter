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

V1 DW ?
V2 DW ?

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
    
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_A: 
    MOV BL, [DI]
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
    CMP BL, '*'     
    JE MUL_A
    CMP BL, '/'
    JE DIV_A
    
 
    
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
    
    MUL_A:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    
    MOV AL, A
    SUB AL, 48
    MOV B.V1, AL
    
    MOV AL, BL
    SUB AL, 48
    MOV B.V2, AL
    
    MOV AX, V1
    MUL V2                  ;AX = V1 * V2 
    
    MOV DL, AL            
    ADD DL, 48
    MOV A, DL
    
    JMP OP_A
    
    DIV_A:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB BL,48
    
    MOV CL, A
    SUB CL, 48
    MOV AH,0
    MOV AL,CL
    
    DIV BL                  ;AX = AX / BL 
    
    MOV DL, AL            
    ADD DL, 48
    MOV A, DL
    
    JMP OP_A
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    
    
    
    
    
    ;WORK WITH VARIABLE B
    LB:
    INC DI
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END              
    MOV BL, [DI]
    CMP BL, '='             ;CHECK FOR EQUAL SIGN
    JE EQB
    
    
    JMP END
    
    EQB:
    INC DI
    
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_B: 
    MOV BL, [DI]
    MOV B, BL  
    
    
    OP_B:
    
    INC DI
    MOV BL, [DI]
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END
    
    ;CHECK ARITHMETIC SIGNS
    
    
    CMP BL, '+'     
    JE ADD_B
    CMP BL, '-'
    JE SUB_B
    CMP BL, '*'     
    JE MUL_B
    CMP BL, '/'
    JE DIV_B
    
 
    
    ADD_B:
     
    INC DI
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    ADD B, BL
    SUB B, 48
    JMP OP_B
    
    SUB_B:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB B, BL
    ADD B, 48
    JMP OP_B
    
    MUL_B:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    
    MOV AL, B
    SUB AL, 48
    MOV B.V1, AL
    
    MOV AL, BL
    SUB AL, 48
    MOV B.V2, AL
    
    MOV AX, V1
    MUL V2                  ;AX = V1 * V2 
    
    MOV DL, AL            
    ADD DL, 48
    MOV B, DL
    
    JMP OP_B
    
    DIV_B:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB BL,48
    
    MOV CL, B
    SUB CL, 48
    MOV AH,0
    MOV AL,CL
    
    DIV BL                  ;AX = AX / BL 
    
    MOV DL, AL            
    ADD DL, 48
    MOV B, DL
    
    JMP OP_B
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
      
    
    ;WORK WITH VARIABLE C
    LC:
    INC DI
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END              
    MOV BL, [DI]
    CMP BL, '='             ;CHECK FOR EQUAL SIGN
    JE EQC
    
    
    JMP END
    
    EQC:
    INC DI
    
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_C: 
    MOV BL, [DI]
    MOV C, BL  
    
    
    OP_C:
    
    INC DI
    MOV BL, [DI]
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END
    
    ;CHECK ARITHMETIC SIGNS
    
    
    CMP BL, '+'     
    JE ADD_C
    CMP BL, '-'
    JE SUB_C
    CMP BL, '*'     
    JE MUL_C
    CMP BL, '/'
    JE DIV_C
    
 
    
    ADD_C:
     
    INC DI
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    ADD C, BL
    SUB C, 48
    JMP OP_C
    
    SUB_C:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB C, BL
    ADD C, 48
    JMP OP_C
    
    MUL_C:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    
    MOV AL, C
    SUB AL, 48
    MOV B.V1, AL
    
    MOV AL, BL
    SUB AL, 48
    MOV B.V2, AL
    
    MOV AX, V1
    MUL V2                  ;AX = V1 * V2 
    
    MOV DL, AL            
    ADD DL, 48
    MOV C, DL
    
    JMP OP_C
    
    DIV_C:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB BL,48
    
    MOV CL, C
    SUB CL, 48
    MOV AH,0
    MOV AL,CL
    
    DIV BL                  ;AX = AX / BL 
    
    MOV DL, AL            
    ADD DL, 48
    MOV C, DL
    
    JMP OP_C
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
                           
                           
    
    ;WORK WITH VARIABLE D
    LD:
    INC DI
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END              
    MOV BL, [DI]
    CMP BL, '='             ;CHECK FOR EQUAL SIGN
    JE EQD
    
    
    JMP END
    
    EQD:
    INC DI
    
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_D: 
    MOV BL, [DI]
    MOV D, BL  
    
    
    OP_D:
    
    INC DI
    MOV BL, [DI]
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END
    
    ;CHECK ARITHMETIC SIGNS
    
    
    CMP BL, '+'     
    JE ADD_D
    CMP BL, '-'
    JE SUB_D
    CMP BL, '*'     
    JE MUL_D
    CMP BL, '/'
    JE DIV_D
    
 
    
    ADD_D:
     
    INC DI
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    ADD D, BL
    SUB D, 48
    JMP OP_D
    
    SUB_D:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB D, BL
    ADD D, 48
    JMP OP_D
    
    MUL_D:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    
    MOV AL, D
    SUB AL, 48
    MOV B.V1, AL
    
    MOV AL, BL
    SUB AL, 48
    MOV B.V2, AL
    
    MOV AX, V1
    MUL V2                  ;AX = V1 * V2 
    
    MOV DL, AL            
    ADD DL, 48
    MOV D, DL
    
    JMP OP_D
    
    DIV_D:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB BL,48
    
    MOV CL, D
    SUB CL, 48
    MOV AH,0
    MOV AL,CL
    
    DIV BL                  ;AX = AX / BL 
    
    MOV DL, AL            
    ADD DL, 48
    MOV D, DL
    
    JMP OP_D
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    
    
    
    
    
    
    
    
    ;WORK WITH VARIABLE E
    LE:
    INC DI
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END              
    MOV BL, [DI]
    CMP BL, '='             ;CHECK FOR EQUAL SIGN
    JE EQE
    
    
    JMP END
    
    EQE:
    INC DI
    
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    ASSIGN_E: 
    MOV BL, [DI]
    MOV E, BL  
    
    
    OP_E:
    
    INC DI
    MOV BL, [DI]
    
    CMP [DI],'$'             ;CHECK RETURN
    JE END
    
    ;CHECK ARITHMETIC SIGNS
    
    
    CMP BL, '+'     
    JE ADD_E
    CMP BL, '-'
    JE SUB_E
    CMP BL, '*'     
    JE MUL_E
    CMP BL, '/'
    JE DIV_E
    
 
    
    ADD_E:
     
    INC DI
    
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    ADD E, BL
    SUB E, 48
    JMP OP_E
    
    SUB_E:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB E, BL
    ADD E, 48
    JMP OP_E
    
    MUL_E:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    MOV BL, [DI]
    
    MOV AL, E
    SUB AL, 48
    MOV B.V1, AL
    
    MOV AL, BL
    SUB AL, 48
    MOV B.V2, AL
    
    MOV AX, V1
    MUL V2                  ;AX = V1 * V2 
    
    MOV DL, AL            
    ADD DL, 48
    MOV E, DL
    
    JMP OP_E
    
    DIV_E:
    INC DI
    CMP [DI],'$'           ;CHECK RETURN
    JE SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE 
    
    MOV BL, [DI]
    SUB BL,48
    
    MOV CL, E
    SUB CL, 48
    MOV AH,0
    MOV AL,CL
    
    DIV BL                  ;AX = AX / BL 
    
    MOV DL, AL            
    ADD DL, 48
    MOV E, DL
    
    JMP OP_E
    
    CMP [DI],'$'            ;CHECK RETURN
    JE END
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;PRINT VARIABLE
    DISPLAY2:
    CMP AL, 'a'
    JE PRINT_A 
    
    CMP AL, 'b'
    JE PRINT_B 
    
    CMP AL, 'c'
    JE PRINT_C 
    
    CMP AL, 'd'
    JE PRINT_D 
    
    CMP AL, 'e'
    JE PRINT_E
    
    JMP SYNTAX_ERROR        ;SYNTAX ERROR MESSAGE
    
    
    PRINT_A:
    MOV CL, A
    JMP REST
    
    PRINT_B:
    MOV CL, B
    JMP REST
    
    PRINT_C:
    MOV CL, C 
    JMP REST  
    
    PRINT_D:
    MOV CL, D
    JMP REST  
    
    PRINT_E:
    MOV CL, E
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
    
    MOV DL,CL
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
    
    