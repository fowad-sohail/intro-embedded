; Port 1 Pin Direction Register
P1DIR EQU 0x40004C04
; Port 1 Pin Output Register
P1OUT EQU 0x40004C02
P1IN EQU 0x40004C00
P1REN EQU 0x40004C06
	
P2REN EQU 0x40004C07 ; resistor enable
P2DIR EQU 0x40004C05
P2OUT EQU 0x40004C03
P2IN EQU 0x40004C01

YELLOWmask EQU 0x10 ; bitmask P2.4

TSTmask EQU 0x2 ; bitmask P1.1
ACKmask EQU 0x10; bitmask P1.4
FLAmask EQU 0x40 ; bitmask P2.6
OLAmask EQU 0x80 ; bitmask P2.7

	

        THUMB
        AREA    |.text|, CODE, READONLY, ALIGN=2
        EXPORT  asm_main

asm_main
        LDR     R0, =P2DIR      
        LDRB    R1, [R0]
        ORR     R1, #255          
        STRB    R1, [R0]        
				
		LDR     R0, =P1DIR      
        LDRB    R1, [R0]
        ORR     R1, #255          
        STRB    R1, [R0]
		
		LDR     R0, =P2REN      ; load Dir Reg in R1
		LDRB    R1, [R0]        ;
		ORR     R1, FLAmask     ; set bit
		STRB    R1, [R0]        ; store back to Dir Reg
		
		LDR     R0, =P2OUT      ; load Dir Reg in R1
		LDRB    R1, [R0]        ;
		ORR     R1, FLAmask		; set bit
		STRB    R1, [R0]        ; store back to Dir Reg

loop
        BL 		allOFF

        ; start in state b
		BL		stateB
        
        B       loop	; repeat the loop

; STATES
;-------------------------------------------------------------------------------
stateA
	; to get to stateB
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, TSTmask
	BNE stateB
	
	BL greenON
	BL yellowON
	BL redON
	
	LDR     R0, =500000
    BL      delayMs
					
	BL yellowOFF
	BL redOFF
	
	LDR     R0, =500000
    BL      delayMs
	
	B stateA
;-------------------------------------------------------------------------------
stateB
	BL greenON
	BL yellowOFF
	BL redOFF
	
	; to get to stateC
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, FLAmask
	BEQ stateC

	; to get to stateA
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, TSTmask
	BEQ stateA
	
	B stateB
;-------------------------------------------------------------------------------
stateC	
	; flash yellow
	BL greenOFF
	BL redOFF
	BL yellowON
	
	LDR     R0, =500000
    BL      delayMs
	
	BL yellowOFF
	
	LDR     R0, =500000
    BL      delayMs
	
	; to get to stateE
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, OLAmask
	BEQ stateE
	
	; didnt branch to stateE, OLA is off
	; check FLA for branch
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, FLAmask
	BNE stateB
	
	; didnt branch to stateB, FLA is off
	; check ACK for branch
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, ACKmask
	BEQ stateD
	
	; to get to stateB
	
	B stateC
;-------------------------------------------------------------------------------
stateD
	; to get to stateE
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, OLAmask
	BEQ stateE
	
	; didnt branch to stateE, OLA is off
	; check FLA for branch
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, FLAmask
	BNE stateC
	
	BL greenOFF
	BL redOFF
	BL yellowON
	
	B stateD
;-------------------------------------------------------------------------------
stateE
	; to get to stateF
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, ACKmask
	BEQ stateF

	BL greenOFF
	BL yellowOFF
	BL redON
	
	LDR     R0, =500000
    BL      delayMs
	
	BL redOFF
	
	LDR     R0, =500000
    BL      delayMs
	
	B stateE
;-------------------------------------------------------------------------------
stateF
	; to get to stateD
	LDR r0, =P2IN
	LDRB r1, [r0]
	TST r1, OLAmask
	BNE stateD
	
	BL greenOFF
	BL yellowOFF
	BL redON
	
	B stateF
; ------------------------------------------------------------------------------

; SUBROUTINES
; ------------------------------------------------------------------------------
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR

greenON
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #2          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR
		
greenOFF
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #2          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR

yellowON
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, YELLOWmask         
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR

yellowOFF
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, YELLOWmask          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR

redON
		LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #1          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX LR

redOFF
		LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #1          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR
		
allOFF
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #7          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR
		
        END
			
