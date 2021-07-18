; ######################################
; #                                    #
; #         uMON1 Version 1.04         #
; #  --------------------------------  #
; #   Special Key Sequences            #
; #  --------------------------------  #
; #   Shift-+ - Insert byte.           #
; #   Shift-- - Delete byte.           #
; #                                    #
; #  --------------------------------  #
; #   Included Modules                 #
; #  --------------------------------  #
; #                None                #
; #  --------------------------------  #
; #                                    #
; #  by Scott Gregory                  #
; #  13/06/2021                        #
; #                                    #
; #  Last update                       #
; #  18/07/2021                        #
; ######################################
;
STACKTOP	.EQU	$08C0 ; Stack position.
ROMBASE		.EQU	$0000 ; Start of ROM.
ROMTOP		.EQU	$07FF ; End of ROM.
RAMBASE		.EQU	$0900 ; Start of user RAM.
RAMTOP		.EQU	$FFFF ; End of user RAM.
CATHDLY		.EQU	$40 ; Digit display delay.
KEYPORT		.EQU	$00 ; Keypad port.
CATHPORT	.EQU	$01 ; Display catchode port.
SEGPORT		.EQU	$02 ; Display segment port.
;
ADDRESS		.EQU	$08C1 ; 2 Bytes.
SCRATCH		.EQU	$08C3 ; 2 Bytes.
MODE		.EQU	$08C5 ; 1 Byte.
KEYDATA		.EQU	$08C6 ; 1 Byte.
BEEPLENGTH	.EQU	$08C7 ; 2 Bytes.
BEEPFREQ	.EQU	$08C9 ; 1 Byte.
;
; Begin global MOD assignments.
; End global MOD assignments.
;
; Begin MOD-xx assignments.
; End MOD-xx assignments.
;
			.FILL	(ROMTOP - ROMBASE) + 1, $00
			.ORG	$0000
RESET_00:	JP		SETUP
;
			.ORG	$0008
RESET_08:	JP		SETUP
;
			.ORG	$0010
RESET_10:	JP		SETUP
;
			.ORG	$0018
RESET_18:	JP		SETUP
;
			.ORG	$0020
RESET_20:	JP		SETUP
;
			.ORG	$0028
RESET_28:	JP		SETUP
;
			.ORG	$0030
RESET_30:	JP		SETUP
;
			.ORG	$0038
RESET_38:	JP		SETUP
;
			.ORG	$0040
VERSION:	.TEXT	"uMON V1.04 by Scott Gregory"
;
			.ORG	$0066
NMISERVICE:	PUSH	af ; Keyboard service routine.
			IN		a,(KEYPORT)
			LD		(KEYDATA),a
			POP		af
			RETN
;
			.ORG	$0080
DISPLAY:	XOR		a ; Display update routine.
			OUT		(CATHPORT),a
			OUT		(SEGPORT),a
			LD		c,a
			SET		5,c
			LD		de,(ADDRESS)
			LD		a,d
			LD		(SCRATCH),a
			XOR		a
			LD		hl,SCRATCH
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		z,DISL00
			OR		$10
DISL00:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD		b,CATHDLY
DISL01:		DJNZ	DISL01
			XOR		a
			OUT		(CATHPORT),a
			RR		c
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		z,DISL02
			OR		$10
DISL02:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD		b,CATHDLY
DISL03:		DJNZ	DISL03
			XOR		a
			OUT		(CATHPORT),a
			RR		c
			LD		de,(ADDRESS)
			LD		a,e
			LD		(SCRATCH),a
			XOR		a
			LD		hl,SCRATCH
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		z,DISL04
			OR		$10
DISL04:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD			b,CATHDLY
DISL05:		DJNZ	DISL05
			XOR		a
			OUT		(CATHPORT),a
			RR		c
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		z,DISL06
			OR		$10
DISL06:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD		b,CATHDLY
DISL07:		DJNZ	DISL07
			XOR		a
			OUT		(CATHPORT),a
			RR		c
			LD		hl,(ADDRESS)
			LD		a,(hl)
			LD		(SCRATCH),a
			XOR		a
			LD		hl,SCRATCH
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		nz,DISL08
			OR		$10
DISL08:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD		b,CATHDLY
DISL09:		DJNZ	DISL09
			XOR		a
			OUT		(CATHPORT),a
			RR		c
			RLD
			LD		ix,HEX2SEG
			LD		d,$00
			LD		e,a
			ADD		ix,de
			LD		a,(ix)
			PUSH	hl
			LD		hl,MODE
			BIT		0,(hl)
			JP		nz,DISL0A
			OR		$10
DISL0A:		POP		hl
			OUT		(SEGPORT),a
			LD		a,c
			OUT		(CATHPORT),a
			LD		b,CATHDLY
DISL0B:		DJNZ	DISL0B
			RET
