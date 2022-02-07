' M100
' source : https://www.magiclantern.fm/forum/index.php?topic=25305.msg237618#msg237618
dim c
private sub Initialize()
    System.Create()
    Driver.Create()
    for c=1 to 3
      BeepDrive(3)
      Wait(500)
    next
   
    CamInfo_Debug(1)
   
    for c=1 to 2
      BeepDrive(3)
      Wait(500)
    next
end sub