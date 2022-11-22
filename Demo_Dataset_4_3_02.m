clear all
close all
clc
%addpath('/Users/dixon/Documents/TAMU/DemosNew')
%addpath('/Users/dixon/Documents/TAMU/Ovarian')
%addpath('/Users/dixon/Documents/TAMU/DistVar/supCodes/function/')

p      = 3;  % number of predictors 
q      = .45; % threshold for logistic regression
train  = 0.67; % training samples %
isplot = 1;   % plot an example confusion table and control and case slops
n_pr   = 10; 

disp('#####  Low Resolution Dataset 2:  Data Window - 1024 & shift 500  #####')

% original spectra
load 'ovarian12.mat'; 
Ca= ovarian12.Ca ;
Co= ovarian12.Co ;
moz= ovarian12.moz ;

% slope
load('SlopeDataSet4_3_2.mat');  

%% Dataset2 : shift 500
%OvarianJointClassify(data, slope, tr_per, p, q, n_pr, isplot, ismethod)

disp('#####  Ovarian Dataset 4-3-02:  Standard Variance  #####')
H_c = SlopeDataSet4_3_2.SloCa' ;
H_n = SlopeDataSet4_3_2.SloCo' ;

slope.H_n = H_n; 
slope.H_c = H_c;

Ad = zeros(3, 6); Bd = zeros(3,6); Cd = zeros(3,6);
for i = 1:3 % i = 1 - direct, 2 - Slope, 3 - direct + slope
    ismethod = i;
    [a, b, c]= OvarianJointClassify(ovarian12, slope, train, p, q, n_pr, isplot, ismethod); 
    As(i,:) = a;  % accuracy
    Bs(i,:) = b;  % sensitivity and specificity
    %Cs(i,:) = c;
end

%%
A = ["Direct", "Slope", "Joint"];

fprintf('\n\n Ovarian Dataset 4-3-02 \n');
fprintf(' Size of the Data Window = 1024 \n');
fprintf(' Number of Predictors from slope: p = %i\n',p);
fprintf('Number of Predictors from direct spectra: n_pr = %i\n',n_pr);
fprintf(' Wavelet filter: Daubechies-6 \n');
fprintf('\n Sample Variance-based Wavelet Spectrum Method \n');
fprintf(' \n\n');
fprintf(' Accuracy');
fprintf(' \n\n');
fprintf( '               | Logistic Regression |           SVM        |       KNN      \n');
fprintf('--------------+---------------------+-----------------------+-----------------------\n');
fprintf('    Method     |   Train  |   Test   |    Train   |   Test  |     Train   | Test   \n');
fprintf('---------------+----------+----------+------------+---------+------------+---------\n');
for i=1:3
    fprintf('   %s     |   %.3f  |  %.3f  |    %.3f  |   %.3f|  %.3f    |  %.3f\n',A(i),As(i,:));
end 

%fprintf(' Sensitivity and Specificity');
fprintf(' \n');
fprintf( '               | Logistic Regression |           SVM        |       KNN           \n');
fprintf('--------------+---------------------+----------------------+-----------------------\n');
fprintf('    Method     |   Sensi  |   Speci   |    Sensi   |   Speci  |  Sensi  |   Speci  \n');
fprintf('---------------+----------+-----------+------------+--------- +---------+----------\n');
for i=1:3
    fprintf('   %s      |   %.3f  |  %.3f    |    %.3f   |  %.3f  |   %.3f |  %.3f \n', A(i),Bs(i,:));

end

%% #####  Ovarian Dataset 4-3-02:  Distance Variance  #####

H_c = SlopeDataSet4_3_2.SloCaDC' ;
H_n = SlopeDataSet4_3_2.SloCoDC' ;
slope.H_n = H_n; 
slope.H_c = H_c;

Ad = zeros(3, 6); Bd = zeros(3,6); Cd = zeros(3,6);
for i = 1:3 
    ismethod = i;
    [a, b, c]= OvarianJointClassify(ovarian12, slope, train, p, q, n_pr, isplot, ismethod); 
    Ad(i,:) = a; 
    Bd(i,:) = b;
    %Cd(i,:) = c;
end
%%
fprintf(' Distance Varaince-based Wavelet Spectrum Method \n');
fprintf(' \n\n');
fprintf(' Accuracy');
fprintf(' \n\n');
fprintf( '               | Logistic Regression |           SVM        |       KNN        \n');
fprintf('---------------+---------------------+----------------------+------------------\n');
fprintf('    Method     |   Train  |   Test   |    Train   |   Test  |  Train | Test     \n');
fprintf('---------------+----------+----------+------------+---------+--------+--------  \n');
for i=1:3
    fprintf('   %s     |   %.3f  |  %.3f  |    %.3f  |   %.3f| %.3f |%.3f | \n',A(i),Ad(i,:));
end 

fprintf(' \n\n');
fprintf(' Sensitivity and Specificity');
fprintf(' \n\n');
fprintf( '               | Logistic Regression |           SVM        |       KNN           |\n');
fprintf('---------------+---------------------+----------------------+---------------------- \n');
fprintf('    Method     |   Sensi  |   Speci  |    Sensi   |   Speci  |  Sensi  |   Speci  |\n');
fprintf('---------------+----------+----------+------------+----------+---------+----------\n');
for i=1:3
    fprintf('   %s      |   %.3f  |  %.3f    |    %.3f   |   %.3f  |   %.3f |  %.3f  | \n', A(i),Bd(i,:));

end
