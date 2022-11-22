function [Case, Control] = NormalFisherTest(cancer, normal, q)
Ca = cancer; 
Co = normal; 
% pr - number of coefficients to be selected for recontruction

Case = zeros( size(Ca,1), size(Ca,2));
Case(q, :) = Ca(q,:);

Control = zeros( size(Co,1), size(Co,2));
Control(q, :) = Co(q,:);

end 