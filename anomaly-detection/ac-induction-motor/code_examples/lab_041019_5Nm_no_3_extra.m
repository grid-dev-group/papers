
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

close all; 


filename = fullfile('D:\','Pas_new_files','lab_041019_4p5Nm_reference','lab_4@37@SP1-37.dat');
%lab_res = readtable('C:\Pas\lab_3_9_19_no_load\full_power_startup.dat',);
lab_res = readtable(filename,'Delimiter',',','ReadVariableNames',false);

start_at = 196001;

% figure;
% subplot(6,1,1);
% plot(-lab_res.Var4(start_at:start_at+SR*cycles-1));
% subplot(6,1,2);
% plot(lab_res.Var3(start_at:start_at+SR*cycles-1));
% subplot(6,1,3);
% plot(-lab_res.Var5(start_at:start_at+SR*cycles-1));
% subplot(6,1,4);
% plot(lab_res.Var7(start_at:start_at+SR*cycles-1));
% subplot(6,1,5);
% plot(lab_res.Var8(start_at:start_at+SR*cycles-1));
% subplot(6,1,6);
% plot(lab_res.Var9(start_at:start_at+SR*cycles-1));



v_t_exp=lab_res.Var3;
i_t_exp=lab_res.Var8;

% v_t_exp=-lab_res.Var4;
% i_t_exp=lab_res.Var7;

v_t=v_t_exp(start_at:start_at+SR*cycles-1);
i_t=i_t_exp(start_at:start_at+SR*cycles-1);
%i_t = sqrt(2) * ( 95.95*cos(w.*t) + 36.22*cos(3.5*w.*t+(89.7*pi/180)) + 9.5*cos(0.1*w.*t) );
%i_t = sqrt(2) * ( 277*ReY(11)*cos(w.*t) + 11*ReY(26)*cos(2.5*w.*t) + 20*ReY(2)*cos(0.1*w.*t) );
%i_t = cos(1*w.*t)+(cos(w.*t)+cos(3.*w.*t)+cos(5.*w.*t)).*exp(-0.5.*(((t-0.01).^2).*100*f_sys));
%i_t = 50+ sqrt(2)*real(50*exp(j*w.*t)+46.2*exp(j*89)*exp(j*5*w.*t));
%v_t = transpose(v_t);
%i_t = transpose(i_t);


[vt_and_it_fft, cpc_out, cpc_reactive_out, cpc_customer_out, cpc_cust_reactive_out]=CPC_extra( v_t, i_t, f_sys, cycles, SR, SAF_dec,0,0);

% vt_and_it_fft = [v_f_amp,v_f_ph,i_f_plot_out,i_f_ang_deg_out] phases are in degrees
% cpc_out = [Ia,Ir,Is,Ic] - complex vectors
% cpc_reactive_out = [Ira,Irr,Irs,Irc]; CPC on reactive current - complex vectors
% cpc_customer_out = [Ica,Icr,Ics,Icc]; CPC on customer current - complex vectors
% cpc_cust_reactive_out = [Icra,Icrr,Icrs,Icrc]; CPC on reactive current of the customer current - complex vectors

