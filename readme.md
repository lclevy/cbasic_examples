# Canon Basic examples

## Background

Canon Basic is an embedded Basic like interpreter in most Canon Cameras. It allows to run code wihout compilation (like Magic Lantern autoexec.bin) neither encrypted payload like .FIR files (which is not possible on Digic8 and Digic10 cameras). 

Warning, there are some differences between Powershot Basic and Basic on DSLR/ILC cameras! 

## Previous work

- [DEF CON 18 - Oren Isacson &amp; Alfredo Ortega - Exploiting Digital Cameras - YouTube](https://www.youtube.com/watch?v=sy_j51L9nHE)

- [DEF CON 18 - Oren Isacson & Alfredo Ortega - Exploiting Digital Cameras - slides](https://media.defcon.org/DEF%20CON%2018/DEF%20CON%2018%20presentations/DEF%20CON%2018%20-%20Isacson-Ortega-Exploiting-Digital-Cameras.pdf)

- [PowerShot Basic - Oren Isacson, Alfredo Ortega  - August 1, 2010](https://media.defcon.org/DEF%20CON%2018/DEF%20CON%2018%20presentations/DEF%20CON%2018%20-%20Isacson-Ortega-Exploiting-Digital-Cameras-WP.pdf)

- CHDK, Wiki : [Canon Basic | CHDK Wiki | Fandom](https://chdk.fandom.com/wiki/Canon_Basic)

- CHDK, forum : [Dryos Basic scripting - DryOS Development - CHDK Forum](https://chdk.setepontos.com/index.php/topic,5549.0.html)

- Magic Lantern, Forum : [Canon Basic scripting (DIGIC 8, DIGIC X models)](https://www.magiclantern.fm/forum/index.php?topic=25305.0)

- Magic Lantern, Discord : [Discord](https://discord.com/channels/671072748985909258/936696899120005230)

## Warning: running code downloaded from Internet

Downloading code from Github and running it on your device is dangerous in general. You must know what you are doing. Anyway, Canon Basic is an interpreter, thus running script is **in general** less risky than running direct ARM code on your camera.

If your code is wrong, you generally have ERR70 or the camera is freezing (for the latter, remove immediatly the battery and it should be OK). This repository is here to provide examples, to learn and reduce such risk with validated examples, **but risk will never be zero.**

## Motivation

The goal of this repository is to promote collaboration between camera hackers and **provide validated scripts** : tested on given Digic version, given Camera or firmware version.

## How to contribute

As the main goal is to limit risk of running code and promote collaboration, submissions are following these rules (which may be discussed on Discord):

1. all suggested scripts must have been tested before creating a PR

2. you <u>must </u>indicate on which camera(s) and firmware(s) version it has been tested ("tested on" list)

3. you <u>should </u>explain which parts must be modified to run on other models / firmware versions

4. if the script is mostly based on someone's work, you <u>must </u>highlight it

5. it is <u>strongly advised</u> to cite source where the content of the script has been discussed / based on (like Forum messages or Discord exchanges) 

## Example

```
' for Digic10
' tested on R6.150
' source : https://discord.com/channels/671072748985909258/761652283724922880/933858470262882314
' must be adapted for Digic8, as pRom0BaseAddress = 0xE0040000
' author Lorenzo33324, based on Coon work

dim pRom0BaseAddress = 0xE0100000
dim pRom1BaseAddress = 0xF0000000
dim sigLen          = 0x10000

' checksum code by Coon
private sub compute_signature()
  p = pRom0BaseAddress
  c = 0

  For i = 0 To (sigLen - 1)
    c = c + *p
    p = p + 4    
  Next

  compute_signature = c
end sub

private sub Initialize()
  fileName = "B:/FW_SIGN.TXT"
  RemoveFile(fileName)

  f = OpenFileCREAT(fileName)
  CloseFile(f)

  f = OpenFileWR(fileName)
  WriteFileString(f, "model_id is: 0x%08x\n", *pRom1BaseAddress)
  pRom1BaseAddress = pRom1BaseAddress +4 
  WriteFileString(f, "rom version: %s\n", pRom1BaseAddress)
  sign = compute_signature()
  WriteFileString(f, "fw signature: 0x%08x\n", sign)  
  CloseFile(f)

  ' dumpf()
end sub
```

## Repository organisation

The tree is organised per Digic version, Camera models and firmware version as follows:

- Digic8 (scripts validated on several Digic8 cameras)

- DigicX (scripts validated on several DigicX cameras)

- R6 (scripts running on several on R6 firmware versions)

- R6.150 (scripts validated only on R6, firmware v150)

- Universal (scripts validated on several Digic versions)

- [index.md](index.md) (a description of every scripts in the repo)

**Despite this, always check the content of a script before running it on a camera !**

## How to run CBasic code

You have to "prepare" an sdcard as explained [here]([Canon Basic/Card Setup | CHDK Wiki | Fandom](https://chdk.fandom.com/wiki/Canon_Basic/Card_Setup)). The easy way is to reuse Kitor sdcard image : [Canon Basic scripting (DIGIC 8, DIGIC X models)](https://www.magiclantern.fm/forum/index.php?topic=25305.msg230427#msg230427). On R6 (and likely for other cameras with two card slots), CBasic scripts must be on back sdcard slot (drive B: for the camera).

Script file must be renamed to *extend.m*

## FAQ

### Which cameras have "modern" CBasic ?

- Digic 8: PowerShot SX740, EOS M50, EOS R, RP, EOS 250D

- Digic X: R5, R6

### Which cameras have Powershot CBasic ?

- M100

### Which Digic version has my camera ?

see [digic [Magic Lantern wiki]](https://wiki.magiclantern.fm/digic) 

## How to debug ?

You can not use a debugger. You can only write in a file on sdcard or debug log (which can be dumped on card A: using *dumpf()* function) 
