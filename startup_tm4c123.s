/* Startup code for TM4C123GH6PM - FIXED VERSION */
.syntax unified
.cpu cortex-m4
.thumb

/* Global symbols */
.global Reset_Handler
.global Default_Handler
.global _vectors

/* External symbols */
.extern main

/* Vector Table */
.section .isr_vector
.align 2
_vectors:
    .word   0x20008000          /* Stack pointer (top of 32KB RAM) */
    .word   Reset_Handler       /* Reset Handler */
    .word   Default_Handler     /* NMI Handler */
    .word   Default_Handler     /* Hard Fault Handler */
    .word   Default_Handler     /* MPU Fault Handler */
    .word   Default_Handler     /* Bus Fault Handler */
    .word   Default_Handler     /* Usage Fault Handler */
    .word   0                   /* Reserved */
    .word   0                   /* Reserved */
    .word   0                   /* Reserved */
    .word   0                   /* Reserved */
    .word   Default_Handler     /* SVCall Handler */
    .word   Default_Handler     /* Debug Monitor Handler */
    .word   0                   /* Reserved */
    .word   Default_Handler     /* PendSV Handler */
    .word   Default_Handler     /* SysTick Handler */

/* Reset Handler */
.section .text
.thumb_func
Reset_Handler:
    /* Simple jump to main - no data/bss init for now */
    ldr r0, =main
    bx r0
    
    /* If main returns */
    b .

/* Default Handler */
.section .text
.thumb_func
Default_Handler:
    b Default_Handler