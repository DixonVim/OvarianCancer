clear all
close all
%clc
%addpath('/Users/dixon/Documents/TAMU/DemosNew')
%addpath('/Users/dixon/Documents/TAMU/Ovarian')
%addpath('/Users/dixon/Documents/TAMU/DistVar/supCodes/function/')

p      = 10;  % number of predictors 
q      = .45; % threshold for logistic regression
train  = 0.67; % training samples %
isplot = 1;   % plot an example confusion table and control and case slops
n_pr   = 10; 

disp('#####  Low Resolution Dataset 2:  Data Window - 1024 & shift 500  #####')

%% original spectra
load 'ovarian12.mat'; 
Ca= ovarian12.Ca ;
Co= ovarian12.Co ;
moz= ovarian12.moz ;

mu_A = mean(Ca,2); v_A = var(Ca',1); 
mu_O = mean(Co,2); v_O = var(Co',1);

F = (mu_A - mu_O).^2./ (v_A' + v_O');
F(find(isnan(F))) = 0;

% Select highest pr indexes
pr = 10;
[r, q] = maxk(F, pr);

%% Dataset2 : shift 500 - slope
load('SlopeDataSet4_3_2.mat');  

disp('#####  Ovarian Dataset 4-3-02:  Standard Variance  #####')
H_c = SlopeDataSet4_3_2.SloCa' ;
H_n = SlopeDataSet4_3_2.SloCo' ;

H_c = SlopeDataSet4_3_2.SloCaDC' ;
H_n = SlopeDataSet4_3_2.SloCoDC' ;
% slope.H_n = H_n; 
% slope.H_c = H_c;

d = (mean(H_n,1) - mean(H_c,1)).^2./ (var(H_n,1) + var(H_c,1));
d(find(isnan(d))) = 0;

% find column indexes of which mean slolp is greater that 50th quantile 
[r, k] = maxk(d, p);

%k=sort(k);k(diff(k)==1)=[];
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
y = abs(Ca(:, 40));
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

axes('position',[.65 .665 .25 .25])
box on % put box around new pair of axes

t = 1:length(moz);
indexOfInterest = (t < 100) & (t > 20);

plot(t(indexOfInterest),y(indexOfInterest)) % plot on new axes
xline(q(find(q<100)) , '--r', "LIneWidth", 2)
axis tight
grid on


axes('position',[.65 .275 .25 .25])
box on % put box around new pair of axes

t = 1:length(moz);
indexOfInterest = (t < 1000) & (t > 950);

plot(t(indexOfInterest),y(indexOfInterest)) % plot on new axes
xline(q(find(q>100)) , '--r', "LineWidth", 2)
axis tight
grid on


