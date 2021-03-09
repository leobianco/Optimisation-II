function [x_k, lme, lmi, info] = sqp (simul, x, lme, lmi, options)
  
  global Nb; global Nn; global p;
  
  %%%%%%%%%%%%%%%%%%%%%%%% VERIFICATIONS PARAMETRES %%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  status = verif_param_sqp(x, lme, lmi, options.tol(1),options.tol(2),options.tol(3),options.maxit, options.verb, options.rl, options.deriv);
    
  % Si les param�tres ne sont pas corrects, on arr�te la fonction
  if status == 1
    x_k=0; lm=0; info.niter=0; info.status = 1;
 
  elseif status == 0
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  
  x_k = x;
  n = length(x_k);
  critere = 1; % valeur arbitraire
  critere_ancien = 1; % Pour la d�termination de la vitesse de convergence
  quotients = [];
  
  %%%%%%%%%%%%%%%%%%%%%%%%% CONDITIONS INITIALES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  [e_, ce_, ci_, g_, ae_, ai_, hl, indic_sortie] = feval(simul,5,x_k,lme, lmi);
  [e, ce, ci, g, ae, ai, hl_, indic_sortie] = feval(simul,4,x_k,lme, lmi);
  
  if p == 0
   cond1 = max(abs(g + ae.'*lme)); #condition 1 sur le gradient du lagrangien
  else
   cond1 = max(abs(g + ae.'*lme + ai.' * lmi));
  endif
  cond2 = max(abs(ce)); #condition 2 sur l'activation des contraintes
  cond3 = max(abs(min(lmi, -ci)));
  nb_iter = 0; #compteur du nombre d'it�rations effectu�es
  appels_sim = 0; #nombre d'appels au simulateur (cas options.verb=2)
  M_k = eye(2 .* Nn);
  
  %il y a deux mani�res de stopper la boucle :
  % - seuil d'optimalit� atteint
  % - nombre maximal d'it�rations atteint
 
  % Pour l'affichage des donn�es dans des diff�rentes situations
 if options.verb == 1 && options.rl == 0
  data = []; % Donn�s � afficher
  fprintf("----------------------------------------------------------------------------\n")
  fprintf("iter     |gl|         |ce|        |x|      |lm|       alpha        phi\n")
 endif
 
 if options.deriv == 1
  data = []; % Donn�s � afficher
  fprintf("-----------------------------------------------------------------------------\n")
  fprintf("iter    |gl|       |ce|    (ci, lmi)     |x|       |lm|     Powell    cond(M)\n")
 endif
 
 %%%%%%%%%%%%%%%%%%%%%%%%% BOUCLE PRINCIPALE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 while nb_iter < options.maxit && (cond1 > options.tol(1) || cond2 > options.tol(2) || cond3 > options.tol(3))
   
   appels_sim_debut = appels_sim; % On sauvegarde le nombre d'appel au simulateur 
                                  % au d�but de l'it�ration k
         
   %%%%%%%%%%%%%%%%%%%%%%%%% SQP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if options.rl == 1
     
    nb_iter += 1;
     
    %%%%%%%%%%%%%%%%%%%%%%%%% QUASI - NEWTON (BFGS) %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     
    if options.deriv == 1
      
      % Solution primal-dual du probl�me quadratique
      if !(p == 0)
       critere_ancien = critere;
       [d, critere, exitflag, output, lambda] = quadprog(M_k, g, ai, -ci, ae, -ce);
      else
       critere_ancien = critere;
       [d, critere, exitflag, output, lambda] = quadprog(M_k, g, [], [], ae, -ce);
      endif
    
      % Si le syst�me quadratique osculateur n'a pas de solution, on arr�te
      if exitflag == -2
        fprintf('Pas de solution pour le probl�me quadratique osculateur !\n')
        break
      endif
      
      % On r�alise une recherche lin�aire de Wolfe pour choisir le prochain point
      
      % Param�tres omega pour la recherche lin�aire
      omega_1 = 10**(-4);
      omega_2 = 0.99;
      
      % On minimise l'�nergie
      [e_avant, ce_avant, ci_avant, g_avant, ae_avant, ai_avant, hl_, indic_sortie_avant] = feval(simul,4,x_k,lme, lmi);
       
       %%%%%%% RECHERCHE LINEAIRE WOLFE (SIMPLE) %%%%%%%%%%%%%%%%% 
      %
      for i = 0:options.maxit  
        
       alpha_k = (1/2)**i;
        
       # Calcul du nouveau point
       
       x_pas = x_k + alpha_k .* d;
       lme_pas = lme + alpha_k .* (lambda.eqlin - lme); 
       lmi_pas = lmi + alpha_k .* (lambda.ineqlin - lmi);
       
       # Donn�es sur le point d'arriv�e
       [e, ce, ci, g, ae, ai, hl_, indic_sortie] = feval(simul,4,x_pas,lme_pas, lmi_pas);
       appels_sim += 1;
       
       # V�rification des conditions de Wolfe.
       if e > e_avant + omega_1 .* alpha_k .* dot(g_avant,d) || dot(g, d) < omega_2 .* dot(g_avant,d)
        break # Et la bonne valeur d'alpha est stock�e dans la variable alpha_k
       endif
       %}
       
      endfor
       
       # Donn�es sur le point d'arriv�e
      [e, ce, ci, g, ae, ai, hl_, indic_sortie] = feval(simul,4,x_pas,lme_pas, lmi_pas);
          
      % CALCUL QUANTIT�S BFGS    
          
      % Calculer delta_k
      delta_k = x_pas - x_k;
      
      % Calculer gamma_k_l
      g_lag_pas = g + ae.' * lme_pas + ai.' * lmi_pas;
      [e_lag, ce_lag, ci_lag, g_lag, ae_lag, ai_lag, hl_, indic_sortie_lag] = feval(simul,4,x_k,lme_pas, lmi_pas);
      g_lag = g_lag + ae_lag.' * lme_pas + ai_lag.' * lmi_pas;
      gamma_k_l = g_lag_pas - g_lag;
      
      % Calculer theta
      if (gamma_k_l.' * delta_k) < ((0.2) .* (delta_k.'* M_k * delta_k))
        theta = (0.8).* (delta_k.' * M_k * delta_k)/(delta_k.' * M_k * delta_k - gamma_k_l.' * delta_k);
      else
        theta = 1;
      endif
      
      % Calculer gamma_k
      gamma_k = (1 - theta).* M_k * delta_k + theta .* gamma_k_l;
      
      % Calcul de la matrice M_{k+1} :
      % Dans la premi�re it�ration on utilise l'identit�, mais apr�s on la substitue par eta_1 * Id
      if nb_iter == 1
        % Calcul eta_1
        eta_1 = (norm(gamma_k)**2)/(gamma_k.' * delta_k);
        % Substitution de M_1
        M_k = eta_1 .* eye(2 .* Nn);
      
      % Apr�s ce cas, on met-�-jour M_{k+1} normalement, en utilisant BFGS
      elseif nb_iter > 1
        M_k = M_k - (M_k * delta_k * delta_k.' * M_k)/(delta_k.' * M_k * delta_k) + (gamma_k * gamma_k.')/(gamma_k.' * delta_k);
      endif 
      
      % Mise-�-jour du pas
      x_k = x_pas;
      lme = lme_pas;
      lmi = lmi_pas;
      
      % Stockage des donn�es pour l'affichage
      data = [data; nb_iter max(abs(g + ae.' * lme + ai.' * lmi)) max(abs(ce)) max(abs(min(lmi, -ci)))  max(abs(x_k)) max(max(abs(lme)), max(abs(lmi))) theta cond(M_k)];

      % Mise � jour des conditions d'arr�t
      if p == 0
       cond1 = max(abs(g + ae.'*lme)); #condition 1 sur le gradient du lagrangien
      else
       cond1 = max(abs(g + ae.'*lme + ai.' * lmi));
      endif
      cond2 = max(abs(ce)); #condition 2 sur l'activation des contraintes
      cond3 = max(abs(min(lmi, -ci)));
      
    %%%%%%%%%%%%%%%%%%%%%%%%% NEWTON (D�RIV�ES SECONDES) %%%%%%%%%%%%%%%%%%%%%%%
      
    elseif options.deriv == 2
      
     % Solution primal-dual du probl�me quadratique
     if !(p == 0)
      critere_ancien = critere;
      [d, critere, exitflag, output, lambda] = quadprog(hl, g, ai, -ci, ae, -ce);
     else
      critere_ancien = critere;
      [d, critere, exitflag, output, lambda] = quadprog(hl, g, [], [], ae, -ce);
     endif
    
     % Si le syst�me quadratique osculateur n'a pas de solution, on arr�te
     if exitflag == -2
       fprintf('Pas de solution pour le probl�me quadratique osculateur !\n')
       break
     endif
  
     % Calcul des it�r�s x_k+1 et lambda_k+1
     x_k = x_k + d;
     lme = lambda.eqlin;
     lmi = lambda.ineqlin;
     
     % Mise � jour des donn�es
     nb_iter += 1; %incr�mentation du nombre d'it�rations
     [e_, ce_, ci_, g_, ae_, ai_, hl, indic_sortie] = feval(simul,5,x_k,lme, lmi);
     [e, ce, ci, g, ae, ai, hl_, indic_sortie] = feval(simul,4,x_k,lme, lmi);
     
     % Approximation de la hessienne du lagrangien par Cholesky modifi�
     [L, D, flag_chol] = cholmod(hl, 10**(-5), 10**(5));    
     hl = L * diag(D) * L';
     
     % Mise � jour des conditions d'arr�t
     if p == 0
      cond1 = max(abs(g + ae.'*lme)); #condition 1 sur le gradient du lagrangien
     else
      cond1 = max(abs(g + ae.'*lme + ai.' * lmi));
     endif
     cond2 = max(abs(ce)); #condition 2 sur l'activation des contraintes
     cond3 = max(abs(min(lmi, -ci)));
    
     % D�termination de la vitesse de convergence
     alpha = 1.5;
     quotients = [quotients, max(abs(critere))/((max(abs(critere_ancien)))**alpha)];
    
    endif
  
   %%%%%%%%%%%%%%%%%%%%%%%%% NEWTON AVEC RL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   elseif options.rl == 0     # On utilise la r�gle d'Armijo
   
   %%%%%%%%%%%%%%%%%%%%%%%%% SYST�ME NEWTON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    #Calcul de l'it�r� x_k+1 :
    A_1 = [hl,a.'];
    A_2 = [a,zeros(m,m)];
    A = [A_1;A_2];       
   
    b = [g + a.' * lm; c];
    sol = A\b; 
    
    omega = 10**(-4); % Param�tre omega pour la recherche lin�aire
    
    # On rappele que b = F(z) dans l'�nonc�
    phi_1 = (1/2) .* norm(b)**2; # Phi initial : phi(z_k)
    
    # Boucle pour tester les possibles pas
    
    % Pour options.verb = 2
    data_verb_2 = [];
    
    for i = 0:options.maxit   
     
     # Calcul du nouveau point
     alpha_k = (1/2) ** i;
     x_pas = x_k - alpha_k .* sol(1:n);
     lm_pas = lm - alpha_k .* sol(n+1:n+m);
     
     # On doit calculer phi dans le point d'arriv�.
     
     # Donn�es dans le nouveau point
     [e, c, g, a, hl_, indic_sortie] = feval(simul,4,x_pas,lm_pas);
     appels_sim += 1;
     
     b_pas = [g + a.' * lm_pas;c];   # F(z_k + alpha_k .* p_k)
     phi_pas = (1/2) .* norm(b_pas)**2;    # Phi dans le nouveau point
     
     % Stockage des donn�es pour options.verb = 2
     data_verb_2 = [data_verb_2; alpha_k (phi_pas - phi_1) ((phi_pas - phi_1) ./ alpha_k)];
     
     if phi_pas <= phi_1 .* (1 - 2 * omega * alpha_k) 
      break # Et la bonne valeur d'alpha est stock�e dans la variable alpha_k
     endif
  
    endfor
    
    % Une fois qu'on a le bon alpha, la nouvelle it�ration est x_k et lm_k :
    x_k = x_pas;
    lm = lm_pas;
    
    %Mise � jour des conditions d'arr�t
    [e_, c_, g_, a_, hl, indic_sortie] = feval(simul,5,x_k,lm);
    appels_sim += 1;
    cond1 = max(abs(g + a.'*lm)); #condition 1 sur le gradient du lagrangien
    cond2 = max(abs(c)); #condition 2 sur l'activation des contraintes    
    
    nb_iter += 1;
    
    % Stockage des donn�s pour affichage dans le cas options.verb = 1
    if options.verb == 1 && options.rl == 0
     data = [data; nb_iter max(abs(g + a.' * lm)) max(abs(c)) max(abs(x_pas)) max(abs(lm)) alpha_k phi_1];
    endif
    
    % Affichage du cas options.verb = 2
    if options.verb == 2 && options.rl == 0
    fprintf("---------------------------------------------------------------------------\n")
    formatSpec = "iter %i ,   simul %i ,       phi %.5e ,       pente %.5e \n \n";
    fprintf(formatSpec, [nb_iter appels_sim_debut phi_1 (-1) .* 2.* phi_1])
  
    formatSpec = "Recherche Lineaire d'Armijo : |d| = %.2e\n \n";
    fprintf(formatSpec, [max(abs(sol))])

    fprintf("  alpha         phip-phi        DF(phi) \n")
    formatSpec = "%.4e    %.5e    %.5e\n";
    
    for k = 1:size(data_verb_2)(1)
     fprintf(formatSpec, data_verb_2(k,:))
    endfor
  
    formatSpec = "\n|gl| = %.3e , |ce| = %.3e \n";
    fprintf(formatSpec, [max(abs(g + a.' * lm)) max(abs(c))])
    endif
    
   endif
   
 endwhile
 
 % Affichage des param�tres dans le cas options.verb = 1
 if options.verb == 1 && options.rl == 0
  formatSpec = '%2.i    %.4e   %.4e   %.1e   %.1e   %.3e   %.5e \n';
  for k = 1:nb_iter
   fprintf(formatSpec, data(k,:))
  endfor
  fprintf("---------------------------------------------------------------------------\n")
 endif
 
  % Affichage des param�tres dans le cas options.deriv = 1
 if options.deriv == 1
  formatSpec = '%2.i    %.2e   %.2e   %.2e   %.1e   %.2e   %.1e   %.1e\n';
  for k = 1:nb_iter
   fprintf(formatSpec, data(k,:))
  endfor
  fprintf("-----------------------------------------------------------------------------\n")
 endif
 
 %Stockage du nombre d'it�rations effectu�es (info.niter)
 info.niter = nb_iter; 
  
 %D�termination de la terminaison de l'algorithme (info.status = 0 ou 2)
 info.status = fun_terminaison(nb_iter,options.maxit);
 
 %Affichage des conditions d'optimalit�
 printf("Les conditions d'optimalite sont %e (gradient) , %e (contraintes) et %e (min(lambda_I_k, - c_I (x_k))).\n",[cond1,cond2,cond3])
 
 endif % If du status
  
 %Affichage du nombre d'it�rations de l'algorithme et du comportement de l'optimiseur
 fprintf("Le nombre maximal d'iterations autorisees est %d et le nombre d'iterations effectuees est %d \n",[options.maxit,info.niter]);
 fprintf("Le comportement de l'optimiseur est %d \n",[info.status]);
 %fprintf("La constante de vitesse de convergence pour alpha = %d est C = %d \n", [alpha, max(quotients)]);
 fprintf("Les points finaux de la cha�ne sont : [");
 fprintf("%g ", x_k);
 fprintf("]\n")
 fprintf("Les multiplicateurs finaux (contraintes d'�galit�) de la cha�ne sont : [");
 fprintf("%g ", lme);
 fprintf("]\n")
 fprintf("Les multiplicateurs finaux (contraintes d'in�galit�) de la cha�ne sont : [");
 fprintf("%g ", lmi);
 fprintf("]\n")
  
 # V�RIFICATION HESSIENNE R�DUITE (Quand n�c�ssaire, d�commenter)
 %{
 # On trouve le noyau de la jacobienne des contraintes
 a = [ae; ai];
 N = null(a);
 # On calcule la Hessienne r�duite:
 %Hess_red = N.' * hl * N;
 Hess_red = N.' * M_k * N;
 # On calcule le spectre de la Hessienne r�duite:
 printf('Le spectre de la hessienne reduite est \n')
 full(eig(Hess_red))
 %}

endfunction