;
KEYBOARD:	PUSH	hl ; Key decoder routine.
			PUSH	af
			LD		hl,$0030
			LD		(BEEPLENGTH),hl
			LD		hl,BEEPFREQ
			LD		(hl),$30
			LD		hl,KEYDATA
			LD		a,$FF
			CP		(hl)
			JP		z,KEYLXX
			CALL	BEEP
			LD		a,(hl)
			AND		$3f ; We only want the first 6 bits.
			XOR		$20 ; Flip bit 6 (Shift key) because it gives a 1 when not being pressed.
;
			CP		$10 ; + key.
			JP		nz,KEYL00
			LD		hl,(ADDRESS)
			INC		hl
			LD		(ADDRESS),hl
			LD		hl,MODE
			RES		0,(hl)
			RES		1,(hl)
			RES		2,(hl)
			JP		KEYLXX
;
KEYL00:		CP		$11 ; - key.
			JP		nz,KEYL01
			LD		hl,(ADDRESS)
			DEC		hl
			LD		(ADDRESS),hl
			LD		hl,MODE
			RES		0,(hl)
			RES		1,(hl)
			RES		2,(hl)
			JP		KEYLXX
;
KEYL01:		CP		$12 ; GO key.
			JP		nz,KEYL02
			LD		sp,STACKTOP
			LD		hl,(ADDRESS)
			JP		(hl)
;
KEYL02:		CP		$13 ; AD key.
			JP		nz,KEYL03
			LD		b,a
			LD		a,(MODE)
			XOR		$01
			RES		1,a
			RES		2,a
			LD		(MODE),a
			LD		a,b
			JP		KEYLXX
;
KEYL03:		CP		$20 ; Shift-0 key.
			JP		nz,KEYL04
			PUSH	af
			PUSH	hl
			CALL	MOD01
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL04:		CP		$21 ; Shift-1 key.
			JP		nz,KEYL05
			PUSH	af
			PUSH	hl
			CALL	MOD02
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL05:		CP		$22 ; Shift-2 key.
			JP		nz,KEYL06
			PUSH	af
			PUSH	hl
			CALL	MOD03
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL06:		CP		$23 ; Shift-3 key.
			JP		nz,KEYL07
			PUSH	af
			PUSH	hl
			CALL	MOD04
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL07:		CP		$24 ; Shift-4 key.
			JP		nz,KEYL08
			PUSH	af
			PUSH	hl
			CALL	MOD05
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL08:		CP		$25 ; Shift-5 key.
			JP		nz,KEYL09
			PUSH	af
			PUSH	hl
			CALL	MOD06
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL09:		CP		$26 ; Shift-6 key.
			JP		nz,KEYL0A
			PUSH	af
			PUSH	hl
			CALL	MOD07
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0A:		CP		$27 ; Shift-7 key.
			JP		nz,KEYL0B
			PUSH	af
			PUSH	hl
			CALL	MOD08
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0B:		CP		$28 ; Shift-8 key.
			JP		nz,KEYL0C
			PUSH	af
			PUSH	hl
			CALL	MOD09
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0C:		CP		$29 ; Shift-9 key.
			JP		nz,KEYL0D
			PUSH	af
			PUSH	hl
			CALL	MOD0A
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0D:		CP		$2A ; Shift-A key.
			JP		nz,KEYL0E
			PUSH	af
			PUSH	hl
			CALL	MOD0B
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0E:		CP		$2B ; Shift-B key.
			JP		nz,KEYL0F
			PUSH	af
			PUSH	hl
			CALL	MOD0C
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL0F:		CP		$2C ; Shift-C key.
			JP		nz,KEYL10
			PUSH	af
			PUSH	hl
			CALL	MOD0D
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL10:		CP		$2D ; Shift-D key.
			JP		nz,KEYL11
			PUSH	af
			PUSH	hl
			CALL	MOD0E
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL11:		CP		$2E ; Shift-E key.
			JP		nz,KEYL12
			PUSH	af
			PUSH	hl
			CALL	MOD0F
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL12:		CP		$2F ; Shift-F key.
			JP		nz,KEYL13
			PUSH	af
			PUSH	hl
			CALL	MOD10
			POP		hl
			POP		af
			JP		KEYLXX
;
KEYL13:		CP		$30 ; Shift-+ key.
			JP		nz,KEYL14
			LD		hl,RAMTOP
			LD		de,(ADDRESS)
			SBC		hl,de
			LD		b,h
			LD		c,l
			LD		hl,RAMTOP
			LD		d,h
			LD		e,l
			DEC		hl
			LDDR
			LD		h,d
			LD		l,e
			LD		(hl),$00
			LD		hl,MODE
			RES		1,(hl)
			RES		2,(hl)
			JP		KEYLXX
;
KEYL14:		CP		$31 ; Shift-- key.
			JP		nz,KEYL15
			LD		hl,RAMTOP
			LD		de,(ADDRESS)
			SBC		hl,de
			LD		b,h
			LD		c,l
			LD		hl,(ADDRESS)
			LD		d,h
			LD		e,l
			INC		hl
			LDIR
			LD		h,d
			LD		l,e
			LD		(hl),$00
			LD		hl,MODE
			RES		1,(hl)
			RES		2,(hl)
			JP		KEYLXX
