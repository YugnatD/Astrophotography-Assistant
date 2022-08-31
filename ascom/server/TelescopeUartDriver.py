import threading
import serial
from time import sleep

class TelescopeUartDriver:
    def __init__(self, device="/dev/ttyUSB0"):
        self.device = device
        # self.uart = serial.Serial(device)
        # self.ser.readline()

    # 0 = guideNorth, 1 = guideSouth, 2 = guideEast, 3 = guideWest
    def pulseGuide(self, pulseTime: float, pulserate: float, direction: int):
        if(direction == 0):
            self.guideNorth(pulseTime, pulserate)
        elif(direction == 1):
            self.guideSouth(pulseTime, pulserate)
        elif(direction == 2):
            self.guideEast(pulseTime, pulserate)
        elif(direction == 3):
            self.guideWest(pulseTime, pulserate)

    def asyncPulse(self, pulseTime: float, pulserate: float, direction: int):
        x = threading.Thread(target=self.pulseGuide, args=(pulseTime, pulserate, direction))
        x.start()

    def guideNorth(self, pulseTime: float, pulserate: float):
        print("start guideNorth")
        # self.uart.write("DEC+#")
        sleep(pulseTime) # NEED TO MOVE IT TO THE UC TO BE MORE PRECISE, THATS BAD
        # self.uart.write("DEC0#")
        print("end guideNorth")

    def guideSouth(self, pulseTime: float, pulserate: float):
        print("start guideSouth")
        # self.uart.write("DEC-#")
        sleep(pulseTime) # NEED TO MOVE IT TO THE UC TO BE MORE PRECISE, THATS BAD
        # self.uart.write("DEC0#")
        print("end guideSouth")

    def guideEast(self, pulseTime: float, pulserate: float):
        print("start guideEast")
        # self.uart.write("RA+#")
        sleep(pulseTime) # NEED TO MOVE IT TO THE UC TO BE MORE PRECISE, THATS BAD
        # self.uart.write("RA0#")
        print("end guideEast")

    def guideWest(self, pulseTime: float, pulserate: float):
        print("start guideWest")
        # self.uart.write("RA-#")
        sleep(pulseTime) # NEED TO MOVE IT TO THE UC TO BE MORE PRECISE, THATS BAD
        # self.uart.write("RA0#")
        print("end guideWest")
