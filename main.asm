;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
NUM			.equ	2019
;
			MOV		#NUM,R5
			MOV		#RESP,R6
			CALL	#ALG_ROM
			JMP		$
			NOP
;
ALG_ROM:	SUB		#1000,R5
			JN		ADD_1000
			NOP
			MOV.B	#'M',0(R6)	;código para colocar M no vetor de resposta
			INC		R6
			JMP		ALG_ROM
			NOP
			RET

CENTENA:	NOP
			RET


ADD_1000:	ADD		#1000,R5
			JMP		CENTENA
			RET




;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            

			.data
RESP:		.byte	"RRRRRRRRRRRRR",0
