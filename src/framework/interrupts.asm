;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   interpts.asm - Interrupts and exceptions
;==============================================================

HBlankInterrupt:
   addi.l #0x1, hblank_counter    ; Increment hinterrupt counter
   rte

VBlankInterrupt:
   ; Backup registers
   movem.l d0-a7,-(sp)

   ; Cache Joypad inputs
   jsr ReadPadA
   move.w d0, joypadA
   jsr ReadPadB
   move.w d0, joypadB

   addi.l #0x1, vblank_counter    ; Increment vinterrupt counter
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE

   ; Restore registers
   movem.l (sp)+,d0-a7
   rte

Exception:
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE
   stop #$2700 ; Halt CPU
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE
   jmp Exception
   rte

NullInterrupt:
   rte
