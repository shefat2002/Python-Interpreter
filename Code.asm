.MODEL SMALL
.STACK 100H
.DATA 
QQQ db ">>> $"

;INSTRUCTIONS
DISP1 DB 10,13,"Write your python code (Press x for exit or h for help):$" 
ERROR DB 10,13,"Syntax error! Press h for help.$"
VER1 DB 10,13,"VERSION:$"
VER2 DB 10,13, "python-iterpreter(alpha) v0.0$"
VER3 DB 10,13,"(Build 20230923)$"

ABT DB 10,13,"GitHub: https://github.com/shefat2002/Python-Interpreter$"


;HELP INSTRUCTIONS 
INSINTRO DB "<<<<<<<<PYTHON INTERPRETER>>>>>>>>$"
INS1 DB 10,13,"There are limited features in the interpreter. You can do operations like print, input-output(integer & charecter) and basic arithmetic operations only. You can take only 5 inputs named a,b,c,d & e.$"
INS5 DB 10,13,"Basic commands:$"
INS2 DB 10,13,"X       EXIT$"
INS3 DB 10,13,"h       help$"
INS4 DB 10,13,"q       clear screen$"
INS6 DB 10,13,"v       version$"
INS7 DB 10,13,"s       show variables current valeus$" 

GUD1 DB 10,13,"print instructions:$" 
GUD2 DB 10,13,"To print a string type print($"
GUD21 DB 34,"<the string>$"
GUD22 DB 34,")$"
GUD3 DB 10,13,"To print a variable's valye type print(<variable name>)$"


;VARIABLES
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

SV DB 10,13,"Variables:$"
SA DB 10,13,"A = $" 
SB DB 10,13,"B = $" 
SC DB 10,13,"C = $" 
SD DB 10,13,"D = $" 
SE DB 10,13,"E = $" 



.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH,9
    LEA DX, INSINTRO
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
    
    ;CHECK COMMAND
    CMP AL, 'x'         ;CHECK EXIT COMMAND
    JE EXIT
    
    CMP AL, 'h'         ;HELP
    JE HELP
    
    CMP AL, 'v'         ;VERSION
    JE VERSION
    
    CMP AL, 'q'         ;CLEAR SCREEN
    JE CLEAR_SCREEN
    
    CMP AL, 's'         ;SHOW VARIABLES
    JE VARIABLES
    
    CMP AL, 'p'         ;CHECK PRINT FUNCTION
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
    
    CMP [DI],'$'            ;CHECK RETURN
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
               
    CMP AL,13               ;CHECK RETURN
    JNE REST
    
    ;NEW LINE
    MOV DL,13
    MOV AH,2
    INT 21H
    MOV DL, 10
    MOV AH,2
    INT 21H
    
    MOV DL,CL
    MOV AH,2                ;PRINT THE VALUE
    INT 21H
    
    JMP END
    
    
    
    ;ENDING PART
    
    
    
    ;HELP
    
    HELP:
    
    ;CLEAR SCREEN
    MOV AH,06               ;CLEAR SCREEN INSTRUCTION
    MOV AL,00               ;NUMBER OF LINES TO SCROLL
    MOV BH,07               ;DISPLAY ATTRIBUTE - COLORS
    MOV CH,00               ;START ROW
    MOV CL,00               ;START COL
    MOV DH,24               ;END OF ROW
    MOV DL,79               ;END OF COLUMN
    INT 10H                 ;BIOS INTERRUPT
    
    ;RESET CURSOR           
    MOV AH, 2               ;CURSOR INSTRUCTION
    MOV BH, 0               ;PAGE 0
    MOV DH, 0               ;ROW
    MOV DL, 0               ;COLUMN
    INT 10H                 ;BIOS INTERRUPT
    
    
    MOV AH,9
    LEA DX, INS1            ;BASIC INSTRUCTION
    INT 21H
    
    ;NEW LINE
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    
    MOV AH,9
    LEA DX, INS5            ;BASIC COMMANDS
    INT 21H
    
    MOV AH,9
    LEA DX, INS3            ;HELP
    INT 21H
    
    MOV AH,9                ;EXIT
    LEA DX, INS2
    INT 21H
    
    MOV AH,9                ;CLEAR SCREEN
    LEA DX, INS4
    INT 21H
    
    MOV AH,9                ;VERSION
    LEA DX, INS6
    INT 21H
    
    MOV AH,9                ;VARIABLES
    LEA DX, INS7
    INT 21H
    
    ;NEW LINE
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    
    ;GUIDLINE
    MOV AH,9                
    LEA DX, GUD1
    INT 21H
    
    MOV AH,9                
    LEA DX, GUD2
    INT 21H
    
    MOV AH,9                
    LEA DX, GUD21
    INT 21H
    
    MOV AH,9                
    LEA DX, GUD22
    INT 21H
    
    MOV AH,9                
    LEA DX, GUD3
    INT 21H
    
    
    JMP END
    
     
     
    ;VERSION CHECK 
    VERSION:
    
    
    MOV AH,9
    LEA DX, VER1
    INT 21H
    
    MOV AH,9
    LEA DX, VER2
    INT 21H
    
    MOV AH,9
    LEA DX, VER3
    INT 21H
    
    MOV AH,9
    LEA DX, ABT
    INT 21H
    
    JMP END 
    
    
    ;SHOW ALL VARIABLES VALUE
    VARIABLES:
    
    ;NEW LINE
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    
    MOV AH,9               ;VARIABLES
    LEA DX, SV
    INT 21H
    
    ;PRINT A
    MOV AH,9
    LEA DX, SA
    INT 21H
    
    MOV AH,2
    MOV DL, A
    INT 21H
    
    ;PRINT B
    MOV AH,9
    LEA DX, SB
    INT 21H
    
    MOV AH,2
    MOV DL, B
    INT 21H
    
    ;PRINT C
    MOV AH,9
    LEA DX, SC
    INT 21H
    
    MOV AH,2
    MOV DL, C
    INT 21H
    
    ;PRINT D
    MOV AH,9
    LEA DX, SD
    INT 21H
    
    MOV AH,2
    MOV DL, D
    INT 21H
    
    ;PRINT E
    MOV AH,9
    LEA DX, SE
    INT 21H
    
    MOV AH,2
    MOV DL, E
    INT 21H
    
    JMP END
    
    
    
    
    ;SHOW SYNTAX ERROR MESSAGE
    SYNTAX_ERROR:
    MOV AH,2
    MOV DL,7                ;BEEP SOUND
    INT 21H
    MOV AH,9                ;SYNTAX ERROR MESSAGE
    LEA DX, ERROR
    INT 21H
    JMP END
     
    ;CLEAR THE WHOLE SCREEN
    CLEAR_SCREEN:
    MOV AH,06               ;CLEAR SCREEN INSTRUCTION
    MOV AL,00               ;NUMBER OF LINES TO SCROLL
    MOV BH,07               ;DISPLAY ATTRIBUTE - COLORS
    MOV CH,00               ;START ROW
    MOV CL,00               ;START COL
    MOV DH,24               ;END OF ROW
    MOV DL,79               ;END OF COLUMN
    INT 10H                 ;BIOS INTERRUPT
    
    ;RESET CURSOR           
    MOV AH, 2               ;CURSOR INSTRUCTION
    MOV BH, 0               ;PAGE 0
    MOV DH, 0               ;ROW
    MOV DL, 0               ;COLUMN
    INT 10H                 ;BIOS INTERRUPT
    
    
    
    JMP END
    
    
    END:
    
    JMP START
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    