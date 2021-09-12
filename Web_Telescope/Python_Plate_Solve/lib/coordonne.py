from astropy.coordinates import SkyCoord

class Coordonne:
    def __init__(self, ra_h:float, ra_m:float, ra_s:float, dec_deg:float, dec_min:float, dec_sec:float):
        self.ra_h = ra_h
        self.ra_m = ra_m
        self.ra_s = ra_s
        self.dec_deg = dec_deg
        self.dec_min = dec_min
        self.dec_sec = dec_sec

    def __str__(self):
        return "("+str(self.ra_h)+ "h " + str(self.ra_m) + "m " + str(self.ra_s) + "s  | " + str(self.dec_deg) + "° " + str(self.dec_min) + "' " + str(self.dec_sec) + '"' + ")"

    def ra_toString(self):
        return str(int(self.ra_h))+"h"+str(int(self.ra_m))+"m"+str(self.ra_s)+"s"

    def dec_toString(self):
        return str(int(self.dec_deg))+"d"+str(int(self.dec_min))+"m"+str(int(self.dec_sec))+"s"
