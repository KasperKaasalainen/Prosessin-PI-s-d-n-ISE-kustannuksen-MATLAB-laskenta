% Viive prosessin yhteydessä, herätteenä häiriö. 
clear all

syms s K tau h viive Kp Ki l

% Määritetään prosessin ja anturin siirtofunktiot sekä häiriön askelheräte.
P = K/(tau*s+1);
H = 1/(h*s+1);
Rhairio = 1/s;

% PI-säätimen siirtofunktio on:
S = Kp + Ki/s;

% Ulkoisen häiriön siirtofunktio:
Thairio = viive*P/(1+viive*S*P*H);

% Säätövirhe:
E = collect(-Rhairio*Thairio, viive);
[num,den] = numden(E);

% A, B, C ja D-polynomit:
B = subs(num, viive, 0);
D = diff(num, viive);
A = subs(den, viive, 0);
C = diff (den, viive);

% Tarkistetaan polynomien asteet.
DegA = polynomialDegree(A,s)
DegB = polynomialDegree(B,s)
DegC = polynomialDegree(C,s)
DegD = polynomialDegree(D,s)

% Aste-ehto deg(D)<Deg(C) ei täyty, mutta koska deg(A)>0 ja B=0, voidaan
% viive supistaa E:n osoittajasta pois.

E = collect(-Rhairio*Thairio/viive, viive);
[num,den] = numden(E);

% Luetaan A, B, C ja D-polynomit uudelleen:
B = subs(num, viive, 0);
D = diff(num, viive);
A = subs(den, viive, 0);
C = diff (den, viive);

% Tarkistetaan polynomien asteet uudelleen.
DegA = polynomialDegree(A,s)
DegB = polynomialDegree(B,s)
DegC = polynomialDegree(C,s)
DegD = polynomialDegree(D,s)
% Ehdot deg(B)<deg(A) ja deg(D)<Deg(C) täytyvät.

% Tarkistetaan, onko A:lla ja C:llä yhteisiä juuria.
rootsA = solve(A == 0,s)
rootsC = solve(C == 0,s)
% A:lla ja C:llä Ei samoja nollakohtia.

% Muodostetaan F ja G:
Am = subs(A, s, -s);
Bm = subs(B, s, -s);
Cm = subs(C, s, -s);
Dm = subs(D, s, -s);

F = A*Am-C*Cm;
G = A*Bm-C*Dm;

% Derivoidaan F myöhempiä laskuja varten:
dF = diff(F,s);

% Selvitetään F:n juuret
um = solve(F == 0, s);

% Juuria u vastaavat polynomien arvot:
E = subs(E, viive, exp(-s*l)) % Sijoitetaan viiveen Laplace-muoto muuttujan tilalle.
Eum = subs(E, s, um);
dFum = subs(dF, s, um);
Gum = subs(G, s, um);

% Näin saadaan symbolinen ISE:
J = -sum(Gum./dFum.*Eum)

% Lasketaan ISE:n lukuarvo (arvosarjat 1 ja 2).

% vektorit sijoituksia helpottamaan:
paramsym = [Kp, Ki, K, tau, h, l];
paramval1 = [0.953731971393876, 0.0656346443185536, 2, 10, 5, 0.5];
paramval2 = [0.405714626587177, 0.0726443592101894, 3, 5, 0.5, 2];

% ISE:n lukuarvo:
J1 = subs(J, paramsym, paramval1);
J1 = vpa(J1)
J2 = subs(J, paramsym, paramval2);
J2 = vpa(J2)