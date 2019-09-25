; Port 1 Pin Direction Register
P1DIR EQU 0x40004C04
; Port 1 Pin Output Register
P1OUT EQU 0x40004C02
P1IN EQU 0x40004C00
	
P2DIR EQU 0x40004C05
P2OUT EQU 0x40004C03

FLAmask EQU 0x40 ; bitmask P2.6
TSTmask EQU 0x2 ; bitmask P1.1
YELLOWmask EQU 0x10 ; bitmask P2.4
	

        THUMB
        AREA    |.text|, CODE, READONLY, ALIGN=2
        EXPORT  asm_main

asm_main
        ; make P1.0 an output pin
        LDR     R0, =P2DIR      ; load Dir Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #23          ; set bit 0
        STRB    R1, [R0]        ; store back to Dir Reg
		
		LDR     R0, =P1DIR      ; load Dir Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #23          ; set bit 0
        STRB    R1, [R0]        ; store back to Dir Reg

loop
        BL 		allOFF

        ; STATE B
		BL		stateB
        


        B       loop	; repeat the loop

; This subroutine performs a delay of n ms (for 3 MHz CPU clock). 
; n is the value in R0.
stateB
	BL greenON
	BL yellowOFF
	BL redOFF
	
	; to get to stateC
;	LDR r0, =P2IN
;	LDRB r1, [r0]
;	TST r1, FLAmask
;	BEQ stateC

	; to get to stateA
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, TSTmask
	BEQ stateA
	
	B stateB


stateA
	BL greenOFF
	B stateA

; SUBROUTINES
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
			
