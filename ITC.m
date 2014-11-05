function [dfw,dft,dfq]=ITC(ZL,wwb,wt,wq,Ustar,Ts_v,H2O_v) % based on Kaimal and Finnifan atmospheric boundary layer flower P16
Tstar=wt./Ustar;
Qstar=wq./Ustar;

fw=ones(length(Tstar),1);
dfw=ones(length(Tstar),1);
fw_e=ones(length(Tstar),1);
for i=1:length(Tstar)
%tubulence characteristic test
if(-2<ZL(i))&&(ZL(i)<=0)
      fw(i) = ((abs(wwb(i))).^0.5)./(Ustar(i));
      fw_e(i) =1.25*(abs(1+3*abs(ZL(i))).^(1/3));
      dfw(i)=abs((fw_e(i)-fw(i))./fw_e(i))*100;
end
if(0<ZL(i))&&(ZL(i)<=1)
    fw(i) = ((abs(wwb(i))).^0.5)./(Ustar(i));
    fw_e(i) = 1.25*(1+0.2*abs(ZL(i)));
     dfw(i)=abs((fw_e(i)-fw(i))./fw_e(i))*100;
end

% % 
if(-2<ZL(i))&&(ZL(i)<=0)
ft(i) = ((abs(Ts_v(i))).^0.5)./(Tstar(i));
ft_e(i) =2*((1-9.5*(ZL(i))).^(-1/3));
dft(i)=abs((ft_e(i)-ft(i))./ft_e(i))*100;
end


if(0<ZL(i))&&(ZL(i)<=1)
ft(i) = (((Ts_v(i))).^0.5)./abs(Tstar(i));
ft_e(i) = 2*(1+0.5*abs(ZL(i))).^(-1);
dft(i)=abs((ft_e(i)-ft(i))./ft_e(i))*100;   
end
% 

if(-2<ZL(i))&&(ZL(i)<=0)
fq(i) = ((abs(H2O_v(i))).^0.5)./(Qstar(i));
fq_e(i) =2*((1-9.5*(ZL(i))).^(-1/3));
dfq(i)=abs((fq_e(i)-fq(i))./fq_e(i))*100;
end

if(0<ZL(i))&&(ZL(i)<=1)
fq(i) = (((H2O_v(i))).^0.5)./abs(Qstar(i));
fq_e(i) = 2*(1+0.5*abs(ZL(i))).^(-1);
dfq(i)=abs((fq_e(i)-fq(i))./fq_e(i))*100;
end

if(ZL(i)>1)||(ZL(i)<-2)
    dfw(i)=0;
    dfq(i)=0;
    dft(i)=0;  
end

end
