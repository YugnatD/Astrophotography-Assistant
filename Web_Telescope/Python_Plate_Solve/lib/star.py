import lib.coordonne as coord
from astropy.coordinates import SkyCoord

class StarObject:
    def __init__(self, coordonne:coord.Coordonne = coord.Coordonne(0,0,0,0,0,0), magnitude:float = 0):
        self.coordonne = coordonne
        self.mag = magnitude

    def __str__(self):
        return "coucou"

    def get_SkyCoord(self):
        return SkyCoord(self.coordonne.ra_toString(),self.coordonne.dec_toString())
