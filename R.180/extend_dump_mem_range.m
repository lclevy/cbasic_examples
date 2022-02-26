' tested on R.180


'private sub Initialize()
'    SaveAllRomImageToFile()
'end sub

private sub Initialize()
    ExportToEventProcedure("dumpMemoryToFile", 0xe01abe21)
  
    dumpMemoryToFile("rom1_half1_", 0xf0000000, 0x2000000, 1)
    dumpMemoryToFile("rom1_half2_", 0xf2000000, 0x2000000, 1)
end sub
