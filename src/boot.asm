

mov si, BootString ; Move the boot string the string to SI register
call Printstr ; call the print string procedure
JMP $ ; infinite loop

%include "strings.asm"
%include "print.asm"

times 510 - ($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0xAA55 ; Boot signature