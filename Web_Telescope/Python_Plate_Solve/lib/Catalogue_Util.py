import os
import sys
import csv
import lib.Messier as Messier
import lib.coordonne as coord
import lib.star as star
import lib.NGC as NGC

def open_messier_catalogue():
    messierCatalogue = []
    cptLine = 0
    with open('Catalogue/messier.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            if(cptLine > 0):
                messier_num = int(row[0].replace("M",""))
                other_catalogue = row[1]
                type_object = row[2]
                const = row[3]
                ra_h = float(row[4].split("h")[0])
                ra_m = float(row[4].split("h")[1].replace("m", "").replace(" ", ""))
                ra_s = 0
                dec_deg = float(row[5].split("°")[0])
                dec_min = float(row[5].split("°")[1].replace("'", ""))
                dec_sec = 0
                sky_coord = coord.Coordonne(ra_h, ra_m, ra_s,dec_deg, dec_min, dec_sec)
                mag = float(row[6])
                size_obj = []
                if "x" in row[7]:#contient deux données
                    size_obj = row[7].split("x")
                else:
                    size_obj.append(row[7])
                distance = float(row[8].replace(".", "").replace(",", ""))
                saison = row[9]
                difficulte = row[9]
                messier = Messier.MessierObject(messier_num, other_catalogue, type_object, const, sky_coord, mag, size_obj, distance, saison, difficulte)
                messierCatalogue.append(messier)
            cptLine+=1
    return messierCatalogue


def open_star_catalogue():
    starCatalogue = []
    cptLine = 0
    with open('Catalogue/BrightStar.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=';')
        for row in csv_reader:
            if(cptLine > 0):
                try:
                    ra_h = float(row[2].split(" ")[0])
                    ra_m = float(row[2].split(" ")[1])
                    ra_s = float(row[2].split(" ")[2])
                    dec_deg = float(row[3].split(" ")[0])
                    dec_min = float(row[3].split(" ")[1])
                    dec_sec = float(row[3].split(" ")[2])
                    mag = float(row[4])
                    sky_coord = coord.Coordonne(ra_h, ra_m, ra_s,dec_deg, dec_min, dec_sec)
                    tmp_star = star.StarObject(sky_coord, mag)
                    starCatalogue.append(tmp_star)
                except:
                    cptLine+=1
            cptLine+=1
    return starCatalogue

def open_NGC_catalogue():
    NGCCatalogue = []
    cptLine = 0
    with open('Catalogue/ngc.csv') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=';')
        for row in csv_reader:
            if(cptLine > 0):
                try:
                    num = row[0]
                    ra_h = float(row[1].split(" ")[0])
                    ra_m = float(row[1].split(" ")[1])
                    ra_s = 0
                    dec_deg = float(row[2].split(" ")[0])
                    dec_min = float(row[2].split(" ")[1])
                    dec_sec = 0
                    mag = float(row[3])
                    sky_coord = coord.Coordonne(ra_h, ra_m, ra_s,dec_deg, dec_min, dec_sec)
                    tmp_ngc = NGC.NGCObject(num, sky_coord, mag)
                    NGCCatalogue.append(tmp_ngc)
                except ValueError :
                    mag = 0
                    sky_coord = coord.Coordonne(ra_h, ra_m, ra_s,dec_deg, dec_min, dec_sec)
                    tmp_ngc = NGC.NGCObject(num, sky_coord, mag)
                    NGCCatalogue.append(tmp_ngc)
                except:
                    cptLine+=1
                    print(row)
            cptLine+=1
    return NGCCatalogue

def is_in_image(centre_image, radius, coordonne):
    #convertie le radius du fov en hms
    hms_tuple = centre_image.ra.hms
    h_fov_radius = 5*24/180
    h_fov_min = hms_tuple[0] - h_fov_radius -1
    h_fov_max = hms_tuple[0] + h_fov_radius + 1
    dec_fov_min = centre_image.dec.deg - radius - 1
    dec_fov_max = centre_image.dec.deg + radius + 1
    if(h_fov_min <= coordonne.ra_h <= h_fov_max):
        if(dec_fov_min <= coordonne.dec_deg <= dec_fov_max):
            return True
    return False
