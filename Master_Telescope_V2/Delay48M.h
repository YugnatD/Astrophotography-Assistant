#ifndef __Delay48M_H__
#define __Delay48M_H__

/*---------------------------------------------------------------------------*-
   Delay_1ms ()
  -----------------------------------------------------------------------------
   Descriptif: Temporisation pour 8051F38C à 48 MHz 
               (système bloquant sans timer)
               
   Entrée    : time, Durée de la temporisation en ms        (0...4'294'967'296)
   Sortie    : --
-*---------------------------------------------------------------------------*/
extern void Delay_1ms (unsigned long time);


#endif
