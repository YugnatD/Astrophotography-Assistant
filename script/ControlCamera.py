#http://www.gphoto.org/doc/api/index.html
import gphoto2 as gp
import os
import subprocess
#import sys

#Initialise la camera
context = gp.gp_context_new()
camera = gp.Camera()
camera.init()
#Recupere la configureation de la camera
camera_config = camera.get_config(context)
#Configure la camera pour prendre la photo
shutterspeed2 = camera_config.get_child_by_name("shutterspeed2")
shutterspeed2.set_value("1/30")
#shutterspeed2.set_value("Bulb")
ISO_Gain = camera_config.get_child_by_name("iso")
ISO_Gain.set_value("1250")
#enregistre les reglage
camera.set_config(camera_config, context)
#Affiche le reglage actuel
print(shutterspeed2.get_value())
print(ISO_Gain.get_value())
#prend une photo
#file_path = camera.capture(gp.GP_CAPTURE_IMAGE)
#file_path = camera.trigger_capture()
#Transfere la photo sur l'ordi
#camera_file = camera.file_get(file_path.folder, file_path.name, gp.GP_FILE_TYPE_NORMAL)
#target = os.path.join('/home/pi/Desktop/RAW', file_path.name)
#Libere la camera
#camera_file.save(target)
camera.exit(context)
