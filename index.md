## Note

For a given script, tree location is generally not given as file can move to more general dir (firmware version->camera->Digic version->universal) or exists for several camera or firmware versions.





## dumping

- extend_dump_mem.m : dump specific memory range
- extend_dump_rom.m : dump ROM

## cpuinfo (srsa / CHDK)

- cpuinfo.s : compiles to cpuinfo.elf
- extend_cpu_info.m : use cpuinfo.bin 
- CPUINFO.DAT : output of extend_cpu_info.m
- cpuinfo_out.txt : CPUINFO.DAT parsed as text

see https://www.magiclantern.fm/forum/index.php?topic=25305.msg230668#msg230668

## Led / GPIO (coon)

extend_led_base.m
extend_led_gpio.m
LED_BASE.TXT
LED_GPIOS.TXT

See https://discord.com/channels/671072748985909258/761652283724922880/792460312561188905

and https://discord.com/channels/671072748985909258/761652283724922880/792460167433551902

## Bootdisk

extend_bootdisk.m : to enable or disable Bootdisk (to boot magiclantern.bin on prepared card, with EOScard)

## Interrupt Vector Tables

ivt.m

## extend_checksig.m

To run script only on specific camera and fw version. A checksum is computed before using hardcoded addresses. See algorithm as [magiclantern_simplified/fw-signature.h at dev · reticulatedpines/magiclantern_simplified · GitHub](https://github.com/reticulatedpines/magiclantern_simplified/blob/dev/src/fw-signature.h)

## extend_fw_sign.m

In DigicX, could be adapted to Digic8 easily.

Compute firmware checksum like  *extend_checksig.m*, and saved in to sdcard, with other camera values in B:/FW_SIGN.TXT




