[BITS 16] ; 16 bit mode
[ORG 0x7C00] ; origin of the code


mov si, BootString ; move the string to SI register
call Printstr ; call the print string procedure
JMP $ ; infinite loop

; Procedure to print a character, Assume that the ASCII value is in register AL
PrintCharacter:
    mov ah, 0x0E    ; Tell the BIOS that we need to print a charater on screen
    mov bh, 0x00    ; Page no.
    mov bl, 0x07    ; Text attribute 0x07 = Lightgrey

    int 0x10        ; Call the BIOS interrupt 0x10
    ret             ; Return from the procedure

; Procedure to print a string, Assume the string starting pointer is in register SI
Printstr:
    ; Print a character
    NextCharacter:
        mov al, [si]            ; Move the character from memory to AL register
        inc si                  ; Increment SI to point to next character
        or al, al               ; Check if value in AL is zero (end of string)
        jz Return               ; If end of string, return
        CALL PrintCharacter     ; Else, Print the character
        jmp NextCharacter       ; Print next character
        Return:                 ; Return from the procedure
            ret                 ; Return from the procedure


BootString db 'Boot Successful', 0 ; null terminated string to be printed

times 510 - ($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0xAA55 ; Boot signature
