TitleScreen_Init:
      ; ************************************
      ; Load title screen map tiles
      ; ************************************
      lea TitleScreenTiles, a0                                                 ; Move sprite address to a0
      move.l #TitleScreenTilesVRAM, d0                                         ; Move VRAM dest address to d0
      move.l #TitleScreenTilesSizeT, d1                                        ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

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