INCLUDE Irvine32.inc

.data
    packedDate  dw  0110101110001011b   ; Example 16-bit packed date
    day         db  ?                   ; Storage for isolated day (byte)
    month       db  ?                   ; Storage for isolated month (byte)
    year        dw  ?                   ; Storage for calculated year (word)

.code
main PROC
    ; Load our packed 16-bit date into DX
    mov dx, packedDate

    ; ==========================================
    ; 1. Isolating the Day (Bits 0–4)
    ; ==========================================
    mov al, dl        ; make a copy of DL
    and al, 00011111b ; clear bits 5-7
    mov day, al       ; save in day variable[cite: 2]

    ; ==========================================
    ; 2. Isolating the Month (Bits 5–8)
    ; ==========================================
    mov ax, dx        ; make a copy of DX[cite: 2]
    shr ax, 5         ; shift right 5 bits[cite: 2]
    and al, 00001111b ; clear bits 4-7[cite: 2]
    mov month, al     ; save in month variable[cite: 2]

    ; ==========================================
    ; 3. Isolating and Decoding the Year
    ; ==========================================
    mov al, dh        ; make a copy of DH (the high byte of DX)[cite: 2]
    shr al, 1         ; shift right 1 bit[cite: 2]
    mov ah, 0         ; clear AH to 0 so AX holds just the clean number[cite: 2]
    add ax, 1980      ; year is relative to 1980[cite: 2]
    mov year, ax      ; save in year[cite: 2]

    exit
main ENDP
END main
