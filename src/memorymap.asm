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
    rsset 0x00FF0000
hblank_counter          rs.l 1                                         ; Start of RAM
vgm_start        	    equ 0x00FF1000
vgm_current      	    equ 0x00FF1006
vblank_counter          rs.l 1
audio_clock             rs.l 1
joypadA			rs.w 1
joypadA_press		rs.w 1
joypadB			rs.w 1
joypadB_press		rs.w 1

; ************************************
; Game globals
; ************************************
game_state               rs.w 1
score                    rs.w 1
combo                    rs.w 1
multiplier               rs.w 1
scoredelta               rs.w 1
rockindicator_position_x rs.w 1
tempo                    rs.w 1
repeat_counter           rs.w 1
greennote_position_y     rs.w 1
rednote_position_y       rs.w 1
yellownote_position_y    rs.w 1
bluenote_position_y      rs.w 1
orangenote_position_y    rs.w 1

__ramend                 rs.b 0