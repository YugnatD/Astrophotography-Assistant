import datetime
import time
import RPi.GPIO as GPIO
import serial
import json
import time
import csv

serial = serial.Serial("/dev/ttyS0",57600,timeout=1)


def GetTemperature_0():#temperature Ambiante
    serial.write("GET_T0#")
    temperature = serial.readline()
    #print temperature
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetTemperature_1():
    serial.write("GET_T1#")
    temperature = serial.readline()
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetTemperature_2():
    serial.write("GET_T2#")
    temperature = serial.readline()
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetTemperature_3():
    serial.write("GET_T3#")
    temperature = serial.readline()
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetTemperature_4():
    serial.write("GET_T4#")
    temperature = serial.readline()
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetTemperature_Rose():
    serial.write("GET_TR#")
    temperature = serial.readline()
    if temperature=="":
        return "ERREUR"
    else:
        #temperature=temperature[:4]+"."+temperature[4:]
        temperature=temperature.replace('\r',"")
        return temperature

def GetHumidity():
    serial.write("GET_H#")
    humidity = serial.readline()
    if humidity=="":
        return "ERREUR"
    else:
        humidity=humidity.replace('\r',"")
        return humidity



cptDelai=0
while True:
    try:
        with open('Config.cfg') as f:
            config = json.load(f)
            f.close()
    except:
        with open('Config.cfg') as f:
            #config = json.load(f)
            print f.read()
            #f.close()
    if config["State"]==True: #Mode Mesure
        cptDelai+=1
        if cptDelai>(int(config["Delai"])*2):
            cptDelai=0
            now= int(round(time.time() * 1000))
            temperature0=GetTemperature_0()
            temperature1=GetTemperature_1()
            temperature2=GetTemperature_2()
            temperature3=GetTemperature_3()
            temperature4=GetTemperature_4()
            temperature_rose=GetTemperature_Rose()
            humidite=GetHumidity()
            temps=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            with open(config["FileName"], mode='a') as MesureFile:#Attention l'ecriture du fichier prend du temps
                MesureFile = csv.writer(MesureFile, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                MesureFile.writerow([temperature0,temperature1,temperature2,temperature3,temperature4,temperature_rose,humidite,temps])
            elapsed_time =int(round(time.time() * 1000))-now
            #print elapsed_time
            if elapsed_time >= 500:
                delai_wait = 0.01#10ms
            else:
                delai_wait =500-elapsed_time#compense le temps
            #print delai_wait
            time.sleep(delai_wait/1000)#fais un delai de 500ms
        else:
            time.sleep(0.5)#fais un delai de 500ms
    elif(config["CreateNewFile"]==True)&(config["State"]==False): #Cree un nouveau ficher de mesure
        config["CreateNewFile"]=False
        config["FileName"]=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")+".csv"
        config["State"]=True
        with open('Config.cfg', 'w') as outfile:
            json.dump(config, outfile)
            outfile.close()
        with open(config["FileName"], mode='w') as MesureFile:
            MesureFile = csv.writer(MesureFile, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            MesureFile.writerow(['Temperature0', 'Temperature1', 'Temperature2', 'Temperature3', 'Temperature4',"Temperature_Rose",'Humidite',"Temps"])
    elif (config["CreateNewFile"]==False)&(config["State"]==False):#Tout est arreter
        time.sleep(0.5)
    if (config["ConsigneChange"]==True):
        print "Changement de consigne"
        serial.write(config["Consigne0"].encode())
        time.sleep(0.01)
        serial.write(config["Consigne1"].encode())
        time.sleep(0.01)
        serial.write(config["Consigne2"].encode())
        time.sleep(0.01)
        serial.write(config["Consigne3"].encode())
        config["ConsigneChange"]=False
        with open('Config.cfg', 'w') as outfile:
            json.dump(config, outfile)
            outfile.close()
    if (config["ChangeRA"]==True):
        serial.write(config["MoveRA"].encode())
        print "Move RA"
        config["ChangeRA"]=False
        with open('Config.cfg', 'w') as outfile:
            json.dump(config, outfile)
            outfile.close()
    if (config["ChangeDEC"]==True):
        serial.write(config["MoveDEC"].encode())
        print "Move DEC"
        config["ChangeDEC"]=False
        with open('Config.cfg', 'w') as outfile:
            json.dump(config, outfile)
            outfile.close()
