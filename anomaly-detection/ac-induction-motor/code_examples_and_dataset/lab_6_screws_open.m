
% Environment initialization:
clc;	
clearvars;
close all;
 
%-------------------------------
%Input parameters
%---------------------------------
 
V1=230;                                   % Power system RMS voltage
f_sys=50;                             % Power system frequency
cycles = 10;                          % number of cycles
SR=128;                                 % Samples per period
SAF_dec=1E2;
SAF_original_input=1E2;

%w=1;
%f_sys=w/(2*pi) ;
T = cycles/f_sys;  
f_sT = cycles/f_sys;           % Test period 
w=2*pi*f_sys;
phase = 0;                  % signal phase in degrees
maxFreq = 1000;             % maximum frequency to display

% general parameters:
j=sqrt(-1);

%--------------------------------------------------
%Three Phase Implementation
%---------------------------------------------------
 
% V_r=220;                                   % Power system RMS voltage of phase 1
% V_s=220;                                   % Power system RMS voltage of phase 2
% V_t=220;                                   % Power system RMS voltage of phase 3
% I_r=190.5;
% I_s=190.5;
% I_t=0;
% P=72600;
%Q=

% Base Vectors:
t = 0:1/(SR*f_sys):(cycles/f_sys)-(1/(SR*f_sys));
F = 0:1/T:((length(t)/2)-1)/T;
%n = 0:0.1:10;
n = 0:0.1:10;
%% Examples (choose the desired example by changing its if to if 1. only all other should be if 0)
 
%--------------------------
%for LTI load
%--------------------------
%C=1/50*2*pi
close all; 
%Yn = 0.00001*ones(1,length(n))-50*w*j.*n;
%Yn = (j*w*n*0.5)+1./(1+j*w*n);
%Yn = ones(1,length(n));
%Yn=-j*Yn;

%ReY=real(Yn);
filename = fullfile('lab_041019_4p5Nm_no_1_2_5_6_7_8.dat');
%lab_res = readtable('C:\Pas\lab_3_9_19_no_load\full_power_startup.dat',);
lab_res = readtable(filename,'Delimiter',',','ReadVariableNames',false);

start_at = 45001;

v_t_exp=lab_res.Var3;
i_t_exp=lab_res.Var8;

v_t=v_t_exp(start_at:start_at+SR*cycles-1);
i_t=i_t_exp(start_at:start_at+SR*cycles-1);

%i_t = sqrt(2) * ( 95.95*cos(w.*t) + 36.22*cos(4.5*w.*t+(89.7*pi/180)) + 9.5*cos(0.1*w.*t) );
%i_t = sqrt(2) * ( 277*ReY(11)*cos(w.*t) + 11*ReY(26)*cos(2.5*w.*t) + 20*ReY(2)*cos(0.1*w.*t) );
%i_t = cos(1*w.*t)+(cos(w.*t)+cos(3.*w.*t)+cos(5.*w.*t)).*exp(-0.5.*(((t-0.01).^2).*100*f_sys));
%i_t = 50+ sqrt(2)*real(50*exp(j*w.*t)+46.2*exp(j*89)*exp(j*5*w.*t));
%v_t = transpose(v_t);
%i_t = transpose(i_t);


[v_f_amp,v_f_ph,i_f_mag,i_f_ang,Ia_mag,Ia_ang,Ir_mag,Ir_ang,Is_mag,Is_ang,Ic_mag,Ic_ang]=CPC( v_t, i_t, f_sys, cycles, SR, SAF_dec,0,0);

