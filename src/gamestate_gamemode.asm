GameMode:
      move.w joypadA, d0                                                             ; Read pad 1 state, result in d0
      move.w #(note_plane_safearea_offset+note_bounds_top), d2                 ; fret safe area offset in d2
      move.w (score), d3                                                       ; player's score into d3
      move.w (scoredelta), d4
      move.w (combo), d5                                                       ; player's current combo
      moveq #1, d6                                                             ; combo increment

      ; start of green note code
      move.w (greennote_position_y), d1                                        ; green note position in d1
      btst #pad_button_left, d0                                                ; Check left pad
      bne.s @NoLeft                                                            ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt.s @GreenNoteSafeArea                                                 ; if so then don't accept it
      move.w #note_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
      abcd d6, d5                                                              ; increment the player's combo meter
      bra @GreenNoteDone                                                       ; continue through the rest of the code
@GreenNoteSafeArea:
@GreenNoteDone:
@NoLeft:
      ; green note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the fret entirely
      blt.s @GreenNoteNotWithinBounds                                          ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the arrow back to the top
      moveq #0, d5                                                             ; player played missed the note so reset the player's combo
@GreenNoteNotWithinBounds:
      move.w d1, (greennote_position_y)                                        ; set the left arrow's position normally

      ; start of red note code
      move.w (rednote_position_y), d1                                          ; red note position in d1
      btst #pad_button_right, d0                                               ; Check right pad
      bne.s @NoRight                                                           ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt.s @RedNoteSafeArea                                                   ; if so then don't accept it
      move.w #note_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
      abcd d6, d5                                                              ; increment the the player's combo meter
      bra @RedNoteDone                                                         ; continue through the rest of the code
@RedNoteSafeArea:
@RedNoteDone:
@NoRight:
      ; red note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt.s @RedNoteNotWithinBounds                                            ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
      moveq #0, d5                                                             ; player played missed the note so reset the player's combo
@RedNoteNotWithinBounds:
      move.w d1, (rednote_position_y)                                          ; set the red note's position normally
 
      ; start of yellow note code
      move.w (yellownote_position_y), d1                                       ; yellow note position in d1
      btst #pad_button_A, d0                                                   ; Check A button
      bne.s @NoA                                                               ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt.s @YellowNoteSafeArea                                                ; if so then don't accept it
      move.w #note_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
      abcd d6, d5                                                              ; increment the player's combo meter
      bra @YellowNoteDone                                                      ; continue through the rest of the code
@YellowNoteSafeArea:
@YellowNoteDone:
@NoA:
      ; yellow note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt.s @YellowNoteNotWithinBounds                                         ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
      moveq #0, d5                                                             ; player played missed the note so reset the player's combo
@YellowNoteNotWithinBounds:
      move.w d1, (yellownote_position_y)                                       ; set the yellow note's position normally

      ; start of blue note code
      move.w (bluenote_position_y), d1                                         ; blue note position in d1
      btst #pad_button_B, d0                                                   ; Check B button
      bne.s @NoB                                                               ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt.s @BlueNoteSafeArea                                                  ; if so then don't accept it
      move.w #note_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
      abcd d6, d5                                                              ; increment the player's combo meter
      bra @BlueNoteDone                                                        ; continue through the rest of the code
@BlueNoteSafeArea:
@BlueNoteDone:
@NoB:
      ; blue note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt.s @BlueNoteNotWithinBounds                                           ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
      moveq #0, d5                                                             ; player played missed the note so reset the player's combo
@BlueNoteNotWithinBounds:
      move.w d1, (bluenote_position_y)                                         ; set the blue note's position normally

      ; start of orange note code
      move.w (orangenote_position_y), d1                                       ; orange note position in d1
      btst #pad_button_C, d0                                                   ; Check C button
      bne.s @NoC                                                               ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt.s @OrangeNoteSafeArea                                                ; if so then don't accept it
      move.w #note_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
      abcd d6, d5                                                              ; increment the player's combo meter
      bra @OrangeNoteDone                                                      ; continue through the rest of the code
@OrangeNoteSafeArea:
@OrangeNoteDone:
@NoC:
      ; orange note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt.s @OrangeNoteNotWithinBounds                                         ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
      moveq #0, d5                                                             ; player played missed the note so reset the player's combo
@OrangeNoteNotWithinBounds:
      move.w d1, (orangenote_position_y)                                       ; set the orange note's position normally

      cmp.w #$9, d5                                                            ; have the player reached a combo of 10
      bgt.s @SkipX1Multiplier                                                  ; if not then branch to next step
      move.w #1, (multiplier)                                                  ; set the multiplier to 1
      move.w #1, d4                                                            ; set score delta to 1
@SkipX1Multiplier:
      cmp.w #$10, d5                                                           ; has the player reached a combo of 10
      blt.s @SkipX2Multiplier                                                  ; if not then branch to the next step
      move.w #2, (multiplier)                                                  ; set the multiplier to 2
      move.w #2, d4                                                            ; set score delta to 2
