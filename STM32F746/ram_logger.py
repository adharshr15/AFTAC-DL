# renode: python
from Antmicro.Renode.Peripherals.Memory import IMemory
import clr

# Adjust to your MCU SRAM range
RAM_START = 0x20000000
RAM_SIZE  = 0x60000 # 384 KB for STM32F746

ram = machine.SystemBus.GetMemory(RAM_START)

last_used = 0

def measure_ram(sender):
    global last_used
    data = ram.ReadBytes(RAM_START, RAM_SIZE)
    used = sum(1 for b in data if b != 0xA5)   # assumes pattern fill!
    if used != last_used:
        print(f"[RAM] {used} bytes used")
        last_used = used

machine.TimerManager.AddPeriodicTimer("ram_timer", 0.001, measure_ram)  
# 0.001 = 1ms of virtual time
