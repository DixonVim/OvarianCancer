clear all
close all
addpath('/Users/dixon/Documents/TAMU/DemosNew')
addpath('/Users/dixon/Documents/TAMU/Ovarian')
addpath('/Users/dixon/Documents/TAMU/DistVar/supCodes/function/')

p      = 3;  % number of predictors 
q      = .45; % threshold for logistic regression
train  = 0.67; % training samples %
isplot = 1;   % plot an example confusion table and control and case slops
n_pr = 10; 
disp('#####  Low Resolution Dataset 2:  Data Window - 1024 & shift 500  #####')

% original spectra
load 'ovarian13.mat'; 
Ca= ovarian13.Ca ;
Co= ovarian13.Co ;
moz= ovarian13.moz ;

% slope
load('SlopeDataSet8_7_2.mat');  

%% Dataset2 : shift 500
%OvarianJointClassify(data, slope, tr_per, p, q, n_pr, isplot, ismethod)

disp('#####  Ovarian Dataset 8-7-02:  Standard Variance  #####')
H_c = SlopeDataSet8_7_2.SloCa' ;
H_n = SlopeDataSet8_7_2.SloCo' ;

slope.H_n = H_n; 
slope.H_c = H_c;

Ad = zeros(3, 6); Bd = zeros(3,6); Cd = zeros(3,6);
for i = 1:3
    ismethod = i;
    [a, b, c]= OvarianJointClassify(ovarian13, slope, train, p, q, n_pr, isplot, ismethod); 
    As(i,:) = a; 
    Bs(i,:) = b; 
    Cs(i,:) = c;
end

A = ["Direct", "Slope", "Joint"];

 fprintf('\n\n Ovarian Dataset 8-7-02 \n');
fprintf('\n\n Sample Variance-based Wavelet Spectrum Method \n');
fprintf(' Size of the Data Window = 1024 \n');
fprintf(' Number of Predictors from slope: p = %i\n',p);
fprintf('Number of Predictors from direct spectra: n_pr = %i\n',n_pr);
fprintf(' Wavelet filter: Daubechies-6 \n');
fprintf(' Accuracy');
fprintf(' \n');
fprintf( '               | Logistic Regression |           SVM        |       KNN      \n');
fprintf('--------------+---------------------+----------------------+------------------\n');
fprintf('    Method     |   Train  |   Test   |    Train   |   Test  |  Train | Test   \n');
fprintf('---------------+----------+----------+------------+---------+--------+--------\n');
for i=1:3
    fprintf('   %s     |   %.3f  |  %.3f  |    %.3f  |   %.3f| %.3f |%.3f\n',A(i),As(i,:));
end 


fprintf(' Sensitivity and Specificity');
fprintf(' \n');
fprintf( '               | Logistic Regression |           SVM        |       KNN           \n');
fprintf('--------------+---------------------+----------------------+-----------------------\n');
fprintf('    Method     |   Sensi  |   Speci   |    Sensi   |   Speci  |  Sensi  |   Speci  \n');
fprintf('---------------+----------+-----------+------------+--------- +---------+----------\n');
for i=1:3
    fprintf('   %s      |   %.3f  |  %.3f    |    %.3f   |   %.3f  |   %.3f |  %.3f \n', A(i),Bs(i,:));

end
%%
disp('#####  Ovarian Dataset 8-7-02:  Distance Variance  #####')

H_c = SlopeDataSet8_7_2.SloCaDC' ;
H_n = SlopeDataSet8_7_2.SloCoDC' ;
slope.H_n = H_n; 
slope.H_c = H_c;


disp('standard wavelet spectrum')
As = zeros(5, 6); Bs = zeros(5,6); Cs = zeros(5,6);
for i = 1:3
    ismethod = i;
    [a, b, c]= OvarianJointClassify(ovarian13, slope, train, p, q, n_pr, isplot, ismethod); 
    Ad(i,:) = a; 
    Bd(i,:) = b;
    Cd(i,:) = c;
end

A = ["Direct", "Slope", "Joint"];

 fprintf('\n\n Ovarian Dataset 4-3-02 \n');
fprintf('\n\n Sample Variance-based Wavelet Spectrum Method \n');
fprintf(' Size of the Data Window = 1024 \n');
fprintf(' Number of Predictors from slope: p = %i\n',p);
fprintf('Number of Predictors from direct spectra: n_pr = %i\n',n_pr);
fprintf(' Wavelet filter: Daubechies-6 \n');
fprintf(' Accuracy');
fprintf(' \n');
fprintf( '               | Logistic Regression |           SVM        |       KNN      \n');
fprintf('--------------+---------------------+----------------------+------------------\n');
fprintf('    Method     |   Train  |   Test   |    Train   |   Test  |  Train | Test   \n');
fprintf('---------------+----------+----------+------------+---------+--------+--------\n');
for i=1:3
    fprintf('   %s     |   %.3f  |  %.3f  |    %.3f  |   %.3f| %.3f |%.3f\n',A(i),Ad(i,:));
end 


fprintf(' Sensitivity and Specificity');
fprintf(' \n');
fprintf( '               | Logistic Regression |           SVM        |       KNN           \n');
fprintf('--------------+---------------------+----------------------+-----------------------\n');
fprintf('    Method     |   Sensi  |   Speci   |    Sensi   |   Speci  |  Sensi  |   Speci  \n');
fprintf('---------------+----------+-----------+------------+--------- +---------+----------\n');
for i=1:3
    fprintf('   %s      |   %.3f  |  %.3f    |    %.3f   |   %.3f  |   %.3f |  %.3f \n', A(i),Bd(i,:));

end