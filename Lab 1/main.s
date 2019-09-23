		AREA program, CODE, READONLY
		EXPORT main
		ENTRY

main       
	;Question 1
	;part b.
		LDR r3, = 0x80000000
		MOV r4, 0xF0000000
		ADDS r5, r4, r3  
		
	;part c.
		;LDR r6, = 0xFFFFFFFA
		;MOV r7, 0x4
		;ADDS r8, r7, r6
		
	;Question 3
		;LDR r0, = 0xFFFFFFFF
		;LDR r1, = 0x2
		;LDR r2, = 0x00000001
		;LDR r3, = 0x4
		
		;ADDS r4, r2, r0
		;ADC r5, r3, r1
		;ADDS r6, r5, r4
	
	;Question 4
		;LDR r0, = 0x1
		;RSBS r1, r0, #88
	
	;Question 5
	; y = 11 - 7x^2 - 10x
	; y = r2 & x = r1
;		MOV r1, 0xFFFFFFFF
;		;7x^2
;		MUL r2, r1, r1
;		MOV r3, #7
;		MUL r2, r2, r3
;		;10x
;		MOV r3, #10
;		MUL r3, r1, r3
;		;10 - 7x^2
;		RSBS r2, r2, #11
;		;(10 - 7x^2) - 10x
;		SUBS r2, r2, r3
		
		B main
		END