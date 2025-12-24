.syntax unified
.cpu cortex-m4
.thumb

/* Global symbols */
.global Reset_Handler
.global Default_Handler

/* External symbols from linker */
.extern main
.extern _estack
.extern _sidata
.extern _sdata
.extern _edata
.extern _sbss
.extern _ebss

/* =========================
   Vector Table
   ========================= */
.section .isr_vector
.align 2
.word   _estack            /* Initial Stack Pointer */
.word   Reset_Handler
.word   Default_Handler    /* NMI */
.word   Default_Handler    /* HardFault */
.word   Default_Handler    /* MPU Fault */
.word   Default_Handler    /* Bus Fault */
.word   Default_Handler    /* Usage Fault */
.word   0
.word   0
.word   0
.word   0
.word   Default_Handler    /* SVCall */
.word   Default_Handler    /* Debug Monitor */
.word   0
.word   Default_Handler    /* PendSV */
.word   Default_Handler    /* SysTick */

/* =========================
   Reset Handler
   ========================= */
.section .text
.thumb_func
Reset_Handler:
    /* Copy .data from Flash to SRAM */
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata
1:
    cmp r1, r2
    ittt lt
    ldrlt r3, [r0], #4
    strlt r3, [r1], #4
    blt 1b

    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
2:
    cmp r0, r1
    it lt
    strlt r2, [r0], #4
    blt 2b

    /* Jump to main */
    bl main

    /* If main returns */
    b .

/* =========================
   Default Handler
   ========================= */
.thumb_func
Default_Handler:
    b Default_Handler
