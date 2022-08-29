################################################################################
### Name : Telescope.py
### Engineer : Tanguy Dietrich
### Date : 29/08/2022
### Descriptions : make a server telescope for alpaca ASCOM
################################################################################

import uvicorn
from fastapi import FastAPI, Form
from fastapi_utils.cbv import cbv
from fastapi_utils.inferring_router import InferringRouter
from pydantic import BaseModel
from starlette.requests import Request
from aiocache import Cache
import random


API_NAME = "api"
API_VERSION = "v1"
DEVICE_TYPE = "telescope"
DEVICE_NUMBER = "0"
DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+DEVICE_NUMBER+"/"

cache = Cache()
app = FastAPI()
router = InferringRouter()


@cbv(router)
class Telescope:
    def __init__(self, ip="127.0.0.1", port=32323, deviceNumber=0, name="Astrophotography Assistant", descriptions="blabla", driverinfo="", driverversion="", interfaceversion="", supportedactions=[""]):
        # WARNING EVERYTHING HERE IS READ ONLY AFTER RUN
        self.ip = ip
        self.deviceNumber = deviceNumber
        self.port = port
        self.name = name
        self.descriptions = descriptions
        self.driverinfo = driverinfo
        self.driverversion = driverversion
        self.interfaceversion = interfaceversion
        self.supportedactions = supportedactions
        # TODO FIX THIS -> deviceNumber not the good value
        #DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+str(deviceNumber)+"/"

    def returnValue(self, Value, ClientTransactionID, ErrorNumber=0, ErrorMessage=""):
        ServerTransID = random.randint(0,4294967295)
        return {"Value": Value, "ClientTransactionID": ClientTransactionID, "ServerTransactionID":  ServerTransID, "ErrorNumber": ErrorNumber, "ErrorMessage": ErrorMessage}

    def run(self):
        uvicorn.run(app, host=self.ip, port=self.port)

    @router.get("/")
    def index(self):
        return {"message": "Hello"}

################################################################################
##
##                      COMMON FUNCTION
##
################################################################################


##################################     SET    ##################################
    @router.put(DEFAULT_LINK+"connected")
    async def setConnected(self, Connected: bool = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        await cache.set("Connected", Connected)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"action")
    async def setAction(self, Action: str = Form(...), Parameters: str = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandblind")
    async def setCommandblind(self, Command: str = Form(...), Raw: str = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandbool")
    async def setCommandbool(self, Command: str = Form(...), Raw: str = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue(False, ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandstring")
    async def setCommandstring(self, Command: str = Form(...), Raw: str = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

##################################     GET    ##################################
    @router.get(DEFAULT_LINK+"connected")
    async def Getconnected(self, ClientTransactionID: int, ClientID: int):
        co = await cache.get("Connected", default=False)
        return self.returnValue(co, ClientTransactionID)

    @router.get(DEFAULT_LINK+"name")
    async def Getname(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.name, ClientTransactionID)

    @router.get(DEFAULT_LINK+"description")
    async def Getdescriptions(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.descriptions, ClientTransactionID)

    @router.get(DEFAULT_LINK+"driverinfo")
    async def Getdriverinfo(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.driverinfo, ClientTransactionID)

    @router.get(DEFAULT_LINK+"driverversion")
    async def Getdriverversion(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.driverversion, ClientTransactionID)

    @router.get(DEFAULT_LINK+"interfaceversion")
    async def Getinterfaceversion(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.interfaceversion, ClientTransactionID)

    @router.get(DEFAULT_LINK+"supportedactions")
    async def Getsupportedactions(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(self.supportedactions, ClientTransactionID)

################################################################################
##
##                      TELESCOPE FUNCTION
##
################################################################################


## TODO


################################################################################

app.include_router(router)
