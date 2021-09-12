import os
import sys
import shutil
from astropy import units as u
from astropy.coordinates import SkyCoord
from astropy.io import fits
from astropy.wcs import WCS
from astropy.utils.data import get_pkg_data_filename
import ligo.skymap.plot
import ligo
from matplotlib import pyplot as plt
from ligo.skymap.plot.marker import reticle
import lib.Catalogue_Util as util

FOCALE = 1000
PHOTOSITE = 4.8
angular_resolution = (206.265 * PHOTOSITE) / FOCALE
low_scale_res = angular_resolution - ((angular_resolution / 100) * 20)
high_scale_res = angular_resolution + ((angular_resolution / 100) * 20)
width_capteur = 4928
height_capteur = 3264
FOV_telescope_deg = width_capteur*angular_resolution / 3600
FOV_IMAGE = 5 #5 degree de champs
STAR_SIZE = 9 # changer pour augmenter ou diminuer la taille des etoile
DOWNSCALE = 2
# low_scale_res = low_scale_res * DOWNSCALE
# high_scale_res = high_scale_res * DOWNSCALE

if(len(sys.argv) < 2):
    print("MANQUANT : PATH TO IMAGE")
    exit()

image_path = sys.argv[1]

#test si l'image est un RAW (NEF):
if(image_path.split(".")[1] == "NEF"):
    print("l'image est un RAW, conversion :")
    newFileName = image_path.split(".")[0]+".png"
    os.system("dcraw -c -w "+image_path +" | pnmtopng -compression 9 > "+newFileName)
    image_path = newFileName


print("plate solve of : " + image_path)
os.system("solve-field --scale-units arcsecperpix --scale-low "+str(low_scale_res)+" --scale-high "+str(high_scale_res)+" --downsample 2 -D solve-output "+image_path+" --overwrite")

#open image result :
wcs_file = "solve-output/"+image_path.split(".")[0]+".wcs"
f = fits.open(wcs_file)
w = WCS(f[0].header)

#calcul de centre de l'image :
capteur_centre = w.pixel_to_world(width_capteur/2, height_capteur/2)#recupere les coordoné des pixel (x,y)
hms_tuple = capteur_centre.ra.hms
str_centre = str(int(hms_tuple[0])) + "h" + str(int(hms_tuple[1])) + "m " + str(int(capteur_centre.dec.deg)) + "d"

#Ouvre les catalogue
messierCatalogue = util.open_messier_catalogue()
starCatalogue = util.open_star_catalogue()
NGCCatalogue = util.open_NGC_catalogue()


#definit le champs de vision de l'image
ax = plt.axes(projection='astro zoom', center=str_centre, radius=str(FOV_IMAGE)+' deg', rotate='0 deg')
ax.grid()

#affiche le champ du capteur :
capteur_H_G = w.pixel_to_world(0, 0)#recupere les coordoné des pixelstr_centre (x,y)
capteur_H_D = w.pixel_to_world(width_capteur, 0)
capteur_B_G = w.pixel_to_world(0, height_capteur)
capteur_B_D = w.pixel_to_world(width_capteur, height_capteur)
x_top = [capteur_H_G.ra.deg, capteur_H_D.ra.deg]
y_top = [capteur_H_G.dec.deg, capteur_H_D.dec.deg]
x_bot = [capteur_B_G.ra.deg, capteur_B_D.ra.deg]
y_bot = [capteur_B_G.dec.deg, capteur_B_D.dec.deg]
x_left = [capteur_H_G.ra.deg, capteur_B_G.ra.deg]
y_left = [capteur_H_G.dec.deg, capteur_B_G.dec.deg]
x_right = [capteur_H_D.ra.deg, capteur_B_D.ra.deg]
y_right = [capteur_H_D.dec.deg, capteur_B_D.dec.deg]
plt.plot(x_top,y_top, 'ro-', transform=ax.get_transform('world'))
plt.plot(x_bot,y_bot, 'ro-', transform=ax.get_transform('world'))
plt.plot(x_left,y_left, 'ro-', transform=ax.get_transform('world'))
plt.plot(x_right,y_right, 'ro-', transform=ax.get_transform('world'))


# Affiche tous les object de messier :NGCCatalogue[7130].get_SkyCoord()
for m in messierCatalogue:
    if util.is_in_image(capteur_centre, FOV_IMAGE, m.coordonne):
        center = m.get_SkyCoord()
        ax.plot(center.ra.deg, center.dec.deg, color='green',  markersize=20, markeredgewidth=2, markerfacecolor='none', marker=ligo.skymap.plot.marker.earth, transform=ax.get_transform('world'))
        plt.text(center.ra.deg, center.dec.deg, str(m.Messier),color='green',size = 10, transform=ax.get_transform('world'))

# affiche les etoile :
for s in starCatalogue:
    if util.is_in_image(capteur_centre, FOV_IMAGE, s.coordonne):
        center = s.get_SkyCoord()
        markerSize = STAR_SIZE -s.mag
        ax.plot(center.ra.deg,center.dec.deg, color='red', markersize=markerSize, markeredgewidth=1, marker=ligo.skymap.plot.marker.earth, transform=ax.get_transform('world'))

# affiche les NGC :
for n in NGCCatalogue:
    if util.is_in_image(capteur_centre, FOV_IMAGE, n.coordonne):
        center = n.get_SkyCoord()
        ax.plot(center.ra.deg,center.dec.deg, color='blue', markersize=10, markeredgewidth=2, markerfacecolor='none', marker=ligo.skymap.plot.marker.earth, transform=ax.get_transform('world'))
        plt.text(center.ra.deg, center.dec.deg, str(n.ngc),color='blue', size = 10, transform=ax.get_transform('world'))


#affiche le resultat finale
# plt.show()
plt.savefig('sky_plot_result.png')
shutil.rmtree('solve-output')
