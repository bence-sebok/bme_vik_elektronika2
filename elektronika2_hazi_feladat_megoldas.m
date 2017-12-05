% Elektronika 2. házi feladat
% Átalakítók 7
% Sebők Bence
% K3VH3H
% 2017. ősz

clc;
clear all;

% Paraméterek
UB = 180; % V
Rd = 20; % Ohm
Ld = 20 / 1000; % H
T = 40 / 1000; % s
D = 0.3; % kitöltési tényező
% FET tranzisztor
beta = 1.5;
U_GST = 5; % V
% Félperiódus N részre osztása
N = 12;

% Egyszerűbb számítások
Tfel = T/2; % félperiódus időtartama, [s]
tbe = D * (T/2); % bekapcsolási idő
tki = T/2 - tbe; % kikapcsolási idő
f = 1/T; % frekvencia, [Hz]
%% Áramok
IR = UB/ Rd; % 9 A
ILM = (UB * (T/2 * D/2)) / Ld; % 27 A
ITM = ILM + IR; % 36 A
IDM = ILM - IR; % 18 A
%% Dióda és kapcsoló ideje:
% Első egyenlet: td + tk = D * T/2
% Második egyenlet: ITM / TLM = tk / td
meredekseg = 2 * ILM / D;
% A fenti két egyenlet megoldása:
td = IDM / meredekseg; % dióda ideje
tk = D - td; % kapcsoló ideje

% Áramok átlagértéke
% Egyszerű középérték: IAV = 1/T  integral(0...T) i(t) dt
%% Kapcsolók árama
IT1AV = ( (T/2 * tk) * (ILM + IR) / 2  + ((1 - D) * T/2 * ILM)) / T;
IT2AV = IT1AV;
IT3AV = ( (T/2 * tk) * (ILM + IR) / 2 ) / T;
IT4AV = IT3AV;
%% Diódák árama
ID1AV = ( (T/2 * td) * (ILM - IR) / 2 ) / T;
ID2AV = ID1AV;
ID3AV = ( (T/2 * td) * (ILM - IR) / 2  + ((1 - D) * T/2 * ILM)) / T;
ID4AV = ID3AV;
IBAV = IT1AV + IT3AV - ID1AV - ID3AV;
%% Áram számítások eredménye:
fprintf("Áram számítások eredménye:\n");
fprintf("IT1AV = IT2AV = %f\n", IT1AV);
fprintf("IT3AV = IT4AV = %f\n", IT3AV);
fprintf("ID1AV = ID2AV = %f\n", ID1AV);
fprintf("ID3AV = ID4AV = %f\n", ID3AV);
fprintf("IBAV = %f\n", IBAV);

% Rd érték módosítása
Rd_uj = Ld / (T/2 * D/2);
IR_uj = UB / Rd_uj;
fprintf("Módosított Rd_uj = %f, ehhez tartozó IR_uj = %f\n", Rd_uj, IR_uj);
%% Módosult áramok számítása
%%% új ID1AV, ID3AV
ID1AV_uj = 0;
ID2AV_uj = ID1AV_uj;
%%% új IT1AV, IT2AV
IT1AV_uj = ( (T/2 * tk) * (ILM + IR_uj) / 2  + ((1 - D) * T/2 * ILM)) / T;
IT2AV_uj = IT1AV_uj;
%%% új IT3AV, IT4AV
IT3AV_uj = ( (T/2 * tk) * (ILM + IR_uj) / 2 ) / T;
IT4AV_uj = IT3AV_uj;
%%% új ID3AV, ID4AV
ID3AV_uj = (((1 - D) * T/2 * ILM)) / T;
ID4AV_uj = ID3AV_uj;
%%% új IBAV
IBAV_uj = IT1AV_uj + IT3AV_uj - ID1AV_uj - ID3AV_uj;
%% Módosított áram számítások eredménye:
fprintf("Módosított áram számítások eredménye:\n");
fprintf("IT1AV_uj = IT2AV_uj = %f\n", IT1AV_uj);
fprintf("IT3AV_uj = IT4AV_uj = %f\n", IT3AV_uj);
fprintf("ID1AV_uj = ID2AV_uj = %f\n", ID1AV_uj);
fprintf("ID3AV_uj = ID4AV_uj = %f\n", ID3AV_uj);
fprintf("IBAV_uj = %f\n", IBAV_uj);

% UGS feszültség
fprintf("UGS feszültség számítása\n");
fprintf("Eredeti Rd = %d Ohm\n", Rd);
fprintf("Módosított Rd_uj = %f Ohm\n", Rd_uj);
fprintf("beta = %f, U_GST = %d V\n", beta, U_GST);
IMax = ILM + IR;
U_GS_eredeti = sqrt(IMax/beta) + U_GST;
fprintf("Eredeti Rd értékkel számítva: U_GS = %f\n", U_GS_eredeti);
IMax_uj = ILM + IR_uj;
U_GS_modositott = sqrt(IMax_uj/beta) + U_GST;
fprintf("Módosított Rd_uj értékkel számítva: U_GS = %f\n", U_GS_modositott);
