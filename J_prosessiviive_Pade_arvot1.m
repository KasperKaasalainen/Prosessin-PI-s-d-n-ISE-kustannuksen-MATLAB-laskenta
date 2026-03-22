% Viive anturissa, arvosarja 1
clear all
s = tf('s');

% Määritetään parametrit:
K = 2; % Prosessin DC-vahvistus
tau = 10; % Prosessin aikavakio 
l = 0.5; % Sisäinen viive
h = 5; % Anturin aikavakio
Kp = 0.953731971393876; % Säätimen proportionaalivahvistus
Ki = 0.0656346443185536; % Säätimen integraalivahvistus
L = exp(-l*s); % Viive

% Määritetään viiveen 2., 3., ja 4. asteen padeapproksimaatiot.
Lp2 = pade(L,2); 
Lp3 = pade(L,3);
Lp4 = pade(L,4);

% Määritetään säädin, prosessi ja anturi:
S = Kp+Ki/s;
P = K/(tau*s+1);
H = 1/(h*s+1);

Thairio = feedback(series(Lp2, P), series(H, S)); % Häiriön siirtofunktio

t = [0:0.1:200]; % Määritetään näytteenottoväli

[Yhairio, t2] = step(Thairio, t); % Häiriön askelvaste
neliohairio = (-Yhairio).^2; % Säätövirheen neliö
Jhairio = trapz(t2, neliohairio) % Häiriövasteen ISE

%%
% Toistetaan tarkastelu 3. asteen approksimaatolla.

Thairio = feedback(series(Lp3, P), series(H, S)); % Häiriön siirtofunktio

[Yhairio, t2] = step(Thairio, t); % Häiriön askelvaste
neliohairio = (-Yhairio).^2; % Säätövirheen neliö
Jhairio = trapz(t2, neliohairio) % Häiriövasteen ISE
%%
% Toistetaan tarkastelu 4. asteen approksimaatolla.

Thairio = feedback(series(Lp4, P), series(H, S)); % Häiriön siirtofunktio

[Yhairio, t2] = step(Thairio, t); % Häiriön askelvaste
neliohairio = (-Yhairio).^2; % Säätövirheen neliö
Jhairio = trapz(t2, neliohairio) % Häiriövasteen ISE