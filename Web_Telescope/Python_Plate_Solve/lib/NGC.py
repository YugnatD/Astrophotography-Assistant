import lib.coordonne as coord
from astropy.coordinates import SkyCoord

class NGCObject:
    def __init__(self, number_ngc:int = 1, coordonne:coord.Coordonne = coord.Coordonne(0,0,0,0,0,0), magnitude:float = 0):
        self.ngc = number_ngc
        self.coordonne = coordonne
        self.magnitude = magnitude

    def __str__(self):
        return ""

    def get_SkyCoord(self):
        return SkyCoord(self.coordonne.ra_toString(),self.coordonne.dec_toString())
