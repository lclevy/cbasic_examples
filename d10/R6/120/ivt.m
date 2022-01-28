'Get R6 Interrupt Vector Table
'for R6.120

dim pIvt_table_1 = 0x2efd8
dim vector1_len = 0x280

dim pIvt_table_2 = 0x311dc
dim vector2_len = 0x40

private sub write_table(hFile, pVectorTable, startVector, numElements)
  isrVector = startVector

  do while isrVector < numElements
    ppIrqName = pVectorTable + isrVector * 4
    WriteFileString(hFile, "0x%03X: %s\n", isrVector, *ppIrqName)

    isrVector = isrVector + 1
  loop
end sub

private sub save_ivt(fileName)
  RemoveFile(fileName)

  hFile = OpenFileCREAT(fileName)
  CloseFile(hFile)

  hFile = OpenFileWR(fileName)

  write_table(hFile, pIvt_table_1, 0, vector1_len)
  write_table(hFile, pIvt_table_2, vector1_len, vector2_len)

  CloseFile(hFile)
end sub

private sub Initialize()
  save_ivt("B:/R6_IVT.TXT")
end sub