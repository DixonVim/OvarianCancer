function [Case, Control, q] = NormalFisherTrain(cancer, normal, pr, isplot)
% Select most significant features from case and control spectra  using
% fisher's criteria
% ##  Input
% cancer - case ovarian spectra 
% normal - control ovarain spectra
% pr - number of coefficients to be selected for recontruction
% isplot - plot selected spectra

% ## Out
% Case - selected case spectra
% Control - selected  control spectra 
% q - selected M/z vale 

% Origninal case and control spectra
Ca = cancer; 
Co = normal; 

%% Fisher's criteria
mu_A = mean(Ca,2); v_A = var(Ca',1); 
mu_O = mean(Co,2); v_O = var(Co',1);

F = (mu_A - mu_O).^2./ (v_A' + v_O');
F(find(isnan(F))) = 0;

%% Select highest pr indexes
[r, q] = maxk(F, pr);

%% Select M/z values corresponding to highest F values 

Case = zeros( size(Ca,1), size(Ca,2));
Case(q, :) = Ca(q,:);

Control = zeros( size(Co,1), size(Co,2));
Control(q, :) = Co(q,:);

%% Plot a sample spectrum from case and normal
 lw = 2.5; 
 set(0, 'DefaultAxesFontSize', 16);
 fs = 15;
 msize = 10;
 t= 10; % spectrum id to plot
 
if isplot == 1 
    figure(2)
    subplot(211)
        plot( Control(1:size(Co,1),t),'-k', 'DisplayName', 'Standard');
        xlabel('M/z');
        ylabel('Intensity')
        grid on
        title('Normal'); %ylim([70 100])

    subplot(212)    
        plot(Case(1:size(Ca,1),t),'-k', 'DisplayName', 'Standard');
        xlabel('M/z');ylabel('Intensity')
        grid on
        title('Cancer'); %ylim([70
end 
    
end 