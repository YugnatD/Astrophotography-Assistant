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

##################################     SET    ##################################


## TODO

##################################     GET    ##################################
# algAltAz	0	Altitude-Azimuth alignment.
# algPolar	1	Polar (equatorial) mount other than German equatorial.
# algGermanPolar	2	German equatorial mount.
    @router.get(DEFAULT_LINK+"alignmentmode")
    async def GetAlignmentmode(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(1, ClientTransactionID)

    @router.get(DEFAULT_LINK+"altitude")
    async def GetAltitude(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(46.09098, ClientTransactionID)

    @router.get(DEFAULT_LINK+"aperturearea")
    async def Getaperturearea(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"aperturediameter")
    async def Getaperturediameter(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"athome")
    async def Getathome(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"atpark")
    async def Getatpark(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"azimuth")
    async def Getazimuth(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canfindhome")
    async def Getcanfindhome(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canpark")
    async def Getcanpark(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canpulseguide")
    async def Getcanpulseguide(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetdeclinationrate")
    async def Getcansetdeclinationrate(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetguiderates")
    async def Getcansetguiderates(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetpark")
    async def Getcansetparks(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetpierside")
    async def Getcansetpierside(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetrightascensionrate")
    async def Getcansetrightascensionrate(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansettracking")
    async def Getcansettracking(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslew")
    async def Getcanslew(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewaltaz")
    async def Getcanslewaltaz(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewaltazasync")
    async def Getcanslewaltazasync(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewasync")
    async def Getcanslewasync(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansync")
    async def Getcansync(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansyncaltaz")
    async def Getcansyncaltaz(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canunpark")
    async def Getcanunpark(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"declination")
    async def Getdeclination(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"declinationrate")
    async def Getdeclinationrate(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"doesrefraction")
    async def Getdoesrefraction(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"equatorialsystem")
    async def Getequatorialsystem(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"focallength")
    async def Getfocallength(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(1000.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"guideratedeclination")
    async def Getguideratedeclination(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0.5, ClientTransactionID)#warining deg/sec

    @router.get(DEFAULT_LINK+"guideraterightascension")
    async def Getguideraterightascension(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0.5, ClientTransactionID)#warining deg/sec

    @router.get(DEFAULT_LINK+"ispulseguiding")
    async def Getispulseguiding(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"rightascension")
    async def Getrightascension(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"rightascensionrate")
    async def Getrightascensionrate(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0.42, ClientTransactionID) #The right ascension tracking rate (arcseconds per second, default = 0.0)

    @router.get(DEFAULT_LINK+"sideofpier")
    async def Getsideofpier(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(-1, ClientTransactionID)

    @router.get(DEFAULT_LINK+"siderealtime")
    async def Getsiderealtime(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"siteelevation")
    async def Getsiteelevation(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"sitelatitude")
    async def Getsitelatitude(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"sitelongitude")
    async def Getsitelongitude(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"slewing")
    async def Getslewing(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"slewsettletime")
    async def Getslewsettletime(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"targetdeclination")
    async def Gettargetdeclination(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"targetrightascension")
    async def Gettargetrightascension(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"tracking")
    async def Gettracking(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"trackingrate")
    async def Gettrackingrate(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue(0, ClientTransactionID)

    @router.get(DEFAULT_LINK+"trackingrates")
    async def Gettrackingrates(self, ClientTransactionID: int, ClientID: int):
        return self.returnValue([0,1,2], ClientTransactionID)

    @router.get(DEFAULT_LINK+"utcdate")
    async def Getutcdate(self, ClientTransactionID: int, ClientID: int):
        # yyyy-MM-ddTHH:mm:ss.fffffffZ E.g. 2016-03-04T17:45:31.1234567Z or 2016-11-14T07:03:08.1234567Z
        return self.returnValue("2016-11-14T07:03:08.1234567Z", ClientTransactionID)

    @router.get(DEFAULT_LINK+"axisrates")
    async def Getaxisrates(self, Axis: int, ClientTransactionID: int, ClientID: int):
        return self.returnValue([100, 15], ClientTransactionID)

    @router.get(DEFAULT_LINK+"canmoveaxis")
    async def Getcanmoveaxis(self, Axis: int, ClientTransactionID: int, ClientID: int):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"destinationsideofpier")
    async def Getdestinationsideofpier(self, RightAscension: int, Declination: int, ClientTransactionID: int, ClientID: int):
        return self.returnValue(-1, ClientTransactionID)


################################################################################

app.include_router(router)
