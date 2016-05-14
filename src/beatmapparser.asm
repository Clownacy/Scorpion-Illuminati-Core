; ==============================================================
; Reads a beatmap
; a0 - beatmap address
; d0 - beatmap data
; beatmap format:
; 76543210
; Bit 7 - if set it is the end of the beatmap
; Bit 6 - Not Used
; Bit 5 - Not Used
; Bit 4 - if set green note should be placed on board
; Bit 3 - if set red note should be placed on board
; Bit 2 - if set yellow note should be placed on board
; Bit 1 - if set blue note should be placed on board
; Bit 0 - if set orange note should be placed board
; ==============================================================
ReadBeatmap:
   move.b (a0), d0                                                             ; move beatmap data into d0
   btst #7, d0                                                                 ; test bit 7 to see if set
   bne.s @NotEndofBeatmap                                                      ; if not set skip
   moveq #64, d0                                                               ; clear all irrevelant bits
@NotEndofBeatmap:
   rts