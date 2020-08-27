
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
Yn = (j*w*n*0.5)+1./(1+j*w*n);
%Yn = ones(1,length(n));
%Yn=-j*Yn;

ReY=real(Yn);
filename = fullfile('lab_041019_4p5Nm_no_1_2_6_8.dat');
%lab_res = readtable('C:\Pas\lab_3_9_19_no_load\full_power_startup.dat',);
lab_res = readtable(filename,'Delimiter',',','ReadVariableNames',false);

start_at = 212001;

v_t_exp=lab_res.Var3;
i_t_exp=lab_res.Var8;

% v_t_exp=-lab_res.Var4;
% i_t_exp=lab_res.Var7;

v_t=v_t_exp(start_at:start_at+SR*cycles-1);
i_t=i_t_exp(start_at:start_at+SR*cycles-1);


[v_f_amp,v_f_ph,i_f_mag,i_f_ang,Ia_mag,Ia_ang,Ir_mag,Ir_ang,Is_mag,Is_ang,Ic_mag,Ic_ang]=CPC( v_t, i_t, f_sys, cycles, SR, SAF_dec,0,0);