;
KEYL15:		CP		$32 ; Shift-GO key.
			JP		z,KEYLXX
KEYL16:		CP		$33 ; Shift-AD key.
			JP		z,KEYLXX
;
KEYL17:		LD		hl,MODE ; Non-shifted digit keys entry.
			BIT		0,(hl) ; 0 = Data Mode, 1 = Address Mode.
			JP		nz,KEYL19
			BIT		1,(hl)
			JP		z,KEYL17B ; Jump on 1st time through a data edit.
			BIT		2,(hl)
			JP		z,KEYL17A ; Jump on 2nd time through a data edit.
			RES		1,(hl) ; Do this the 3rd time round a data edit.
			RES		2,(hl)
			LD		hl,(ADDRESS)
			INC		hl
			LD		(ADDRESS),hl
			LD		hl,MODE
			JP		KEYL17B
KEYL17A:	SET		2,(hl)
KEYL17B:	BIT		1,(hl) ; 0 = first nibble, 1 = second nibble.
			JP		nz,KEYL18
			SET		1,(hl)
			LD		hl,(ADDRESS)
			LD		(hl),$00
;
KEYL18:		LD		hl,(ADDRESS)
			RLD
KEYL18A:	JP		KEYLXX
;
KEYL19:		BIT		1,(hl) ; 0 = first nibble, 1 = subsequent nibbles.
			JP		nz,KEYL1A
			SET		1,(hl)
			LD		hl,$0000
			LD		(ADDRESS),hl
;
KEYL1A:		LD		hl,ADDRESS
			RLD
			LD		hl,(ADDRESS)
			SLA		h
			SLA		h
			SLA		h
			SLA		h
			LD		b,a
			XOR		a
			OR		h
			OR		b
			LD		h,a
			LD		(ADDRESS),hl
;
KEYLXX:		LD		hl,KEYDATA ; Done with the key decoder.
			LD		(hl),$FF
			POP		af
			POP		hl
			RET
;
BEEP:		PUSH	hl
			PUSH	af
			LD		hl,BEEPFREQ
			LD		c,(hl)
			LD		hl,(BEEPLENGTH)
			XOR		a
			LD		d,a
BEEPL01:	LD		b,c
			LD		a,d
			OUT		(CATHPORT),a
BEEPL02:	DJNZ	BEEPL02
			XOR		$80
			DEC		hl
			LD		d,a
			LD		a,h
			OR		l
			JP		nz,BEEPL01
			POP		af
			POP		hl
			RET
;
STARTBEEP:	PUSH	hl
			PUSH	af
			LD		hl,$007F
			LD		(BEEPLENGTH),hl
			LD		hl,BEEPFREQ
			LD		(hl),$35
			CALL	BEEP
			LD		(hl),$30
			CALL	BEEP
			LD		(hl),$25
			CALL	BEEP
			LD		(hl),$20
			CALL	BEEP
			POP		af
			POP		hl
			RET
;			
SETUP:		LD		sp,STACKTOP ; Post reset/power up setup.
			LD		hl,RAMBASE
			LD		(ADDRESS),hl
			XOR		a
			LD		(MODE),a
			LD		a,$FF
			LD		(KEYDATA),a
			CALL	STARTBEEP
;
MAIN:		CALL	DISPLAY
			CALL	KEYBOARD
			JP		MAIN
;
HEX2SEG:	.DB		$EB,$28,$CD,$AD,$2E,$A7,$E7,$29 ; HEX Byte to LED Segment conversion.
			.DB		$EF,$2F,$6F,$E6,$C3,$EC,$C7,$47
;
; BEGIN MODULES.
; START MOD-01 - xxxxx.
MOD01:		RET
; END MOD-01
;
; START MOD-02 - xxxxx.
MOD02:		RET
; END MOD-02
;
; START MOD-03 - xxxxx.
MOD03:		RET
; END MOD-03
;
; START MOD-04 - xxxxx.
MOD04:		RET
; END MOD-04
;
; START MOD-05 - xxxxx.
MOD05:		RET
; END MOD-05
;
; START MOD-06 - xxxxx.
MOD06:		RET
; END MOD-06
;
; START MOD-07 - xxxxx.
MOD07:		RET
; END MOD-07
;
; START MOD-08 - xxxxx.
MOD08:		RET
; END MOD-08
;
; START MOD-09 - xxxxx.
MOD09:		RET
; END MOD-09
;
; START MOD-0A - xxxxx.
MOD0A:		RET
; END MOD-0A
;
; START MOD-0B - xxxxx.
MOD0B:		RET
; END MOD-0B
;
; START MOD-0C - xxxxx.
MOD0C:		RET
; END MOD-0C
;
; START MOD-0D - xxxxx.
MOD0D:		RET
; END MOD-0D
;
; START MOD-0E - xxxxx.
MOD0E:		RET
; END MOD-0E
;
; START MOD-0F - xxxxx.
MOD0F:		RET
; END MOD-0F
;
; START MOD-10 - xxxxx.
MOD10:		RET
; END MOD-10
;
; END MODULES.
;
			.END
