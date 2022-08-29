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

API_NAME = "api"
API_VERSION = "v1"
DEVICE_TYPE = "telescope"
DEVICE_NUMBER = "0"
DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+DEVICE_NUMBER+"/"

app = FastAPI()
router = InferringRouter()

@cbv(router)
class Telescope:
    def __init__(self, ip="127.0.0.1", port=32323, deviceNumber=0):
        app.ip = ip
        app.deviceNumber = deviceNumber
        app.port = port
        app.Connected = False
        app.ClientID = 0
        app.ClientTransactionID = 0
        # TODO FIX THIS -> deviceNumber not the good value
        #DEFAULT_LINK = "/"+API_NAME+"/"+API_VERSION+"/"+DEVICE_TYPE+"/"+str(deviceNumber)+"/"

    def run(self):
        uvicorn.run(app, host=app.ip, port=app.port)

    @router.get("/")
    def index(self):
        return {"message": "Hello"}

################################################################################
##
##                      COMMON FUNCTION
##
################################################################################
    @router.get(DEFAULT_LINK+"connected")
    def Getconnected(self, ClientTransactionID: int, ClientID: int):
        print("connected state "+str(app.Connected)+ " "+str(ClientTransactionID))
        return {"Value": app.Connected, "ErrorNumber": 0, "ErrorMessage": ""}

    @router.put(DEFAULT_LINK+"connected")
    def setConnected(self, Connected: bool = Form(...), ClientID: int = Form(...), ClientTransactionID: int = Form(...)):
        app.Connected = Connected
        app.ClientID = ClientID
        app.ClientTransactionID = ClientTransactionID
        print("setting connected to : "+str(app.Connected))
        return {"ErrorNumber": 0, "ErrorMessage": ""}

################################################################################
##
##                      TELESCOPE FUNCTION
##
################################################################################


## TODO


################################################################################

app.include_router(router)
