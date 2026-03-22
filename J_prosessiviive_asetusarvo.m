% Viive prosessin yhteydessä, herätteenä asetusarvo. 
clear all

syms s K tau h viive Kp Ki l

% Määritetään prosessin ja anturin siirtofunktiot sekä asetusarvon askelheräte.
P = K/(tau*s+1);
H = 1/(h*s+1);
Rasetus = 1/s;

% PI-säätimen siirtofunktio on:
S = Kp + Ki/s;

% Asetusarvon siirtofunktio:
Tasetus = viive*P*S/(1+viive*P*S*H);

% Säätövirhe:
E = collect(Rasetus-Rasetus*Tasetus, viive);
[num,den] = numden(E);

B = subs(num, viive, 0);
D = diff(num, viive);
A = subs(den, viive, 0);
C = diff (den, viive);

% Tarkistetaan, onko A.lla ja C:llä samoja juuria.
Ajuuret = solve(A == 0,s);
Cjuuret = solve(C == 0,s);

% A:lla ja C:llä Ei yhteisiä nollakohtia.

% Tarkistetaan polynomien asteet:
DegA = polynomialDegree(A,s)
DegB = polynomialDegree(B,s)
DegC = polynomialDegree(C,s)
DegD = polynomialDegree(D,s)
% Ehto deg(B)<deg(A) täyttyy, mutta deg(D)<Deg(C) ei. Ei jatketa tätä
% tapausta pidemmälle.