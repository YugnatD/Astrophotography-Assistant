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
    def __init__(self, ip="127.0.0.1", port=32323, deviceNumber=0):
        self.ip = ip
        self.deviceNumber = deviceNumber
        self.port = port
        # TODO FIX THIS -> deviceNumber not the good value
        #DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+str(deviceNumber)+"/"

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
    @router.get(DEFAULT_LINK+"connected")
    async def Getconnected(self, ClientTransactionID: int, ClientID: int):
        co = await cache.get("Connected", default=False)
        return {"Value": co, "ErrorNumber": 0, "ErrorMessage": ""}

    @router.put(DEFAULT_LINK+"connected")
    async def setConnected(self, Connected: bool = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        await cache.set("Connected", Connected)
        return {"ErrorNumber": 0, "ErrorMessage": ""}

################################################################################
##
##                      TELESCOPE FUNCTION
##
################################################################################


## TODO


################################################################################

app.include_router(router)
