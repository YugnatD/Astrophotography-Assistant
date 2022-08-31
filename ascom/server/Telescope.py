################################################################################
### Name : Telescope.py
### Engineer : Tanguy Dietrich
### Date : 29/08/2022
### Descriptions : make a server telescope for alpaca ASCOM
################################################################################

import uvicorn
import yaml
from yaml.loader import SafeLoader
from fastapi import FastAPI, Form
from fastapi_utils.cbv import cbv
from fastapi_utils.inferring_router import InferringRouter
from pydantic import BaseModel
from starlette.requests import Request
from typing import Optional
from aiocache import Cache
import TelescopeUartDriver as UartScope
import threading
import asyncio
# import ConfigTelescope
# import Discovery
import random

API_VERSION_INT = 1
API_NAME = "api"
API_VERSION = "v"+str(API_VERSION_INT)
DEVICE_TYPE = "telescope"
DEVICE_NUMBER = "0"
DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+DEVICE_NUMBER+"/"

cache = Cache()
app = FastAPI()
router = InferringRouter()
uartscope = UartScope.TelescopeUartDriver()


@cbv(router)
class Telescope:
    def __init__(self, ip="", port=11111):
        # WARNING EVERYTHING HERE IS READ ONLY AFTER RUN
        self.ip = ip
        self.deviceNumber = 0
        self.port = port
        self.name = ""
        self.descriptions = ""
        self.driverinfo = ""
        self.driverversion = ""
        self.interfaceversion = ""
        self.supportedactions = [""]
        self.manufacturer = ""
        self.manufacturer_version = ""
        self.location = ""
        self.UUID = ""
        asyncio.run(self.loadYamlToCache("ScopeConfig.yaml"))

        # TODO FIX THIS -> deviceNumber not the good value
        #DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+str(deviceNumber)+"/"

    async def loadYamlToCache(self, yamlfile):
        with open(yamlfile) as f:
            data = yaml.load(f, Loader=SafeLoader)
        #loading description of mount
        self.name = data["name"]
        self.descriptions = data["descriptions"]
        self.driverinfo = data["driverinfo"]
        self.driverversion = data["driverversion"]
        self.interfaceversion = data["interfaceversion"]
        self.supportedactions = data["supportedactions"]
        self.manufacturer = data["manufacturer"]
        self.manufacturer_version = data["manufacturer_version"]
        self.location = data["location"]
        self.UUID = data["UUID"]
        #Loading the configuration in cache
        for key in data["configuration"].keys():
            await cache.set(key, data["configuration"][key])

    def returnValue(self, Value, ClientTransactionID, ErrorNumber=0, ErrorMessage=""):
        ServerTransID = random.randint(0,4294967295)
        return {"Value": Value, "ClientTransactionID": ClientTransactionID, "ServerTransactionID":  ServerTransID, "ErrorNumber": ErrorNumber, "ErrorMessage": ErrorMessage}

    def run(self):
        # # launch thread for discovery
        # discovery = Discovery.Discovery()
        # x = threading.Thread(target=discovery.run)
        # x.start()
        # print("run uvicorn")
        uvicorn.run(app, host=self.ip, port=self.port)

    @router.get("/")
    def index(self):
        return {"message": "Hello"}

