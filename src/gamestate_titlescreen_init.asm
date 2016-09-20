TitleScreen_Init:
      moveq #0x1, d0
      jsr WaitFrames ; Wait a frame, to collect new joypad presses
      ; ************************************
      ; Load title screen map
      ; ************************************
      lea TitleScreenMap, a0                                                   ; Map data in a0
      move.w #TitleScreenMapSizeW, d0                                          ; Size (words) in d0
      moveq #0x0, d1                                                           ; Y offset in d1
      move.w #TitleScreenTilesTileID, d2                                       ; First tile ID in d2
      moveq #0x0, d3                                                           ; Palette ID in d3
      jsr LoadMapPlaneA                                                        ; Jump to subroutine
      move.w  #0x01, game_state                                                ; store the game state
      rts