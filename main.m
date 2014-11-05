%# This is a program to calculate fluxes
%# Coded by Zhongwang Wei on 2014/11/02 @Tokyo Univ.
%# Modified by Zhongwang Wei on 2014/11/04 @Tokyo Univ.



selectH=input('Please select the observation height:\ (1) 2m; (2) 15m; (3) 30m:  ');
K=input('Please select the result:\ 1.original result; 2.corrected (rotation); 3.corrected (rotation+WPL):  ');
[qq,tt,wwb,q,U,WD,u_star,wt,wq,wc,Ta,P]=fluxcalculation(data,K); %flux calculation
 %obukhov length
%Z =(10.8-Zh)./L;   %obukhov scale length
T = Ta + 273.15 ; % ! [K];
e = q .* T./ 0.2167;  % ! [hPa]

if selectH==1
H=1;
elseif selectH==2
H=15;
elseif selectH==3
H=30;
else
printf('error');
end

rho98=1293 * 273.15./T .* (1013.25 - 0.378*e) / 1013.25 ;     %! [g/m3]
Fb=((9.8.*( wt+ (0.61*(Ta).*wq)./(rho98)))./(Ta));
ZL=(3)./((-u_star.^3)./(0.4.*Fb)); %warning！ the measurement height should be modified！！！

 [RN_uw,RN_vw,RN_wt,RN_wq,RN_wc,dfw,dft,dfq]=ECcontrol(data,ZL,wwb,wt,wq,u_star,tt,qq);



r = 1.293 * 273.15./T .* (1013.25 - 0.378*e) / 1013.25;   %! [kg/m3]
Cp_r = 1005. * (r + 0.84*q) ;  %! [J/m3/K]
Lv = 3151.05 - 2.37839*T ;  %! [J/kg]


 H = Cp_r.* wt  ;      %W/m2 sensible heat
 LE = Lv .* wq  ;      %W/m2 latent heat
 C = 1000 .* wc;       %μmol/m2/s co2 flux


 H = Cp_r.* wt  ;      %W/m2 sensible heat
 LE = Lv .* wq  ;      %W/m2 latent heat
 C = 1000 .* wc;       %μmol/m2/s co2 flux

