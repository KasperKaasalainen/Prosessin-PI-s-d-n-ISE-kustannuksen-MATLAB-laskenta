clear all
% Todetaan eri metodeilla saadut tulokset ja lasketaan niiden eroprosentti
% päämenetelmään verrattuna. Numerot muuttujien nimissä viittaavat
% arvosarjoihin 1 ja 2.

% Päämetodi:
ISE_Rhairio_1 = 7.9187
ISE_Rhairio_2 = 13.6489

% Pade:
ISE_Rhairio_PADE_1 = 7.9187
ISE_Rhairio_PADE_2 = 13.6489

% Parseval:
ISE_Rhairio_PAR_1 = 7.9113
ISE_Rhairio_PAR_2 = 13.6428

% Simulink 
ISE_Rhairio_SIM_1 = 7.9180
ISE_Rhairio_SIM_2 = 13.6700
%%
% Lasketaan metodien eroprosentit.
% Pade:
D_Pade_Rhairio_1 = abs(ISE_Rhairio_1-ISE_Rhairio_PADE_1)/ISE_Rhairio_1*100
D_Pade_Rhairio_2 = abs(ISE_Rhairio_2-ISE_Rhairio_PADE_2)/ISE_Rhairio_2*100

% Parseval:
D_Par_Rhairio_1 = abs(ISE_Rhairio_1-ISE_Rhairio_PAR_1)/ISE_Rhairio_1*100
D_Par_Rhairio_2 = abs(ISE_Rhairio_2-ISE_Rhairio_PAR_2)/ISE_Rhairio_2*100

% Simulink:
D_Sim_Rhairio_1 = abs(ISE_Rhairio_1-ISE_Rhairio_SIM_1)/ISE_Rhairio_1*100
D_Sim_Rhairio_2 = abs(ISE_Rhairio_2-ISE_Rhairio_SIM_2)/ISE_Rhairio_2*100