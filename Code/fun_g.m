function val = fun_g (x,y)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % fun_g :
  % Renvoie le gradient de l'�nergie e en xy
  %
  % SYNOPSIS val = fun_g (x,y)
  %          
  % INPUT * x,y : coordonn�es des points
  %               Ces tableaux ne sont pas utiles au calcul.
  %
  % OUTPUT - val: vecteur-colonne de taille [2Nn,1]
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Variables globales
  global Nn; global Nb; global L;
  
  % Calcul de g
  val = [sparse(Nn,1); (L(2 : Nb) + L(1 : Nb - 1))./2];
endfunction
