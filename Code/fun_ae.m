function val = fun_ae (x,y)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % fun_ae :
  % Renvoie la jacobienne des contraintes d'�galit� en xy
  %
  % SYNOPSIS val = fun_ae (x,y)
  %          
  % INPUT * x,y : coordonn�es des points
  %
  % OUTPUT - val: matrice de taille [Nb,2Nn]
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Variables globales
  global Nb; global Nn;
  
  diag_x = sparse(Nn+1,1);  % correspond aux d�riv�es par rapport � x_i
  diag_y = sparse(Nn+1,1);  % correspond aux d�riv�es par rapport � y_i
  
  for i=1:Nn+1
    diag_x(i,1) = x(i+1) - x(i);
    diag_y(i,1) = y(i+1) - y(i); 
  endfor
  
  a_x = spdiags([-2*[diag_x(2:Nn+1)] 2*diag_x(1:Nn)],[-1 0],Nb,Nn); % jacobienne par rapport aux x_i
  a_y = spdiags([-2*[diag_y(2:Nn+1)] 2*diag_y(1:Nn)],[-1 0],Nb,Nn); % jacobienne par rapport aux y_i
  
  % On assemble la jacobienne par rapport aux x_i et y_i
  val = [a_x,a_y];
endfunction
