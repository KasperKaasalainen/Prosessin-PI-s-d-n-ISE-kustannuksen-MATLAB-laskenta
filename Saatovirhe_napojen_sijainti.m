% Häiriö herätteenä, viive prosessissa
clear all

syms s K tau l H Kp Ki h
L = exp(-l*s); % Viive
Rhairio = 1/s; % Häiriö

S = Kp+Ki/s; % Säätimen siirtofunktio
P = K/(tau*s+1); % Prosessin siirtofunktio
H = 1/(h*s+1); % Anturin siirtofunktio

Thairio = simplifyFraction(P*L/(1+S*P*L*H));
E = simplifyFraction(-Rhairio*Thairio);
[num, den] = numden(E)
% Oletetaan, että parametrien arvot ovat aina positiivisia. Tutkitaan nimittäjää:
% exp(s/2) on aina positiivista ja millään termillä ei ole miinusmerkkistä
% kerrointa, jolloin nimittäjä voi saada arvon 0 vain reaaliosaltaan
% negatiivisilla s-arvoilla -> kaikki navat Im-akselin vasemmalla puolella.