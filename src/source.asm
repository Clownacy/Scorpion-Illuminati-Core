;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

      ; Include SEGA Genesis ROM header and CPU vector table
      include 'header.asm'

      ; include framework code
      include 'framework\init.asm'
      include 'framework\collision.asm'
      include 'framework\debugger.asm'                                         ; NOT FOR RELEASE
      include 'framework\gamepad.asm'
      include 'framework\interrupts.asm'
      include 'framework\megacd.asm'
      include 'framework\memory.asm'
      include 'framework\psg.asm'
      include 'framework\sprites.asm'
      include 'framework\text.asm'
      include 'framework\timing.asm'
      include 'framework\tmss.asm'
      include 'framework\palettes.asm'
      include 'framework\planes.asm'
      include 'framework\utility.asm'
      include 'framework\vdp.asm'
      include 'framework\z80.asm'
      include 'framework\music_driver.asm'
      include 'gamestate_titlescreen_init.asm'
      include 'gamestate_titlescreen.asm'
      include 'gamestate_gamemode_init.asm'
      include 'gamestate_gamemode.asm'
      include 'gamestate_gamemode_pause_init.asm'
      include 'gamestate_gamemode_pause.asm'

__main:

      ; ************************************
      ; Load palettes
      ; ************************************
	  lea Palette, a0                                                        ; Move Palette address to a0
	  moveq #0x0, d0                                                         ; Palette ID in d0
	  jsr LoadPalette                                                        ; Jump to subroutine

      ; ************************************
      ;  Load the Pixel Font
      ; ************************************
      lea PixelFont, a0                                                        ; Move font address to a0
      move.l #PixelFontVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #PixelFontSizeT, d1                                               ; Move number of characters (font size in tiles) to d1
      jsr LoadFont                                                             ; Jump to subroutine

      ; *************************************
      ; Load the green note sprite
      ; *************************************
      lea GreenNote, a0                                                        ; Move sprite address to a0
      move.l #GreenNoteVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #GreenNoteSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the red note sprite
      ; *************************************
      lea RedNote, a0                                                          ; Move sprite address to a0
      move.l #RedNoteVRAM, d0                                                  ; Move VRAM dest address to d0
      move.l #RedNoteSizeT, d1                                                 ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the yellow note sprite
      ; *************************************
      lea YellowNote, a0                                                       ; Move sprite address to a0
      move.l #YellowNoteVRAM, d0                                               ; Move VRAM dest address to d0
      move.l #YellowNoteSizeT, d1                                              ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the blue note sprite
      ; *************************************
      lea BlueNote, a0                                                         ; Move sprite address to a0
      move.l #BlueNoteVRAM, d0                                                 ; Move VRAM dest address to d0
      move.l #BlueNoteSizeT, d1                                                ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the orange note sprite
      ; *************************************
      lea OrangeNote, a0                                                       ; Move sprite address to a0
      move.l #OrangeNoteVRAM, d0                                               ; Move VRAM dest address to d0
      move.l #OrangeNoteSizeT, d1                                              ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the rock indicator sprite
      ; *************************************
      lea RockIndicator, a0                                                    ; Move sprite address to a0
      move.l #RockIndicatorVRAM, d0                                            ; Move VRAM dest address to d0
      move.l #RockIndicatorSizeT, d1                                           ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load sprite descriptors
      ; ************************************
      lea sprite_descriptor_table, a0                                          ; Sprite table data
      move.w #number_of_sprites, d0                                            ; 5 sprites
      jsr LoadSpriteTables

      ; ************************************
      ; Load title screen map tiles
      ; ************************************
      lea TitleScreenTiles, a0                                                 ; Move sprite address to a0
      move.l #TitleScreenTilesVRAM, d0                                         ; Move VRAM dest address to d0
      move.l #TitleScreenTilesSizeT, d1                                        ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load game map tiles
      ; ************************************
      lea GameTiles, a0                                                        ; Move sprite address to a0
      move.l #GameTilesVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #GameTilesSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load music
      ; ************************************
      lea (song1)+64,a0                                                        ; song data address in a0
      move.l a0,vgm_current                                                    ; address of current song
      move.l a0,vgm_start                                                      ; start of song address
      move.w #$100,($A11100)                                                   ; z80 bus request
      move.w #$100,($A11200)                                                   ; z80 reset

      ; ************************************
      ; One Time Inits
      ; ************************************
      move.w #game_state_title_screen_initalize, (game_state)                  ; set the game state

      ; ******************************************************************
      ; Main game loop
      ; ******************************************************************
GameLoop:

      moveq   #0,d1                                                             ; clear d1
      move.w  game_state,d1                                                     ; get game state on d1
      add.w   d1,d1                                                             ; multiply ID by 2 (if d1 = 1 -> d1 = 2)
      add.w   d1,d1                                                             ; multiply previous by 2 (if d1 = 2 -> d1 = 4)
      jsr     @index(pc,d1.w)                                                   ; jump to @index addr + d1
      bra     GameLoop

@index:
      bra.w   TitleScreen_Init                                                 ; (0)
      bra.w   TitleScreen                                                      ; (1)
      bra.w   GameMode_Init                                                    ; (2)
      bra.w   GameMode                                                         ; (3)
      bra.w   Pause_Init                                                       ; (4)
      bra.w   Pause                                                            ; (5)

      jsr WaitVBlankEnd                                                        ; Wait for end of vblank

      jmp GameLoop                                                             ; Back to the top

      ; ************************************
      ; Data
      ; ************************************

      ; Include framework data
      include 'framework\initdata.asm'
      include 'framework\globals.asm'
      include 'framework\charactermap.asm'

      ; Include game data
      include 'globals.asm'
      include 'memorymap.asm'

      ; Include game art
      include 'assets\assetsmap.asm'
	include 'spritedescriptors.asm'

__end                                                                          ; Very last line, end of ROM address

      inform 0, "*********************"                                        ; start of binary statistics header
      inform 0, "* Binary Statistics *"                                        ; binary statistics header
      inform 0, "*********************"                                        ; end of binary statistics header
      inform 0, ""                                                             ; spacer
      inform 0, "*********************"                                        ; start of rom usage header
      inform 0, "*     Rom Usage     *"                                        ; rom usage header
      inform 0, "*********************"                                        ; end of rom usage header
      inform 0,"%d bytes used", __end-$200                                     ; number of bytes used in cartridge space
      inform 0,"%d bytes left", $400000-__end                                  ; number of bytes remaining in cartridge space
      inform 0, ""                                                             ; spacer
      inform 0, "*********************"                                        ; start of ram usage header
      inform 0, "*     Ram Usage     *"                                        ; ram usage header
      inform 0, "*********************"                                        ; end of ram usage header
      inform 0,"%d bytes of ram used", __ramend-$FF0000                        ; number of bytes used in ram space
      inform 0,"%d bytes of ram left", $FFFFFF-__ramend                        ; number of bytes remaining in ram space