@SkipX2Multiplier:
      cmp.w #$20, d5                                                           ; have the player reached a combo of 20
      blt.s @SkipX3Multiplier                                                  ; if not then branch to the next step
      move.w #3, (multiplier)                                                  ; set the multiplier to 3 
      move.w #3, d4                                                            ; set score delta to 3
@SkipX3Multiplier:
      cmp.w #$30, d5                                                           ; have the player reached a combo of 30
      blt.s @SkipX4Multiplier                                                  ; if not then branch to the next step
      move.w #4, (multiplier)                                                  ; set the multiplier to 4 
      move.w #4, d4                                                            ; set score delta to 4
@SkipX4Multiplier:

      move.w d3, (score)                                                       ; save the player's score
      move.w d4, (scoredelta)                                                  ; save the score delta
      move.w d5, (combo)                                                       ; save the player's combo

      jsr WaitVBlankStart                                                      ; Wait for start of vblank

      move.w (repeat_counter), d0
      bsr music_driver                                                         ; play some tunes
      move.w d0, (repeat_counter)

      lea -$4(sp), sp                                                          ; load effective address of stack pointer
      move.l sp, a0                                                            ; allocate temporary buffer on stack

      ; draw the score counter
      move.l sp, a0                                                            ; String to a0
      move.w (score), d0                                                       ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x0901, d1                                                       ; Position to d1
      moveq #0x0, d2                                                           ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      ; draw the combo counter

      move.l sp, a0                                                            ; String to a0
      move.w (combo), d0                                                       ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x2201, d1                                                       ; Position to d1
      moveq #0x0, d2                                                           ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      ; draw the multiplier counter

      move.l sp, a0                                                            ; String to a0
      move.w (multiplier), d0                                                  ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x0419, d1                                                       ; Position to d1
      moveq #0x0, d2                                                           ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      lea $4(sp), sp                                                          ; free allocated temporary buffer

      ; ************************************
      ;  Draw The Multiplier String
      ; ************************************
      lea MultiplierString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0419, d1                                                       ; XY (03, 24)
      moveq #0x0, d2                                                           ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; Set green fret's position
      move.w #greennote_id, d0                                                 ; green fret's sprite id
      move.w #greennote_start_position_x, d1                                   ; green fret's x position
      move.w #GreenNoteDimensions, d2                                          ; green fret's dimensions
      moveq #0x8, d3                                                           ; green fret's width in pixels
      moveq #0x0, d4                                                           ; green fret's x flipped
      lea GreenNoteSubSpriteDimensions, a1                                     ; green fret's subsprite 
      jsr SetSpritePosX                                                        ; Set green fret's x position

      move.w #greennote_id, d0                                                 ; left arrow's sprite id
      move.w (greennote_position_y), d1                                        ; left arrow's y position
      jsr SetSpritePosY                                                        ; Set left arrow's y position

      ; Set red note's position
      move.w #rednote_id, d0                                                   ; red note's sprite id
      move.w #rednote_start_position_x, d1                                     ; red note's x position
      jsr SetSpritePosX                                                        ; Set red fret's x position

      move.w #rednote_id, d0                                                   ; red note's sprite id
      move.w (rednote_position_y), d1                                          ; red note's y position
      jsr SetSpritePosY                                                        ; Set red note's y position

      ; Set yellow note's position
      move.w #yellownote_id, d0                                                ; yellow note's sprite id
      move.w #yellownote_start_position_x, d1                                  ; yellow note's x position
      jsr SetSpritePosX                                                        ; Set yellow note's x position

      move.w #yellownote_id, d0                                                ; yellow note's sprite id
      move.w (yellownote_position_y), d1                                       ; yellow note's y position
      jsr SetSpritePosY                                                        ; Set yellow note's y position

      ; Set blue note's position
      move.w #bluenote_id, d0                                                  ; blue note's sprite id
      move.w #bluenote_start_position_x, d1                                    ; blue note's x position
      jsr SetSpritePosX                                                        ; Set blue note's x position

      move.w #bluenote_id, d0                                                  ; blue note's sprite id
      move.w (bluenote_position_y), d1                                         ; blue's y position
      jsr SetSpritePosY                                                        ; Set blue note's y position

      ; Set orange note's position
      move.w #orangenote_id, d0                                                ; orange note's sprite id
      move.w #orangenote_start_position_x, d1                                  ; orange note's x position
      jsr SetSpritePosX                                                        ; Set orange note's x position

      move.w #orangenote_id, d0                                                ; orange note's sprite id
      move.w (orangenote_position_y), d1                                       ; orange's y position
      jsr SetSpritePosY                                                        ; Set orange note's y position

      ; Set rock indicator's position
      move.w #rockindicator_id, d0                                             ; rock indicator's sprite id
      move.w (rockindicator_position_x), d1                                    ; rock indicator's x position
      jsr SetSpritePosX                                                        ; Set rock indicator's x position

      move.w #rockindicator_id, d0                                             ; rock indicator's sprite id
      move.w #rockindicator_start_position_y, d1                               ; rock indicator's y position
      jsr SetSpritePosY                                                        ; Set rock indicator's y position

      jsr WaitVBlankEnd                                                        ; Wait for end of vblank
      rts