' based on Coon post
' RP (not tested)
' dim pLed_gpio = 0xD22390C2
' dim led_onBitmask = 0x24D0002
' dim led_offBitmask = 0x24C0003

' R6.150 (tested)
dim pLed_gpio = 0xD22390C0
dim led_onBitmask = 0x24D0002
dim led_offBitmask = 0x24C0003

dim count = 10

private sub Initialize()

  do while count > 0
    *pLed_gpio = led_onBitmask
    SleepTask(1000)
    *pLed_gpio = led_offBitmask
    SleepTask(1000)

    count = count - 1
  loop
end sub