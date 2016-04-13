;==============================================================
;     Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; **********************************************
; Various size-ofs to make this easier/foolproof
; **********************************************
SizeByte:               equ 0x01
SizeWord:               equ 0x02
SizeLong:               equ 0x04
SizeSpriteDesc:         equ 0x08
SizeTile:               equ 0x20
SizePalette:            equ 0x40

; ************************************
; System stuff
; ************************************
hblank_counter          equ 0x00FF0000                                         ; Start of RAM
vgm_start        	    equ 0x00FF1000
vgm_current      	    equ 0x00FF1006
vblank_counter          equ (hblank_counter+SizeLong)
audio_clock             equ (vblank_counter+SizeLong)

; ************************************
; Game globals
; ************************************
score                    equ (audio_clock+SizeWord)
combo                    equ (score+SizeWord)
multiplier               equ (combo+SizeWord)
scoredelta               equ (multiplier+sizeWord)
rockindicator_position_x equ (scoredelta+SizeWord)
tempo                    equ (rockindicator_position_x+SizeWord)
repeat_counter           equ (tempo+SizeWord)
greennote_position_y     equ (repeat_counter+SizeWord)
rednote_position_y       equ (greennote_position_y+SizeWord)
yellownote_position_y    equ (rednote_position_y+SizeWord)
bluenote_position_y      equ (yellownote_position_y+SizeWord)
orangenote_position_y    equ (bluenote_position_y+SizeWord)