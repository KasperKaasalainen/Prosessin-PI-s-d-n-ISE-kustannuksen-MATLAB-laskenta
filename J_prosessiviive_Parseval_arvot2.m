% Viive anturin yhteydessä. 
clear all

% Määritetään parametrit:
s = tf('s');
K = 3; % Prosessin DC-vahvistus
tau = 5; % Prosessin aikavakio 
l = 2; % Sisäinen viive
h = 0.5; % Anturin aikavakio
Kp = 0.405714626587177; % Säätimen proportionaalivahvistus
Ki = 0.0726443592101894; % Säätimen integraalivahvistus

% Määritetään säädin, prosessi ja anturi.
S = Kp+Ki/s;
P = K/(tau*s+1);
H = 1/(h*s+1);
L = exp(-l*s);

% Määritetään avoimen piirin malli ja määritetään vaiheen
% ylimenokulmataajuus:
Tavoin = series(series(S,P), series(H,L));
margins = allmargin(Tavoin);
yliw = margins.PMFrequency

% Määritetään seuraavaksi laskentavälille maksimiarvo. Kokeillaan
% ylimenokulmataajuuden 50 000-, 100 000-, 500 000-, ja 1 000 000-kertaisia
% arvoja. Määritetään tarkasteluväliltä otettavien näytteiden määrä
% 100-kertainena maksimiarvoon nähden. Valitaan sopivaksi maksimiarvoksi
% 100 000, sillä tätä suuremmat arvot eivät tarkenna tuloksia
% merkittävästi.

wmax = yliw*100000; % tarkasteluvälin maksimiarvo.
nw = wmax*100; % Kulmataajuuksien määrä.
w = linspace(0.0001,wmax,nw); % Luodaan jono kulmataajuuksia (jos aloitetaan suoraan nollasta, ei saada käyttökelpoisia arvoja.
% Kuten näkyy, kiersin tämän aloittamalla lähes nollasta).
f = i*w; % Vastaavat s-tason arvot f

% Näin saadaan seuraavat siirtofunktiot:
S = Kp+Ki./f;
P = K./(tau*f+1);
H = 1./(h*f+1);
L = exp(-l*f);
Rhairio = 1./f;

% Häiriön siirtofunktio ja vastaava säätövirhe:
Thairio = L.*P./(1+L.*S.*P.*H);
Ehairio = -Thairio.*Rhairio;

neliohairio=abs(Ehairio).^2; % Neliöidään arvot
Ihairio = trapz(w,neliohairio); % Integroidaan neliöidyt arvot
ISEhairio = 1/pi*Ihairio % Häiriösignaalin tuottama ISE