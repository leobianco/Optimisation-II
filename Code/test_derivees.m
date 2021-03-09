function test_derivees (xy, x, y)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % test_derivees :
  % Affiche l'�tude des erreurs du gradient de l'�nergie e
  %
  % SYNOPSIS test_derivees (xy, x, y)
  %          
  % INPUT * xy, x, y : coordonn�es des points
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Variables globales
  global Nn; global L; global Nb; global B;
  
  % Tableau des pas
  t = sqrt(eps).*max(ones(2*Nn,1),abs(xy(1:2*Nn)));  
  
  % Energie au point (x,y) : e(x) (utilis�e pour le calcul des diff�rences finies)
  e2 = sum(L .* (y(2 : Nb+1) + y(1 : Nb))./2);
  
  for i=1:2*Nn
    % Tableau xy avec translation de la i-�me composante (+t_i e^i)
    xy_bis = xy;
    xy_bis(i) += t(i);
    
    % On extrait les coordonn�es y_i et on inclut les coordonn�es initiales et finales
    y_bis = [0;xy_bis(Nn + 1: 2 * Nn);B];

    % Energie au point (x,y) translat�e : e(x + t_i e^i)
    e1 = sum(L .* (y_bis(2 : Nb+1) + y_bis(1 : Nb))./2); 
    
    % Calcul de DF
    DF = (e1-e2)/t(i);
    
    % i-�me composante du gradient
    grad_e_i = fun_g(x,y)(i);
    
    % Calcul de l'erreur (absolue si la valeur th�orique grad_e_i est nulle, relative sinon)
    % e ne d�pend pas de x_i donc les erreurs correspondantes sont absolues (et nulles)
    if grad_e_i != 0
      erreur = abs(DF-grad_e_i)/abs(grad_e_i);
      type = "rel";
    else
      erreur = abs(DF-grad_e_i);
      type = "abs";
    endif
    
    % Affichage
    print = sprintf('indice : %d  pas : %0.2e  composante : %e  DF : %e  erreur : %e  (erreur %s)',i,t(i),grad_e_i,DF,erreur,type);
    disp(print);
  
  endfor
endfunction
