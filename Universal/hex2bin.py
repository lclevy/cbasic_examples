# python hex2bin.py rom.txt rom.bin
# tested python 3.10
# see extend_dump_hex.m

'''
example 
rom.txt:
e59f0034e12fff100000000000000000000000000000000000000000bffef7ff
bffef7ffbffef7ffbffef7ffbffef7ffbffef7ffbffef7ffbffef7ffe0068b45
hexdump rom.bin:
0x000000:  34009fe5 10ff2fe1 00000000 00000000    4...../.........
0x000010:  00000000 00000000 00000000 fff7febf    ................
0x000020:  fff7febf fff7febf fff7febf fff7febf    ................
0x000030:  fff7febf fff7febf fff7febf 458b06e0    ............E...
'''
import sys
from binascii import unhexlify
from struct import unpack, pack, iter_unpack

with open(sys.argv[1],'r') as f:
  with open(sys.argv[2], 'wb') as out:
    for line in f:
      bin = unhexlify(line.strip())
      if len(bin)%4 != 0:
        print('error : each line must contain multiple of 4 hexbytes')
      l = len(bin)//4  
      out.write( pack('>%dL'%l, *unpack('<%dL'%l, bin)) ) # reverse long from little to big endianess
