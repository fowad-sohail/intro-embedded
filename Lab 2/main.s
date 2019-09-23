; ******** NUMBER 1 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label
;		LDR r1,[r0]
;		B main

;		AREA mydata, DATA, READWRITE
;label 	DCB 0xA1
;		END


;******** NUMBER 2 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label
;		LDR r1,[r0]
;		B main

;		AREA mydata, DATA, READWRITE
;label 	DCB 0xA1, 0xAB
;		END
			
;******** NUMBER 3 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label
;		LDR r1,[r0]
;		B main
; 
;		AREA mydata, DATA, READWRITE
;label 	DCB 0xA1, 0xAB, 0xC2, 0xD3
;		END

;******** NUMBER 4 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label1
;		LDR r1,[r0]
;		B main

;		AREA mydata, DATA, READWRITE
;label1 	DCB 0xA1
;label2 	DCB 0xF3
;		END

;******** NUMBER 5 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label1
;		LDR r1,[r0]
;		B main
;		
;		AREA mydata, DATA, READWRITE
;label1 	DCB 0xA1
;label2 	DCW 0xBCDF
;		END

;******** NUMBER 7 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label
;		LDR r1,[r0]
;		ADD r0, r0, 4
;		LDR r2,[r0]
;		B main
;		
;		AREA mydata, DATA, READWRITE
;label 	DCD 0xA1F1C3B2, 0xAAFFCCBB
;		END
			
;******** NUMBER 8 ********
;		AREA program, CODE, READONLY
;		EXPORT main
;		ENTRY
;main

;		LDR r0,= label
;		LDR r1,[r0]
;		LDR r2,[r0,4]
;		B main

;		AREA mydata, DATA, READWRITE
;label 	DCD 0xA1F1C3B2, 0xAAFFCCBB
;		END 

;******** NUMBER 9 ********
		AREA program, CODE, READONLY
		EXPORT main
		ENTRY
main

		LDRSH r1,[r0]
		LDRSH r2,[r0,4] 
		LDR r2,[r0,4]
		B main

		AREA mydata, DATA, READWRITE
label 	DCD 0xA1F1C3B2, 0xAAFFCCBB
		END 