Pause_Init:
      moveq #0x8, d0
      jsr WaitFrames                                                           ; Wait a frame, to collect new joypad presses
      lea PauseString, a0                                                      ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0810, d1                                                       ; XY (08, 16)
      moveq #0x0, d2                                                           ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine
      move.w  #0x05, game_state                                                ; store the game state
      rts