Pause:
@PauseNoDecrementPadDelay:
      move.w joypadA_press, d0                                                       ; Read pad 1 state, result in d0
      btst #pad_button_start, d0                                               ; Check start button
      bne.s Pause                                                              ; if not then continue paused, otherwise clear the pause string...
      lea BlankString, a0                                                      ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0810, d1                                                       ; XY (08, 16)
      moveq #0x0, d2                                                           ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine
      move.w #0x3, game_state                                                  ; otherwise contine the game
      rts