################################################################################
##
##                      MANAGEMENT FUNCTION
##
################################################################################
    @router.get("/management/apiversions")
    async def GetManagementApiVersions(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue([API_VERSION_INT], ClientTransactionID)

    @router.get("/management/"+API_VERSION+"/description")
    async def GetManagementDescription(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        Value = {"ServerName": self.name, "Manufacturer": self.manufacturer, "ManufacturerVersion": self.manufacturer_version, "Location": self.location}
        return self.returnValue(Value, ClientTransactionID)

    @router.get("/management/"+API_VERSION+"/configureddevices")
    async def GetConfiguredDevices(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        Value = [{"DeviceName": self.name, "DeviceType": DEVICE_TYPE, "DeviceNumber": int(DEVICE_NUMBER), "UniqueID": self.uuid}]
        return self.returnValue(Value, ClientTransactionID)

################################################################################
##
##                      COMMON FUNCTION
##
################################################################################


##################################     SET    ##################################
    @router.put(DEFAULT_LINK+"connected")
    async def setConnected(self, Connected: bool = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("connected", Connected)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"action")
    async def setAction(self, Action: str = Form(...), Parameters: str = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandblind")
    async def setCommandblind(self, Command: str = Form(...), Raw: str = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandbool")
    async def setCommandbool(self, Command: str = Form(...), Raw: str = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue(False, ClientTransactionID)

    @router.put(DEFAULT_LINK+"commandstring")
    async def setCommandstring(self, Command: str = Form(...), Raw: str = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        #TODO : SEE WHAT I HAVE TO DO HERE...
        return self.returnValue("", ClientTransactionID)

##################################     GET    ##################################
    @router.get(DEFAULT_LINK+"connected")
    async def Getconnected(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        co = await cache.get("connected", default=False)
        return self.returnValue(co, ClientTransactionID)

    @router.get(DEFAULT_LINK+"name")
    async def Getname(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.name, ClientTransactionID)

    @router.get(DEFAULT_LINK+"description")
    async def Getdescriptions(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.descriptions, ClientTransactionID)

    @router.get(DEFAULT_LINK+"driverinfo")
    async def Getdriverinfo(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.driverinfo, ClientTransactionID)

    @router.get(DEFAULT_LINK+"driverversion")
    async def Getdriverversion(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.driverversion, ClientTransactionID)

    @router.get(DEFAULT_LINK+"interfaceversion")
    async def Getinterfaceversion(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.interfaceversion, ClientTransactionID)

    @router.get(DEFAULT_LINK+"supportedactions")
    async def Getsupportedactions(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(self.supportedactions, ClientTransactionID)

################################################################################
##
##                      TELESCOPE FUNCTION
##
################################################################################

##################################     SET    ##################################

    @router.put(DEFAULT_LINK+"declinationrate")
    async def setdeclinationrate(self, DeclinationRate: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("declinationrate", DeclinationRate)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"doesrefraction")
    async def setdoesrefraction(self, DoesRefraction: bool = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("doesrefraction", DoesRefraction)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"guideratedeclination")
    async def setguideratedeclination(self, GuideRateDeclination: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("guideratedeclination", GuideRateDeclination)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"guideraterightascension")
    async def setguideraterightascension(self, GuideRateRightAscension: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("guideraterightascension", GuideRateRightAscension)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"rightascensionrate")
    async def setrightascensionrate(self, RightAscensionRate: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("rightascensionrate", RightAscensionRate)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"sideofpier")
    async def setsideofpier(self, SideOfPier: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("sideofpier", SideOfPier)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"siteelevation")
    async def setsiteelevation(self, SiteElevation: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("siteelevation", SiteElevation)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"sitelatitude")
    async def setsitelatitude(self, SiteLatitude: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("sitelatitude", SiteLatitude)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"sitelongitude")
    async def setsitelongitude(self, SiteLongitude: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("sitelongitude", SiteLongitude)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewsettletime")
    async def setslewsettletime(self, SlewSettleTime: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("slewsettletime", SlewSettleTime)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"targetdeclination")
    async def settargetdeclination(self, TargetDeclination: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("targetdeclination", TargetDeclination)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"targetrightascension")
    async def settargetrightascension(self, TargetRightAscension: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("targetrightascension", TargetRightAscension)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"tracking")
    async def settracking(self, Tracking: bool = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("tracking", Tracking)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"trackingrate")
    async def settrackingrate(self, TrackingRate: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("trackingrate", TrackingRate)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"utcdate")
    async def setutcdate(self, UTCDate: str = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        await cache.set("utcdate", UTCDate)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"abortslew")
    async def setabortslew(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"findhome")
    async def setfindhome(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"moveaxis")
    async def setmoveaxis(self, Axis: int = Form(...), Rate: float = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"park")
    async def setpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"pulseguide")
    async def setpulseguide(self, Direction: int = Form(...), Duration: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        uartscope.asyncPulse(pulseTime=Duration/1000, pulserate=15.04, direction = Direction)
        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"setpark")
    async def setsetpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtoaltaz")
    async def setslewtoaltaz(self, Azimuth: int = Form(...), Altitude: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtoaltazasync")
    async def setslewtoaltazasync(self, Azimuth: int = Form(...), Altitude: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtocoordinates")
    async def setslewtocoordinates(self, RightAscension: int = Form(...), Declination: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtocoordinatesasync")
    async def setslewtocoordinatesasync(self, RightAscension: int = Form(...), Declination: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtotarget")
    async def setslewtotarget(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"slewtotargetasync")
    async def setslewtotargetasync(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"synctoaltaz")
    async def setsynctoaltaz(self, Azimuth: int = Form(...), Altitude: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"synctocoordinates")
    async def setsynctocoordinates(self, RightAscension: int = Form(...), Declination: int = Form(...), ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"synctotarget")
    async def setsynctotarget(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)

    @router.put(DEFAULT_LINK+"unpark")
    async def setunpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):

        return self.returnValue("", ClientTransactionID)



##################################     GET    ##################################
# algAltAz	0	Altitude-Azimuth alignment.
# algPolar	1	Polar (equatorial) mount other than German equatorial.
# algGermanPolar	2	German equatorial mount.
    @router.get(DEFAULT_LINK+"alignmentmode")
    async def GetAlignmentmode(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(1, ClientTransactionID)

    @router.get(DEFAULT_LINK+"altitude")
    async def GetAltitude(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(46.09098, ClientTransactionID)

    @router.get(DEFAULT_LINK+"aperturearea")
    async def Getaperturearea(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"aperturediameter")
    async def Getaperturediameter(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"athome")
    async def Getathome(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"atpark")
    async def Getatpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"azimuth")
    async def Getazimuth(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canfindhome")
    async def Getcanfindhome(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canpark")
    async def Getcanpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canpulseguide")
    async def Getcanpulseguide(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetdeclinationrate")
    async def Getcansetdeclinationrate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetguiderates")
    async def Getcansetguiderates(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetpark")
    async def Getcansetparks(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetpierside")
    async def Getcansetpierside(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansetrightascensionrate")
    async def Getcansetrightascensionrate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansettracking")
    async def Getcansettracking(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslew")
    async def Getcanslew(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewaltaz")
    async def Getcanslewaltaz(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewaltazasync")
    async def Getcanslewaltazasync(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canslewasync")
    async def Getcanslewasync(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansync")
    async def Getcansync(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"cansyncaltaz")
    async def Getcansyncaltaz(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"canunpark")
    async def Getcanunpark(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"declination")
    async def Getdeclination(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"declinationrate")
    async def Getdeclinationrate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        declinationrate = await cache.get("declinationrate", default=0.0)
        return self.returnValue(declinationrate, ClientTransactionID)

    @router.get(DEFAULT_LINK+"doesrefraction")
    async def Getdoesrefraction(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"equatorialsystem")
    async def Getequatorialsystem(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"focallength")
    async def Getfocallength(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(1000.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"guideratedeclination")
    async def Getguideratedeclination(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0.5, ClientTransactionID)#warining deg/sec

    @router.get(DEFAULT_LINK+"guideraterightascension")
    async def Getguideraterightascension(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0.5, ClientTransactionID)#warining deg/sec

    @router.get(DEFAULT_LINK+"ispulseguiding")
    async def Getispulseguiding(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"rightascension")
    async def Getrightascension(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"rightascensionrate")
    async def Getrightascensionrate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0.42, ClientTransactionID) #The right ascension tracking rate (arcseconds per second, default = 0.0)

    @router.get(DEFAULT_LINK+"sideofpier")
    async def Getsideofpier(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(-1, ClientTransactionID)

    @router.get(DEFAULT_LINK+"siderealtime")
    async def Getsiderealtime(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0.42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"siteelevation")
    async def Getsiteelevation(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"sitelatitude")
    async def Getsitelatitude(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"sitelongitude")
    async def Getsitelongitude(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(660.4, ClientTransactionID)

    @router.get(DEFAULT_LINK+"slewing")
    async def Getslewing(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"slewsettletime")
    async def Getslewsettletime(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(42, ClientTransactionID)

    @router.get(DEFAULT_LINK+"targetdeclination")
    async def Gettargetdeclination(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"targetrightascension")
    async def Gettargetrightascension(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(3.14, ClientTransactionID)

    @router.get(DEFAULT_LINK+"tracking")
    async def Gettracking(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(False, ClientTransactionID)

    @router.get(DEFAULT_LINK+"trackingrate")
    async def Gettrackingrate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(0, ClientTransactionID)

    @router.get(DEFAULT_LINK+"trackingrates")
    async def Gettrackingrates(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue([0,1,2], ClientTransactionID)

    @router.get(DEFAULT_LINK+"utcdate")
    async def Getutcdate(self, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        # yyyy-MM-ddTHH:mm:ss.fffffffZ E.g. 2016-03-04T17:45:31.1234567Z or 2016-11-14T07:03:08.1234567Z
        return self.returnValue("2016-11-14T07:03:08.1234567Z", ClientTransactionID)

    @router.get(DEFAULT_LINK+"axisrates")
    async def Getaxisrates(self, Axis: int, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue([100, 15], ClientTransactionID)

    @router.get(DEFAULT_LINK+"canmoveaxis")
    async def Getcanmoveaxis(self, Axis: int, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(True, ClientTransactionID)

    @router.get(DEFAULT_LINK+"destinationsideofpier")
    async def Getdestinationsideofpier(self, RightAscension: int, Declination: int, ClientID: Optional[int] = Form(None), ClientTransactionID: Optional[int] = Form(None)):
        return self.returnValue(-1, ClientTransactionID)


################################################################################

app.include_router(router)
