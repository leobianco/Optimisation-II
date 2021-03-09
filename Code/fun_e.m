function val = fun_e (x,y)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % fun_e :
  % Renvoie l'�nergie en xy
  %
  % SYNOPSIS val = fun_e (x,y)
  %          
  % INPUT * x,y : coordonn�es des points
  %               Les coordonn�es x ne sont pas n�cessaires.
  %
  % OUTPUT - val: scalaire
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Variables globales
  global Nb; global L;
  
  % Calcul de e
  val = sum(L .* (y(2 : Nb+1) + y(1 : Nb))./2);
endfunction
