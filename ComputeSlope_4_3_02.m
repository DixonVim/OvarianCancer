clear all
close all
%addpath('/Users/dixon/Documents/TAMU/DemosNew')
%addpath('/Users/dixon/Documents/TAMU/Ovarian')
%addpath('/Users/dixon/Documents/TAMU/DistVar/supCodes/function/')

%% Load Data --> dataset 4-3-02
load 'ovarian12.mat'

Ca= ovarian12.Ca ; % Cases
Co= ovarian12.Co ; % Controls 
moz= ovarian12.moz ; % M/z values 

%% Compute Slope with data windows of size 1024 = 2^10  and shift 500 
J = 10; shift = 500;
d_window = 1: shift: size(Ca,1) - (2^J - 1);
length(d_window)

L = 3; % wavelet level (i.e., J - L decompositions)
k1 = L +1 ; k2 =  J - 2;  % ranges required for coputing wavelet spectra

% Wavelet filter
hfilt =[...
      0.038580777747887  -0.126969125396205  -0.077161555495774   0.607491641385684 ...
       0.745687558934434   0.226584265197069]; % daubechies6

isreal = 4; isplot = 0; 

% Store slope computed through the standard method (i.e., average-square of wavelet coefficients)
SloCa = zeros(length(d_window), size(Ca,2)); % Case 
SloCo = zeros(length(d_window), size(Co,2)); % Control

%  Store slope computed through the distance covariance
SloCaDC = zeros(length(d_window), size(Ca,2)); % Case 
SloCoDC = zeros(length(d_window), size(Co,2)); % Control

for j = 1: length(d_window)
    j
    start =  d_window(j); 
    range = start:start+(2^J-1);
end
    % case
    for i=1:size(Ca,2)
       [slope, levels, log2spec ] = waveletspectraFDC(Ca(range,i), L, hfilt, k1, k2, 0);
       SloCa(j,i) = slope;
       [slope, levels, log2spec ] = waveletspectraFDC(Ca(range,i), L, hfilt, k1, k2, 1);
       SloCaDC(j,i) = slope;
    end
    %control
    for i=1:size(Co,2)
       [slope, levels, log2spec ] = waveletspectraFDC(Co(range,i), L, hfilt, k1, k2, 0);
       SloCo(j,i) = slope;
       [slope, levels, log2spec ] = waveletspectraFDC(Co(range,i), L, hfilt, k1, k2, 1);
       SloCoDC(j,i) = slope;
    end


end

%% Save Data 
SlopeDataSet4_3_2.SloCa = SloCa;
SlopeDataSet4_3_2.SloCo = SloCo;
SlopeDataSet4_3_2.SloCaDC = SloCaDC;
SlopeDataSet4_3_2.SloCoDC = SloCoDC;

%save SlopeDataSet4_3_2.mat  SlopeDataSet4_3_2 -mat
