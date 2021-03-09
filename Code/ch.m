%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          PROJET OPT201                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Etudiants : LAMBERT Guillaume et MARTINS BIANCO Leonardo

%%%%%%%%%%%%%% VARIABLE PILOTANT LE COMPORTEMENT DU SIMULATEUR %%%%%%%%%%%%%%%%

indic = 1;

% indic = 1 : chs dessine la cha�ne
% indic = 2 : chs calcule e et c
% indic = 4 : chs calcule e, c, g, a
% indic = 5 : chs calcule hl
% indic = 6 : chs affiche l'�tude des erreurs du gradient de l'�nergie e

%%%%%%%%%%%%%%%%%%%%%%%% STRUCTURE OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

options.tol = [10**(-3),10**(-3), 10**(-3)]; % On arr�te l'algorithme quand |grad| < tol
options.maxit = 300; % Nombre maximal d'it�rations.
options.rl = 1; % 0 pour recherche lin�aire, 1 pour SQP.
options.verb = 1; % 1 pour afficher les r�sultats, 2 pour d�tails de la RL.
options.deriv = 1; % 1 pour Quasi-Newton, 2 pour Newton (utilisation des d�riv�es secondes)

%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Pour utiliser un cas-test, il faut juste effacer %{ au-dessus de son code.
%
%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 2a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = -1;

% Tailles des barres
global L; L = [0.7; 0.5; 0.3; 0.2; 0.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.4; 0.6; 0.8; -1.0; -1.5; -1.5; -1.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223,0.5190,0.6156,0.8774]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = -1;

% Tailles des barres
global L; L = [0.7; 0.5; 0.3; 0.2; 0.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.4; 0.6; 0.8; 1.0; 1.5; 1.5; 1.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223,0.5190,0.6156,0.8774]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = -1;

% Tailles des barres
global L; L = [0.7; 0.5; 0.3; 0.2; 0.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.4; 0.6; 0.8; -1.0; -1.5; 1.5; -1.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223,0.5190,0.6156,0.8774]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 2d %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = -1;

% Tailles des barres
global L; L = [0.7; 0.5; 0.3; 0.2; 0.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.4; 0.6; 0.8; 1.0; -1.2; 1.5; -1.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223,0.5190,0.6156,0.8774]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = 0;

% Tailles des barres
global L; L = [0.6; 0.6];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.5;0.4];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final


%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 1;
global B; B = 0;

% Tailles des barres
global L; L = [2; 1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.5; 0.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 3c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Coordonn�es du dernier point
global A; A = 0;
global B; B = -1;

% Tailles des barres
global L; L = [2; 1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.3; 0.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lm = [0.5077,0.4223]';

[e, c, g, a, hl, indic] = chs(1, xy, lm); %�tat initial

[x, lm, info] = sqp('chs', xy, lm, options);

[e, c, g, a, hl, indic] = chs(1, x, lm); %�tat final

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

global p; p = 0; % Pas de plancher

% Coordonn�es du dernier point
global A; A = 1;
global B; B = -1;

% Tailles des barres
global L; L = [0.7; 0.5; 0.3; 0.2; 0.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.4; 0.6; 0.8; 1.0; 1.5; 1.5; 1.3];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774]';
lmi = [];

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 4b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = -0.25; S = -0.5;

% Autres configurations de plancher :
%global R; global S; R = -1; S = 0;

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 1;
global B; B = 0;

% Tailles des barres
global L; L = [0.2;0.2;0.2;0.3;0.3;0.5;0.2;0.2;0.3;0.1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;-0.5;-0.9;-1.2;-1.4;-1.5;-1.4;-1.2;-0.9;-0.5];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077,0.4223,0.5190,0.6156,0.8774]';
lmi = [0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156]';

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}


%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 4c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = [-0.1;-0.5]; S = [-0.5;0];
%global R; global S; R = [-0.25;-0.5]; S = [-0.5;0];

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 2;
global B; B = 0;

% Tailles des barres
global L; L = [0.2;0.2;0.2;0.3;0.3;0.5;0.2;0.2;0.3;0.1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;-0.5;-0.9;-1.2;-1.4;-1.5;-1.4;-1.2;-0.9;-0.5];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077,0.4223,0.5190,0.6156,0.8774]';
lmi = [0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156, 0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156]';

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 5a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = [-1]; S = [-0.1];

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 0;
global B; B = 0;

% Tailles des barres
global L; L = [0.5; 0.3; 0.4; 1.2; 0.3; 0.3];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.2; 0.5; 0.8; 1.0; 1.2; -0.4; -0.6; -0.4; -0.2; 0];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077]';
lmi = [0.5077,0.4223,0.5190,0.6156,0.8774]';

