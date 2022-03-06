' name : Universal/extend_fw_sign.m 
' tested on R6.150 and R.180
' source : https://discord.com/channels/671072748985909258/761652283724922880/933858470262882314
' should work on Digix8 and Digic10 at least

dim pRom0BaseAddressD10 = 0xE0100000
dim pRom0BaseAddressD8 = 0xE0040000
dim pRom1BaseAddress = 0xF0000000
dim sigLen          = 0x10000

' checksum code by Coon
private sub compute_signature(startSign, sLen)
  p = startSign
  c = 0
      
  For i = 0 To (sLen - 1)
    c = c + *p
    p = p + 4    
  Next
  
  compute_signature = c
end sub

private sub disp_hex_string(address, len, file)
  memStart = address
  WriteFileString(file, "at %x: ", memStart)  
  For i = memStart To (memStart+len)
    WriteFileString(file, "%02x", Peek8(i) & 255 )
  Next     
  WriteFileString(file, "\n" )  
end sub
  
private sub Initialize()
  
  fileName = "B:/FW_SIGN.TXT"
  RemoveFile(fileName)

  f = OpenFileCREAT(fileName)
  CloseFile(f)

  f = OpenFileWR(fileName)

  WriteFileString(f, "model_id : 0x%08x\n", *pRom1BaseAddress)
  WriteFileString(f, "rom version: %s\n", pRom1BaseAddress +4)
  WriteFileString(f, "GetFirmwareVersion: %d\n", GetFirmwareVersion() )  

  WriteFileString(f, "fw signature from 0x%x: 0x%08x\n", pRom0BaseAddressD10, compute_signature(pRom0BaseAddressD10, sigLen ) )  
  WriteFileString(f, "fw signature from 0x%x: 0x%08x\n", pRom0BaseAddressD8, compute_signature(pRom0BaseAddressD8, sigLen) )  
  
  'should look like: xx 48 0C EE 10 0F BF F3 6F 8F 42 F2 00 00 C0 F2 00 00 85 46 10 EE B0 5F 15 F0 0F 00
  disp_hex_string( pRom0BaseAddressD10, 28, f )
  disp_hex_string( pRom0BaseAddressD8, 28, f )

  CloseFile(f)
  
  ' dumpf()
end sub