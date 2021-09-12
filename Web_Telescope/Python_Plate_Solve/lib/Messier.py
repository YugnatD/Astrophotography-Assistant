import lib.coordonne as coord
from astropy.coordinates import SkyCoord

class MessierObject:
    def __init__(self, number_M:int = 1, other_catalogue:str = "", type:str = "", constellation:str = "", coordonne:coord.Coordonne = coord.Coordonne(0,0,0,0,0,0), magnitude:float = 0, taille:list = [], distance:float = 0, saison:str = "", difficulte:str = ""):
        self.Messier = number_M
        self.other_catalogue = other_catalogue
        self.type = type
        self.constellation = constellation
        self.coordonne = coordonne
        self.magnitude = magnitude
        self.taille = taille
        self.distance = distance
        self.saison = saison
        self.difficulte = difficulte
    def __str__(self):
        return "Messier = " + str(self.Messier) + " Catalogue = " + str(self.other_catalogue) + " type = " + self.type + " " + str(self.coordonne) + " " + str(self.magnitude) + " "

    def get_SkyCoord(self):
        return SkyCoord(self.coordonne.ra_toString(),self.coordonne.dec_toString())
