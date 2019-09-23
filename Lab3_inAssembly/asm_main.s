; Port 1 Pin Direction Register
P1DIR EQU 0x40004C04
; Port 1 Pin Output Register
P1OUT EQU 0x40004C02
	
P2DIR EQU 0x40004C05
P2OUT EQU 0x40004C03
	
P3DIR EQU 0x40004C24
P3OUT EQU 0x40004C22

        THUMB
        AREA    |.text|, CODE, READONLY, ALIGN=2
        EXPORT  asm_main

asm_main
        ; make P1.0 an output pin
        LDR     R0, =P2DIR      ; load Dir Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #7          ; set bit 0
        STRB    R1, [R0]        ; store back to Dir Reg

loop
        ; turn off all LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #7          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg

        ; delay for 0.5 second
        LDR     R0, =500000
        BL      delayMs

        ; turn on red LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #1          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg

        ; delay for 0.5 second
        LDR     R0, =500000
        BL      delayMs
		
		; turn off all LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #7          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		
		; turn on green LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #2          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg

		; delay for 0.5 second
        LDR     R0, =500000
        BL      delayMs
		
		; turn off all LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        MVN     R2, #7          ; load complement of bit 0 mask
        AND     R1, R2          ; clear bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		
		; turn on blue LED
        LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #4          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		
		; delay for 0.5 second
        LDR     R0, =500000
        BL      delayMs

        B       loop	; repeat the loop

; This subroutine performs a delay of n ms (for 3 MHz CPU clock). 
; n is the value in R0.
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR

        END