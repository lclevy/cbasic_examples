' hex dumper
' source : SRSA, may 2020, https://www.magiclantern.fm/forum/index.php?topic=23296.msg227190#msg227190
' tested on R6.150
' should work on other models. slow method
dim start = 0xe0000000
dim length = 0x10000

private sub save_as_hex(fn,addr,size)
    f = OpenFileCREAT(fn)
    CloseFile(f)
    f = OpenFileWR(fn)
    p = addr
    ' 1MB ~ 64 sec
    do while p < (addr+size)
        p1 = *p
        p = p + 4
        p2 = *p
        p = p + 4
        p3 = *p
        p = p + 4
        p4 = *p
        p = p + 4
        p5 = *p
        p = p + 4
        p6 = *p
        p = p + 4
        p7 = *p
        p = p + 4
        p8 = *p
        p = p + 4
        WriteFileString(f,"%08x%08x%08x%08x%08x%08x%08x%08x\n",p1,p2,p3,p4,p5,p6,p7,p8)
    loop
    CloseFile(f)
end sub

private sub Initialize()
    save_as_hex("B:/ROM.TXT",start,length)
end sub