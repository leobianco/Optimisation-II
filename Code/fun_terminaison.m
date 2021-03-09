function val = fun_terminaison (nb_iter,maxit)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % fun_terminaison :
  % Renvoie l'entier correspondant � la terminaison de l'algorithme :
  %   - 0 si le seuil d'optimalit� est atteint
  %   - 2 si le nombre maximum d'it�rations est atteint
  %
  % SYNOPSIS val = fun_terminaison (nb_iter,maxit)
  %          
  % INPUT * nb_iter : nombre d'it�rations effectu�es
  %         maxit : nombre maximal d'it�rations autoris�es
  %
  % OUTPUT - val: scalaire
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  if nb_iter < maxit
    val = 0;
  else
    val = 2;
  endif
    
    
endfunction