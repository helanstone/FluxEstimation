function [wc,wq]=WPL(Tair_1_AVG,H2O_a,Press_AVG,CO2_a,wq,wt,wc)

Twpl = Tair_1_AVG + 273.15;                      % temperature at K       
ewpl=((H2O_a.*Twpl)./216.7)*0.018;                %    water vapor pressure hpa？--unit should be checked  
rdwpl=((1293*273.15)./(Twpl)).*((Press_AVG-0.378*ewpl)./1013.25);  % vepor density   --unit should be checked
%rdwpl=((1293*273.15)./(Twpl)).*((Press_AVG)./1013.25);  
kk=(1.608*H2O_a* 0.018)./rdwpl;        %check it ! forgot                              
wc=wc+1.608*((CO2_a.*0.044).*wq)./rdwpl + (((1+kk).*CO2_a*0.044).*wt)./Twpl;  %WPL correction for wc
wq = (1+kk).*(wq+((H2O_a*0.018).*wt)./(Twpl));         %WPL correction for wq                        
% 
return
