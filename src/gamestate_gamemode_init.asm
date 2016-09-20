GameMode_Init:
      moveq #0x1, d0
      jsr WaitFrames ; Wait a frame, to collect new joypad presses
      ; ************************************
      ; Load game map
      ; ************************************
      lea GameMap, a0                                                          ; Map data in a0
      move.w #GameMapSizeW, d0                                                 ; Size (words) in d0
      moveq #0x0, d1                                                           ; Y offset in d1
      move.w #GameTilesTileID, d2                                              ; First tile ID in d2
      moveq #0x0, d3                                                           ; Palette ID in d3
      jsr LoadMapPlaneA                                                        ; Jump to subroutine
      ; ************************************
      ;  Draw The Score String
      ; ************************************
      lea ScoreString, a0                                                      ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0301, d1                                                       ; XY (5, 1)
      moveq #0x0, d2                                                           ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; ************************************
      ;  Draw The Combo String
      ; ************************************
      lea ComboString, a0                                                      ; String address
      move.w #0x1C01, d1                                                       ; XY (27, 1)
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine
      ; ************************************
      ; Initalize Everything
      ; ************************************
      move.w #0, (score)                                                       ; initialize score
      move.w #0, (combo)                                                       ; initialize combo
      move.w #1, (multiplier)                                                  ; initialize multiplier
      move.w #1, (scoredelta)                                                  ; initalize score delta
      move.w #1, (tempo)                                                       ; initialize tempo
      move.w #(note_start_position_y+$40), (greennote_position_y)              ; Set green note's y position
      move.w #(note_start_position_y+$30), (rednote_position_y)                ; Set red note's y position
      move.w #(note_start_position_y+$20), (yellownote_position_y)             ; Set yellow note's y position
      move.w #(note_start_position_y+$10), (bluenote_position_y)               ; Set blue note's y position
      move.w #note_start_position_y, (orangenote_position_y)                   ; Set orange note's y position
      move.w #rockindicator_start_position_x, (rockindicator_position_x)       ; Set rock indicator's x position
      move.w #0x03, game_state                                                 ; set game state to game mode
      rts