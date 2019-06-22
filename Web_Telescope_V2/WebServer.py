# -*- coding: utf-8 -*-
from flask import Flask, render_template, url_for, request, jsonify
import datetime
import RPi.GPIO as GPIO
import serial
import pandas
import json
app = Flask(__name__)

GPIO.setmode(GPIO.BCM)
chartSize=50

@app.route("/Telescope/RA_Pos/", methods = ['POST'])
def Move_RA_Pos():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveRA"]="RA+#"
   config["ChangeRA"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/RA_Neg/", methods = ['POST'])
def Move_RA_Neg():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveRA"]="RA-#"
   config["ChangeRA"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/RA_Stop/", methods = ['POST'])
def Move_RA_Stop():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveRA"]="RA0#"
   config["ChangeRA"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/DEC_Pos/", methods = ['POST'])
def Move_DEC_Pos():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveDEC"]="DEC+#"
   config["ChangeDEC"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/DEC_Neg/", methods = ['POST'])
def Move_DEC_Neg():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveDEC"]="DEC-#"
   config["ChangeDEC"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/DEC_Stop/", methods = ['POST'])
def Move_DEC_Stop():
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["MoveDEC"]="DEC0#"
   config["ChangeDEC"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/Set_Pwm0/", methods = ['POST'])
def Set_Pwm0():
   value = int(request.form.get("SliderValue"))
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["Consigne0"]="R0_"+'{:03d}'.format(value)+"#"
   config["ConsigneChange"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/Set_Pwm1/", methods = ['POST'])
def Set_Pwm1():
   value = int(request.form.get("SliderValue"))
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["Consigne1"]="R1_"+'{:03d}'.format(value)+"#"
   config["ConsigneChange"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/Set_Pwm2/", methods = ['POST'])
def Set_Pwm2():
   value = int(request.form.get("SliderValue"))
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["Consigne2"]="R2_"+'{:03d}'.format(value)+"#"
   config["ConsigneChange"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/Set_Pwm3/", methods = ['POST'])
def Set_Pwm3():
   value = int(request.form.get("SliderValue"))
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["Consigne3"]="R3_"+'{:03d}'.format(value)+"#"
   config["ConsigneChange"]=True
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/SetInterval/", methods = ['POST'])
def SetInterval():
   interval = request.form.get("Reponse")
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   print(interval)
   config["Delai"]=interval
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/StartMesure/", methods = ['POST'])
def StartMesure():
   start = request.form.get("Reponse")
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   #config["State"]=bool(start);
   config["State"]=start in ['true', '1']
   #print(start)
   #print(bool(start))
   #print(config)
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/StartStellarium/", methods = ['POST'])
def StartStellarium():
   start = request.form.get("Reponse")
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["StateStellarium"]=start in ['true', '1']
   config["State"]=False
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return str(1)

@app.route("/Telescope/CreateNewFile/", methods = ['POST'])
def CreateNewFile():
        #start = request.form.get("Reponse")
   with open('Config.cfg') as f:
      config = json.load(f)
      f.close()
   config["CreateNewFile"]=True
   config["State"]=False
   with open('Config.cfg', 'w') as outfile:
      json.dump(config, outfile)
      outfile.close()
   return render_template('Telescope.html')


@app.route('/Telescope/GetData', methods=['POST'])
def Telescope_Data():
   test = request.form.get("Reponse")
   print(test)
   with open('Config.cfg') as f:
        config = json.load(f)
   colnames = ['Temperature0', 'Temperature1', 'Temperature2', 'Temperature3', 'Temperature4',"Temperature_Rose", 'Humidite',"Temps"]
   data = pandas.read_csv(config["FileName"],names=colnames,sep=';')
   temperature0 = data.Temperature0.tolist()
   temperature1 = data.Temperature1.tolist()
   temperature2 = data.Temperature2.tolist()
   temperature3 = data.Temperature3.tolist()
   temperature4 = data.Temperature4.tolist()
   temperature_rose = data.Temperature_Rose.tolist()
   humidite=data.Humidite.tolist()
   Temps=data.Temps.tolist()
   myList = [temperature0[-1], temperature1[-1],temperature2[-1],temperature3[-1],temperature4[-1],temperature_rose[-1], humidite[-1],Temps[-1]]
   return jsonify({'data': myList})

@app.route('/Telescope/GetAllData', methods=['POST'])
def Telescope_AllData():
   test = request.form.get("Reponse")
   print(test)
   with open('Config.cfg') as f:
        config = json.load(f)
   colnames = ['Temperature0', 'Temperature1', 'Temperature2', 'Temperature3', 'Temperature4',"Temperature_Rose", 'Humidite',"Temps"]
   data = pandas.read_csv(config["FileName"],names=colnames,sep=';')
   temperature0 = data.Temperature0.tolist()
   temperature1 = data.Temperature1.tolist()
   temperature2 = data.Temperature2.tolist()
   temperature3 = data.Temperature3.tolist()
   temperature4 = data.Temperature4.tolist()
   temperature_rose = data.Temperature_Rose.tolist()
   humidite=data.Humidite.tolist()
   Temps=data.Temps.tolist()
   myList = [temperature0, temperature1,temperature2,temperature3,temperature4,temperature_rose, humidite,Temps]
   return jsonify({'data': myList})

@app.route('/Telescope/GetChart', methods=['POST'])
def Telescope_GetChart():
   test = request.form.get("Reponse")
   print(test)
   with open('Config.cfg') as f:
        config = json.load(f)
   colnames = ['Temperature0', 'Temperature1', 'Temperature2', 'Temperature3', 'Temperature4',"Temperature_Rose", 'Humidite',"Temps"]
   data = pandas.read_csv(config["FileName"],names=colnames,sep=';')
   temperature0 = data.Temperature0.tolist()
   temperature1 = data.Temperature1.tolist()
   temperature2 = data.Temperature2.tolist()
   temperature3 = data.Temperature3.tolist()
   temperature4 = data.Temperature4.tolist()
   temperature_rose = data.Temperature_Rose.tolist()
   humidite=data.Humidite.tolist()
   Temps=data.Temps.tolist()
   #Trie les dernier element  en fonction de chartSize
   sizeMesure=len(Temps)
   if(sizeMesure>=chartSize):
      temperature0=temperature0[sizeMesure-chartSize:sizeMesure]
      temperature1=temperature1[sizeMesure-chartSize:sizeMesure]
      temperature2=temperature2[sizeMesure-chartSize:sizeMesure]
      temperature3=temperature3[sizeMesure-chartSize:sizeMesure]
      temperature4=temperature4[sizeMesure-chartSize:sizeMesure]
      temperature_rose=temperature_rose[sizeMesure-chartSize:sizeMesure]
      humidite=humidite[sizeMesure-chartSize:sizeMesure]
      Temps=Temps[sizeMesure-chartSize:sizeMesure]
   myList = [temperature0, temperature1,temperature2,temperature3,temperature4,temperature_rose, humidite,Temps]
   return jsonify({'data': myList})

@app.route('/Telescope/')
def Telescope():
   return render_template('Telescope.html')

@app.route('/')
def Telescope2():
   return render_template('Telescope.html')

@app.route('/Mesure')
def Mesure():
   with open('Config.cfg') as f:
        config = json.load(f)
   f = open(config["FileName"], "r")
   text=f.read()
   text = text.replace('\n', '')
   return (text)

@app.route('/Config.cfg')
def GetConfig():
   f = open("Config.cfg", "r")
   return (f.read())

if __name__ == "__main__":
   app.run(host='0.0.0.0', port=80, debug=True)
