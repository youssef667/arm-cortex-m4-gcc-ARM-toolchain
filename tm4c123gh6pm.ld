/* Linker script for TM4C123GH6PM - Cortex-M4 */
ENTRY(Reset_Handler)

/* Memory layout */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

/* Stack size */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);
_Min_Stack_Size = 0x1000;  /* 4KB stack */

/* Sections */
SECTIONS
{
    /* Vector table at beginning of FLASH */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } > FLASH

    /* Code and read-only data */
    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
        _etext = .;  /* End of text section */
    } > FLASH

    /* Initialized data (to be copied to RAM) */
    .data : 
    {
        . = ALIGN(4);
        _sdata = .;  /* Start of data in RAM */
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;  /* End of data in RAM */
    } > SRAM AT > FLASH
    
    /* Load address of .data in FLASH */
    _sidata = LOADADDR(.data);

    /* Uninitialized data (BSS) */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;  /* Start of BSS */
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;  /* End of BSS */
    } > SRAM

    /* Stack */
    .stack (NOLOAD) :
    {
        . = ALIGN(8);
        . = . + _Min_Stack_Size;
        . = ALIGN(8);
    } > SRAM
}