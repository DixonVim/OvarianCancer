clear all
close all
%clc
%addpath('/Users/dixon/Documents/TAMU/DemosNew')
%addpath('/Users/dixon/Documents/TAMU/Ovarian')
%addpath('/Users/dixon/Documents/TAMU/DistVar/supCodes/function/')


lw = 2.5;  set(0, 'DefaultAxesFontSize', 16);
fs = 15;  msize = 15;

pre_slope      = 10;  % number of predictors  from slopes
pre_direct   = 10; % number of predictors  from original spectra

disp('#####  Low Resolution Dataset 2:  Data Window - 1024 & shift 500  #####')

%% original spectra
load 'ovarian13.mat'; 
Ca= ovarian13.Ca ;
Co= ovarian13.Co ;
moz= ovarian13.moz ;

mu_A = mean(Ca,2); v_A = var(Ca',1); 
mu_O = mean(Co,2); v_O = var(Co',1);

F = (mu_A - mu_O).^2./ (v_A' + v_O');
F(find(isnan(F))) = 0;

% Select highest pr indexes
[r, q] = maxk(F, pre_direct);


%% Dataset2 : shift 500 - slope
load('SlopeDataSet8_7_2.mat');  

disp('#####  Ovarian Dataset 4-3-02:  Standard Variance  #####')
H_c = SlopeDataSet8_7_2.SloCa' ;
H_n = SlopeDataSet8_7_2.SloCo' ;
% 
H_c = SlopeDataSet8_7_2.SloCaDC' ;
H_n = SlopeDataSet8_7_2.SloCoDC' ;


d = (mean(H_n,1) - mean(H_c,1)).^2./ (var(H_n,1) + var(H_c,1));
d(find(isnan(d))) = 0;

% find column indexes of which mean slolp is greater that 50th quantile 
[r, k] = maxk(d, pre_slope);

k=sort(k);k(diff(k)==1)=[]
k
%%
J = 10; shift = 500;
d_window = 1: shift: size(Ca,1) - (2^J - 1);

A = zeros(length(d_window), 2^J);
for j = 1: length(d_window)
    start =  d_window(j); 
    range = start:start+(2^J-1);
    A(j, :) = range;
end

figure(1)
y = Ca(:, 40);
plot( y, "LineWidth", 1); hold on
xline(q , '--r', "LIneWidth", 2)

for i = 1: length(k)
a1 = A(k(i),:); b1 = y(a1);

a = area(a1, b1');
a.FaceAlpha = 0.5;
end 

%xline(d_window(k), '-k', "Linewidth",3)
ylabel("Intensity"); xlabel("M/z"); title("Cancer")
grid on

axes('position',[.4 .565 .25 .25])
box on % put box around new pair of axes

t = 1:length(moz);
indexOfInterest = (t < 1690) & (t > 1670);

plot(t(indexOfInterest),y(indexOfInterest)) % plot on new axes
xline(q(find(q<2000)) , '--r', "LIneWidth", 2)
axis tight
grid on
title('Features for the Direct Method')
text(16, 1, 'Top title')

axes('position',[.65 .565 .25 .25])
box on % put box around new pair of axes

t = 1:length(moz);
indexOfInterest = (t < 2240) & (t > 2230);

plot(t(indexOfInterest),y(indexOfInterest)) % plot on new axes
xline(q(find(q>2000)) , '--r', "LineWidth", 2)
axis tight
grid on
set(gca,'YTickLabel',[]);


