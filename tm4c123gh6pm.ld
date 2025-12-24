ENTRY(Reset_Handler)

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
  SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

_estack = ORIGIN(SRAM) + LENGTH(SRAM);

SECTIONS
{
  /* Vector table */
  .isr_vector :
  {
    KEEP(*(.isr_vector))
  } > FLASH

  /* Code */
  .text :
  {
    *(.text*)
    *(.rodata*)
    _etext = .;
  } > FLASH

  /* Initialized data */
  .data : AT (_etext)
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > SRAM

  /* Source address for .data copy */
  _sidata = LOADADDR(.data);

  /* Uninitialized data */
  .bss :
  {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > SRAM
}
