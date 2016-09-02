; Clownacy's frame-accurate Mega Drive VGM 1.50 player

; PlayVGM
;
; Input:
;  a0 - Absolute address of VGM file
;  d0 - Number of times for VGM file to loop (-1 = loop indefinitely)
; Output:
;  a0/d0/d1 - Trashed

PlayVGM:
	; Perform some sanity checks
	cmpi.l	#"Vgm ",(a0)	; Check for VGM identifier
	bne.s	.exit		; If it's not there, this isn't a VGM file
	cmpi.l	#$50010000,8(a0)	; (00000150 in little-endian) Check if VGM version is 1.50
	bne.s	.exit		; If not, song may be incompatible
	; Store loop counter
	move.w	d0,(VGMPlayer_LoopCounter).l
	; Get and store address of VGM stream
	move.l	$34(a0),d0
	bsr.s	.swap_endian_32bit
	lea	$34(a0,d1.w),a0
	move.l	a0,(VGMPlayer_StreamStartAddress).l
	move.l	a0,(VGMPlayer_StreamCurrentAddress).l
	rts

; Returns endian-swapped 32-bit value in d1
.swap_endian_32bit:
	move.w	d0,d1
	swap	d0
	ror.w	#8,d0
	ror.w	#8,d1
	swap	d1
	move.w	d0,d1
	rts

; UpdateVGMPlayer
;
; Input:
;  None
; Output:
;  a0/a1/d0 - Trashed

UpdateVGMPlayer:
	lea	(VGMPlayer_RAM).l,a1
	; Check if a song is playing
	tst.l	VGMPlayer_StreamStartAddress-VGMPlayer_RAM(a1)
	beq.s	.exit

	movea.l	VGMPlayer_StreamCurrentAddress-VGMPlayer_RAM(a1),a0

.stream_loop:
	move.b	(a0)+,d0
	cmpi.b	#$50,d0	; 'Update PSG' command
	beq.s	.update_PSG
	cmpi.b	#$52,d0	; 'Update FM port 0' command
	beq.s	.update_FM_port_0
	cmpi.b	#$53,d0	; 'Update FM port 1' command
	beq.s	.update_FM_port_1
	cmpi.b	#$61,d0	; 'Wait n samples' command
	beq.s	.wait_n_samples
	cmpi.b	#$62,d0	; 'Wait 735 samples' command
	beq.s	.wait_until_next_frame
	cmpi.b	#$63,d0	; 'Wait 882 samples' command
	beq.s	.wait_882_samples
	cmpi.b	#$66,d0	; 'End of VGM stream' command
	beq.s	.end_of_VGM_stream
	; Invalid command: get next command
	bra.s	.stream_loop

.wait_until_next_frame:
	move.l	a0,VGMPlayer_StreamCurrentAddress-VGMPlayer_RAM(a1)
.exit:
	rts

.update_PSG:
	move.b	(a0)+,($C00011).l
	bra.s	.stream_loop

.update_FM_port_0:
	bsr.s	.wait_for_YM2612
	move.b	(a0)+,($A04000).l
	bsr.s	.wait_for_YM2612
	move.b	(a0)+,($A04001).l
	bra.s	.stream_loop

.update_FM_port_1:
	bsr.s	.wait_for_YM2612
	move.b	(a0)+,($A04002).l
	bsr.s	.wait_for_YM2612
	move.b	(a0)+,($A04003).l
	bra.s	.stream_loop

.wait_n_samples:
	; Get big-endian wait counter (may be on odd address, so we have to do this the hard way)
	move.b	(a0)+,d0
	lsl.w	#8,d0
	move.b	(a0)+,d0
	ror.w	#8,d0
	bra.s	.add_to_sample_delay_counter

.wait_882_samples:
	move.w	#882,d0
	; fall through to .add_to_sample_delay_counter...

.add_to_sample_delay_counter:
	; Check if a frame's worth of delay has accumulated and,
	; if so, wait until next frame
	add.w	d0,VGMPlayer_DelayCounter-VGMPlayer_RAM(a1)
	cmpi.w	#$2DF,VGMPlayer_DelayCounter-VGMPlayer_RAM(a1)	; $2DF = 1 60th of a second
	bls.s	.stream_loop
	subi.w	#$2DF,VGMPlayer_DelayCounter-VGMPlayer_RAM(a1)
	bra.s	.wait_until_next_frame

.end_of_VGM_stream:
	; TODO: Silence FM

	; Silence PSG
	lea	($C00011).l,a0
	move.b	#$9F,(a0)	; Set PSG 1 attenuation to $F (volume = 0)
	move.b	#$BF,(a0)	; Set PSG 2 attenuation to $F (volume = 0)
	move.b	#$DF,(a0)	; Set PSG 3 attenuation to $F (volume = 0)
	move.b	#$FF,(a0)	; Set PSG Noise attenuation to $F (volume = 0)

	cmpi.w	#-1,VGMPlayer_LoopCounter-VGMPlayer_RAM(a1)	; -1 = loop forever
	beq.s	.loopVGM
	subq.w	#1,VGMPlayer_LoopCounter-VGMPlayer_RAM(a1)
	bcc.s	.loopVGM
;.endVGM:
	moveq	#0,d0
	move.l	d0,VGMPlayer_StreamStartAddress-VGMPlayer_RAM(a1)
	move.w	d0,VGMPlayer_DelayCounter-VGMPlayer_RAM(a1)
	rts
.loopVGM:
	movea.l	VGMPlayer_StreamStartAddress-VGMPlayer_RAM(a1),a0
	bra.w	.stream_loop

.wait_for_YM2612:
	tst.b	($A04000).l
	bmi.s	.wait_for_YM2612
	rts
