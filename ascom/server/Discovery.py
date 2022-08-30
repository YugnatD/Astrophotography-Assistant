
import sys, time
from socket import *
import json

DISCOVERY_MESSAGE = "alpacadiscovery1"

class Discovery:
    def __init__(self, portDiscovery=32227, portAscom=11111):
        self.portDiscovery = portDiscovery
        self.portAscom = portAscom
        self.socketDisco = socket(AF_INET, SOCK_DGRAM)
        self.socketDisco.bind(('', self.portDiscovery))

    def run(self):
        while(True):
            validDiscovery = False
            while(not validDiscovery):
                data, (ip, port) = self.socketDisco.recvfrom(1024)
                data = data.decode("ascii")
                if (data == DISCOVERY_MESSAGE):
                    validDiscovery = True
                    print("Received Valid discovery from "+str(ip)+":"+str(port))
            #now, respond with a json containing the port
            print("sending response")
            toSend = {"AlpacaPort":self.portAscom}
            datatoSend = json.dumps(toSend)
            self.socketDisco.sendto(bytes(datatoSend, "utf-8"), (ip, port))

if __name__ == "__main__":
    discovery = Discovery()
    discovery.run()
