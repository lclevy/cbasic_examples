' for Digic10
' tested on R6.150
' source : https://discord.com/channels/671072748985909258/761652283724922880/933858470262882314
' must be adapted for Digic8, as pRom0BaseAddress = 0xE0040000
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