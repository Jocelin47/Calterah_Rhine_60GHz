%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ƣ�Calterah_adcData_analysis_main.m
%�����ܣ�ADC���ݷ������������򣩣�
%��    ����V1.0.0 2019/08/23 ������΢���ӿƼ������ڣ����޹�˾ AE��
%��    ע��
%�޸ļ�¼��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; 
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('.\subFunc_lib');
%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ʼ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����ļ�
cfg_file_pathName       = '.\cfg\';
cfg_file_fileName       = 'sensor_config_init0.hxx';
cfg_file_fullName       = [cfg_file_pathName cfg_file_fileName];

%�����ļ�
data_file_pathName      = '.\data\';
data_file_fileName      = '20190823095839Capture.dat';
data_file_fullName      = [data_file_pathName data_file_fileName];

%������frameID֡����
frameID                 = 1;  %֡��

%%%%%%%%%%%%%%%%%%%%%%%%%% ���ݷ��� %%%%%%%%%%%%%%%%%%%%%%%%%%
%[step1]����ȡ���ò���
[radarParam]            = radarParam_getFunc(cfg_file_fullName);

%[step2]����ȡ��֡ADC���ݣ����ݸ�ʽ������ά X ����ά X ��������ͨ����
[echo]     = dataRead_func(radarParam, data_file_fullName, frameID);
rawEcho_dispFunc(radarParam, echo);%��ͼ

%[step3]������άFFT
[echo_fft_1D]  = R_FFT_func(radarParam, echo);
R_FFT_dispFunc(radarParam, echo_fft_1D);%��ͼ

%[step4]���ٶ�άFFT
[echo_fft]    = V_FFT_func(radarParam, echo_fft_1D);
V_FFT_dispFunc(radarParam, echo_fft); %��ͼ

%[step4]�������ϳ�
[RV_image]  = DBF_func(radarParam, echo_fft);
DBF_dispFunc(radarParam, RV_image);%��ͼ

%[step6]��CFAR
[cfar_list, cfar_out, gate_out]  = OS_CFAR_2D_interval_Calterah_func(radarParam, RV_image, 16, 64, 3);
CFAR_dispFunc(radarParam, RV_image, cfar_out, gate_out, 93, radarParam.vel_nfft/2+1);%��ͼ

%[step7]�����
[detect_list]   = angleCalc_func(radarParam, cfar_list, echo_fft, [-60, 60]);
radarShow_func(radarParam, detect_list);%��ͼ


xxx=1;
