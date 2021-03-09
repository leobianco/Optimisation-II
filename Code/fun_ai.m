function val = fun_ai (x,y)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % fun_ai :
  % Renvoie la jacobienne des contraintes d'in�galit�s en xy
  %
  % SYNOPSIS val = fun_ai (x,y)
  %          
  % INPUT * x,y : coordonn�es des points
  %
  % OUTPUT - val: matrice de taille [p * Nn,2Nn]
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Variables globales
  global Nb; global Nn; global L; global p; global R, global S;
  
  % La matrice ai est compos�e de deux sous-matrices colonnes de taille (p * Nn,Nn)
  % que l'on concat�ne en ligne. 
  
  % La premi�re sous-matrice est compos�e de p
  % sous-matrices de taille (Nn,Nn). Elles sont diagonales avec le coefficient
  % s_j sur la diagonale de  la j-�me sous-matrices.
  
  % La seconde sous-matrices est compos�e de p matrices identit� multipli�es 
  % par -1. Elles sont de tailles (Nn,Nn)
  
  % Ainsi, pour chaque it�ration j de la boucle, on calcule les deux matrices :
  % - la matrice diagonale s_j
  % - la matrice identit� multipli�e par -1
  % Puis on les concat�ne.
  col1 = [];
  col2 = [];
  
  for j=1:p
    col1 = [col1;S(j).*eye(Nn)];
    col2 = [col2;(-1).*eye(Nn)];
  endfor
  
  val = [col1,col2];
  
  
endfunction
