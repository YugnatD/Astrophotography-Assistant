#ifndef __Delay48M_H__
#define __Delay48M_H__

/*---------------------------------------------------------------------------*-
   Delay_1ms ()
  -----------------------------------------------------------------------------
   Descriptif: Temporisation pour 8051F38C � 48 MHz 
               (syst�me bloquant sans timer)
               
   Entr�e    : time, Dur�e de la temporisation en ms        (0...4'294'967'296)
   Sortie    : --
-*---------------------------------------------------------------------------*/
extern void Delay_1ms (unsigned long time);


#endif
