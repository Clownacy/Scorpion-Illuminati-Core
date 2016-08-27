TitleScreen:
      jsr ReadPadA                                                             ; Read pad 1 state, result in d0
      btst #pad_button_start, d0                                               ; Check start button
      bne.s TitleScreen                                                        ; if not then do the title screen
      move.w #0x2, game_state                                                  ; otherwise start a new game
      rts