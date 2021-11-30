                global      _start

                section     .text

_start:
                ; Print "Fibonacci Sequence:"
                mov         rax, syscWrite
                mov         rsi, header
                mov         rdi, stdout
                mov         rdx, headerLength
                syscall

                ; Initialise count of numbers to generate
                mov         rcx, [rel leftToPrint]

generateNext:
                ; Add thisNumber to lastNumber
                mov         rax, [rel lastNumber]
                mov         rdx, [rel thisNumber]
                add         rax, rdx

                ; Store result as thisNumber
                mov         [rel thisNumber], rax

                ; Store the number that was thisNumber as lastNumber
                mov         [rel lastNumber], rdx

                ; Decrement the count of numbers left to print
                dec         rcx

                ; Store the count of numbers left to print
                mov         [rel leftToPrint], rcx

                mov         rcx, digitsToPrint


                mov         [rel remainder], rax
                mov         rsi, writeBuffer
                test        rcx, rcx

printDigit:
                jz          bufferDone
                mov         [rel digitPosition], rcx
                ; Calculate 10^digitPosition
                mov         rax, 1
                dec         rcx
powerLoop:      jz          powerDone
                mov         rdx, 10
                mul         rdx
                dec         rcx
                jmp         powerLoop

                ; Divide the Fibonacci number by the power
powerDone:
                mov         rcx, rax
                mov         rax, [rel remainder]
                xor         rdx, rdx
                div         rcx
                mov         [rel remainder], rdx
                add         rax, 48
                mov         [rel rsi], al
                inc         rsi
                mov         rcx, [rel digitPosition]
                dec         rcx
                jmp         printDigit

                ; Print the number
bufferDone:
                mov         al, comma
                mov         [rel rsi], al
                mov         al, newline
                mov         [rel rsi + 1], al

                mov         rax, syscWrite
                mov         rdi, stdout
                mov         rsi, writeBuffer
                mov         rdx, digitsToPrint + 2
                syscall

                mov         rcx, [rel leftToPrint]
                test        rcx, rcx
                ; Are there still numbers to print?
                jnz         generateNext

                ; Exit
                mov         rax, syscExit
                mov         rdi, exitSuccess
                syscall




                section     .data
comma           equ         44
newline         equ         10
syscWrite       equ         0x02000004              ; The syscall to write
syscExit        equ         0x02000001              ; The syscall to exit
stdout          equ         1
exitSuccess     equ         0
header          db          "Fibonacci Sequence:", newline
headerLength    equ         $ - header
leftToPrint     dq          48
thisNumber      dq          1
lastNumber      dq          0
digitsToPrint   equ         10



                section     .bss
digitPosition   resq        1
remainder       resq        1
writeBuffer     resb        digitsToPrint + 2
