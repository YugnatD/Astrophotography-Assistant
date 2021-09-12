#!/usr/bin/env python
# -*- coding: utf-8 -*-
import struct
import time
import socket, select
import serial
import time
from math import *

M_PI =  3.1415926535897932385
MOVE_SPEED = 59
flagPosition=1
UNITE_DEPLACEMENT = 49843#correspond a 15.04"arc
DEPLACEMENT_SECONDS_DEC = UNITE_DEPLACEMENT * MOVE_SPEED
DEPLACEMENT_SECONDS_RA_POS = UNITE_DEPLACEMENT * (MOVE_SPEED+1)#le ciel continue de bouger en meme temps
DEPLACEMENT_SECONDS_RA_NEG = UNITE_DEPLACEMENT * (MOVE_SPEED-1)
serial = serial.Serial("/dev/ttyS0",57600,timeout=2)#Tanguy
# List of socket objects that are currently open
open_sockets = []

# AF_INET means IPv4.
# SOCK_STREAM means a TCP connection.
# SOCK_DGRAM would mean an UDP "connection".
listening_socket = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
listening_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# The parameter is (host, port).
# The host, when empty or when 0.0.0.0, means to accept connections for
# all IP addresses of current machine. Otherwise, the socket will bind
# itself only to one IP.
# The port must greater than 1023 if you plan running this script as a
# normal user. Ports below 1024 require root privileges.
listening_socket.bind( ("", 10001) )

# The parameter defines how many new connections can wait in queue.
# Note that this is NOT the number of open connections (which has no limit).
# Read listen(2) man page for more information.
listening_socket.listen(5)

current_position = []

def StopRA():
    serial.write("RA0#")

def StopDEC():
    serial.write("DEC0#")

def RunDEC(direction):
    if direction==1:
        serial.write("DEC+#")
    else:
        serial.write("DEC-#")

def RunRA(direction):
    if direction==1:
        serial.write("RA+#")
    else:
        serial.write("RA-#")


def printit(ra_int, dec_int):
    h = ra_int
    d = floor(0.5 + dec_int*(360*3600*1000/4294967296.0));
    dec_sign = ''
    if d >= 0:
        if d > 90*3600*1000:
            d =  180*3600*1000 - d;
            h += 0x80000000;
        dec_sign = '+';
    else:
        if d < -90*3600*1000:
            d = -180*3600*1000 - d;
            h += 0x80000000;
        d = -d;
        dec_sign = '-';
    
    
    h = floor(0.5+h*(24*3600*10000/4294967296.0));
    ra_ms = h % 10000; h /= 10000;
    ra_s = h % 60; h /= 60;
    ra_m = h % 60; h /= 60;
    
    h %= 24;
    dec_ms = d % 1000; d /= 1000;
    dec_s = d % 60; d /= 60;
    dec_m = d % 60; d /= 60;

    print ("ra =", h,"h", ra_m,"m",ra_s,".",ra_ms)
    print ("dec =",dec_sign, d,"d", dec_m,"m",dec_s,".",dec_ms)


while True:
    # Waits for I/O being available for reading from any socket object.
    rlist, wlist, xlist = select.select( [listening_socket] + open_sockets, [], [] )
    for i in rlist:
        if i is listening_socket:
            new_socket, addr = listening_socket.accept()
            open_sockets.append(new_socket)
        else:
            data = i.recv(1024)
            if data == "":
                open_sockets.remove(i)
                flagPosition=1
                print ("Connection closed")
            else:
                
                data = struct.unpack("3iIi", data)
                ra = data[3]*(M_PI/0x80000000)
                dec = data[4]*(M_PI/0x80000000)
                cdec = cos(dec)
                if flagPosition==1:
                    current_position=[]
                    current_position.append(data[3])
                    current_position.append(data[4])
                    flagPosition=0
                else :
                    desired_pos = []
                    desired_pos.append(cos(ra)*cdec)
                    desired_pos.append(sin(ra)*cdec)
                    desired_pos.append(sin(dec))

                deplacement_ra = current_position[0]-data[3]
                if deplacement_ra>0:
                    temps_ra=float(abs(deplacement_ra*1000)/DEPLACEMENT_SECONDS_RA_POS)
                else:
                    temps_ra=float(abs(deplacement_ra*1000)/DEPLACEMENT_SECONDS_RA_NEG)
                deplacement_dec = current_position[1]-data[4]
                #temps de deplacement en millisec
                temps_dec=float(abs(deplacement_dec*1000)/DEPLACEMENT_SECONDS_DEC)
                print "Pos RA :"+ str(data[3])
                print "Pos DEC :"+ str(data[4])
                print ("Temps RA :"+str(temps_ra))
                print ("Temps DEC :"+str(temps_dec))
                end_move_ra=0
                end_move_dec=0
                moving_RA=current_position[0]
                moving_DEC=current_position[1]
                if deplacement_dec > 0:
                    RunDEC(1)
                elif deplacement_dec < 0:
                    RunDEC(0)
                else:
                    pass
                    
                if deplacement_ra > 0:
                    RunRA(1)
                elif deplacement_ra < 0:
                    RunRA(0)
                else:
                    pass
                now_millis = int(round(time.time() * 1000))
                while True:
                    millis = int(round(time.time() * 1000))
                    time_elapsed = millis - now_millis
                    #print time_elapsed
                    if (time_elapsed>=temps_ra)& (end_move_ra==0):
                        StopRA()
                        end_move_ra=1
                    
                    if (time_elapsed>=temps_dec)& (end_move_dec==0):
                        StopDEC()
                        end_move_dec=1
                    
                    if (end_move_ra==1) & (end_move_dec==1):
                        break
                    
##                    if ((time_elapsed%1000)==0):#a verifier que ca ne prend pas trop de temps
##                        if deplacement_dec > 0:
##                            moving_DEC=moving_DEC-UNITE_DEPLACEMENT
##                        elif deplacement_dec < 0:
##                            moving_DEC=moving_DEC+UNITE_DEPLACEMENT
##                        else:
##                            pass
##                            
##                        if deplacement_ra > 0:
##                            moving_RA=moving_RA-UNITE_DEPLACEMENT
##                        elif deplacement_ra < 0:
##                            moving_RA=moving_RA+UNITE_DEPLACEMENT
##                        else:
##                            pass
##                        reply = struct.pack("3iIii", 24, 0, time.time(), moving_RA, moving_DEC, 0)
##                        for s in range(10):##Stellarium likes to recieve the coordinates 10 times.
##                            i.send(reply)
                    
                current_position[0]=data[3]
                current_position[1]=data[4]
                reply = struct.pack("3iIii", 24, 0, time.time(), current_position[0], current_position[1], 0)
                for s in range(10):##Stellarium likes to recieve the coordinates 10 times.
                    i.send(reply)
                print