% Calculons les multiplicateurs optimaux
%[e,ce,ci,g,ae,ai,hl_,indic] = chs(4,xy,lme,lmi);
%a = [ae; ai];
%contraintes = [-eye(Nb), zeros(Nb, p .* Nn); zeros(p .* Nn, Nb), zeros(p .* Nn, p .* Nn)];
%lambda_init = quadprog(2 .* (a * a.'), 2 .* (a * g).', contraintes, zeros(Nb + p.* Nn, 1));
%lme = lambda_init(1: length(lme))
%lmi = lambda_init((length(lme) + 1):length(lambda_init))

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 5b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = [-6;-10]; S = [-2;100];

% limites de la figure
global FIG_XMIN; 
global FIG_XMAX;
global FIG_YMIN; FIG_YMIN = -210;
global FIG_YMAX; FIG_YMAX = 190;

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 0;
global B; B = -4;

% Tailles des barres
global L; L = [3; 2.5; 2.5];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [-2; 0; 1; -2];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange arbitraires
lme = [0.5077,0.4223,0.5190]';
lmi = [0.5077,0.4223, 0.5190, 0.1234]';

% Calculons les multiplicateurs optimaux
[e,ce,ci,g,ae,ai,hl_,indic] = chs(4,xy,lme,lmi);
a = [ae; ai];
contraintes = [-eye(Nb), zeros(Nb, p .* Nn); zeros(p .* Nn, Nb), zeros(p .* Nn, p .* Nn)];
lambda_init = quadprog(2 .* (a * a.'), 2 .* (a * g).', contraintes, zeros(Nb + p.* Nn, 1));
lme = lambda_init(1: length(lme));
lmi = lambda_init((length(lme) + 1):length(lambda_init));

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 5c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = [-1.0;-0.2; -1.0]; S = [-7.0; 0.0; 7.0];

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 0;
global B; B = 0;

% Tailles des barres
global L; L = [0.1; 0.2; 0.3; 0.4; 0.5; 0.4; 0.3; 0.1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
%xy = [0.1; 0.2; 0.3; 0.4; 0.5; 0.4; 0.3; 0.1; 2; 3; 4; 5; 6; 7];
xy = [0.1; 0.2; 0.3; 0; -0.1; -0.2; -0.3; 1; 2; 3; 4; 3; 2; 1];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077,0.4223,0.5190]';
lmi = [0.5077,0.4223,0.5190,0.5077,0.4223, 0.5190, 0.5037,0.4283,0.8136,0.9774,0.7677,0.3123, 0.6490,0.3077,0.2123,0.8390,0.6156,0.9074,0.1077,0.4223, 0.2990]';

% Multiplicateurs initiaux optimaux
[e,ce,ci,g,ae,ai,hl_,indic] = chs(4,xy,lme,lmi);
a = [ae; ai];
contraintes = [-eye(Nb), zeros(Nb, p .* Nn); zeros(p .* Nn, Nb), zeros(p .* Nn, p .* Nn)];
lambda_init = quadprog(2 .* (a * a.'), 2 .* (a * g).', contraintes, zeros(Nb + p.* Nn, 1));
lme = lambda_init(1: length(lme));
lmi = lambda_init((length(lme) + 1):length(lambda_init));

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 5d %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = [-0.1;-0.5]; S = [-0.5;0];

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 2;
global B; B = 0;

% Tailles des barres
global L; L = [0.2;0.2;0.2;0.3;0.3;0.5;0.2;0.2;0.3;0.1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;-0.5;-0.9;-1.2;-1.4;-1.5;-1.4;-1.2;-0.9;-0.5];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077,0.4223,0.5190,0.6156,0.8774]';
lmi = [0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156, 0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156]';

% Calculons les multiplicateurs optimaux
%[e,ce,ci,g,ae,ai,hl_,indic] = chs(4,xy,lme,lmi);
%a = [ae; ai];
%contraintes = [-eye(Nb), zeros(Nb, p .* Nn); zeros(p .* Nn, Nb), zeros(p .* Nn, p .* Nn)];
%lambda_init = quadprog(2 .* (a * a.'), 2 .* (a * g).', contraintes, zeros(Nb + p.* Nn, 1));
%lme = lambda_init(1: length(lme))
%lmi = lambda_init((length(lme) + 1):length(lambda_init))

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}

%%%%%%%%%%%%%%%%%%%%%%% CAS TEST 5e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Ordonn�es � l'origine et pentes des contraintes d'in�galit�s
global R; global S; R = -0.25; S = -0.5;

% Autres configurations de plancher :
%global R; global S; R = -1; S = 0;

% Nombre de contraintes d'in�galit�s
global p; p = length(R);

% Coordonn�es du dernier point
global A; A = 1;
global B; B = 0;

% Tailles des barres
global L; L = [0.2;0.2;0.2;0.3;0.3;0.5;0.2;0.2;0.3;0.1];
global Nb; Nb = length(L);

% Tableau des coordonn�es des points int�rieurs et sa taille
xy = [0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;-0.5;-0.9;-1.2;-1.4;-1.5;-1.4;-1.2;-0.9;-0.5];
global N; N = length(xy);

% Nombre de points int�rieurs de la cha�ne
global Nn; 
Nn = N/2;

% Multiplicateurs de Lagrange (lm) d�finis arbitrairement
lme = [0.5077,0.4223,0.5190,0.6156,0.8774, 0.5077,0.4223,0.5190,0.6156,0.8774]';
lmi = [0.5077,0.4223,0.5190,0.6156,0.8774,0.5077,0.4223,0.5190,0.6156]';

% Cha�ne initiale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,xy,lme,lmi);

% Optimiseur

[x, lme, lmi, info] = sqp('chs', xy, lme, lmi, options);

% Cha�ne finale

[e,ce,ci,g,ae,ai,hl,indic] = chs(1,x,lme,lmi);

%}