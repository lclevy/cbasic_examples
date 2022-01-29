'RP.160 
' author : Coon
' source : https://discord.com/channels/671072748985909258/761652283724922880/933858470262882314
' should work on other models, just change expectedSig and pRomBaseAddress values

dim expectedSig     = 0xECDDA78C
dim sigLen          = 0x10000
dim pRomBaseAddress = 0xE0040000

private sub main()
  Printf("TODO: Execute model specific code here.")
end sub

'--- Do not modify code below ---

private sub compute_signature()
  p = pRomBaseAddress
  c = 0
      
  For i = 0 To (sigLen - 1)
    c = c + *p
    p = p + 4    
  Next
  
  compute_signature = c
end sub

private sub signature_is_valid()
  computedSig = compute_signature()
  
  if computedSig = expectedSig Then
    signature_is_valid = 1
  else
    Printf("Signature mismatch! Expected 0x%08X computed 0x%08X", expectedSig, computedSig)
    signature_is_valid = 0
  end if  
end sub 

private sub Initialize()   
  if signature_is_valid() Then
    main()    
  else
    Printf("Invalid signature. Won't execute script!")
  end if  
end sub