function  [qq,tt,wwb,q,U,WD,u_star,wt,wq,wc,Ta,P]=fluxcalculation(data,K)
[Ux,Uy,Uz,Ts,H2O,CO2,T,Pre]=datatoread(data); % read data
U_umean=nanmean(Ux); % x-componet wind speed average m/s
U_ymean=nanmean(Uy);  %y-componet wind speed average m/s
U_zmean=nanmean(Uz); % z-componet wind speed average m/s
Ts_mean=nanmean(Ts);  % temperature average C
CO2_mean=nanmean(CO2); % co2 density average ppmv
H2O_mean=nanmean(H2O); % H2O density average ppmv
Ta=nanmean(T);  %temperature average
P=nanmean(Pre); %pressure average

uu=mean((Ux-U_umean).*(Ux-U_umean)); %covariance of uu
vv=mean((Uy-U_ymean).*(Uy-U_ymean)); %covariance of vv
ww=mean((Uz-U_zmean).*(Uz-U_zmean)); %covariance of ww
tt=mean((Ts-Ts_mean).*(Ts-Ts_mean));%covariance of tt
cc=mean((CO2-CO2_mean).*(CO2-CO2_mean));%covariance of cc
qq=mean((H2O-H2O_mean).*(H2O-H2O_mean));%covariance of qq

uv=mean((Ux-U_umean).*(Uy-U_ymean));%covariance of uv
uw=mean((Ux-U_umean).*(Uz-U_zmean));%covariance of uw
ut=mean((Ux-U_umean).*(Ts-Ts_mean));%covariance of ut
uc=mean((Ux-U_umean).*(CO2-CO2_mean));%covariance of uc
uq=mean((Ux-U_umean).*(H2O-H2O_mean));%covariance of uq


vw=mean((Uy-U_ymean).*(Uz-U_zmean));%covariance of vw
vt=mean((Uy-U_ymean).*(Ts-Ts_mean%covariance of vt
vc=mean((Uy-U_ymean).*(CO2-CO2_mean));%covariance of vc
vq=mean((Uy-U_ymean).*(H2O-H2O_mean));%covariance of vq

wt=mean((Uz-U_zmean).*(Ts-Ts_mean));%covariance of wt
wc=mean((Uz-U_zmean).*(CO2-CO2_mean));%covariance of wc
wq=mean((Uz-U_zmean).*(H2O-H2O_mean))*0.018;%covariance of wq
u_star = (uw.^2 + vw.^2) .^(1./4)   ;  %m/s friction velocity
q = H2O_mean * 18 * 10.^(-6) ;  %! [kg/m3];

WD=atan2(U_ymean, U_umean)*180/ pi ;   %Wind angle! should be confirmed!!                                
U=sqrt(U_ymean.^2+U_umean.^2);  %wind speed m/s

%wind direction correction
i=find(WD<0);                                                             
WD(i)=WD(i)+360;
j=find(WD>360);
WD(j)=WD(j)-360;

if K==1 %no correction
   wwb=ww;
return;
elseif K==2% rotation only
[wwb,u_star,wt,wq,wc]=rotation(U_umean,U_ymean,U_zmean,uu,vv,ww,uv,uw,vw,ut,vt,uc,vc,uq,vq,wt,wc,wq,U);
elseif K==3%rotation and WPL correction
[wwb,u_star,wt,wq,wc]=rotation(U_umean,U_ymean,U_zmean,uu,vv,ww,uv,uw,vw,ut,vt,uc,vc,uq,vq,wt,wc,wq,U);
[wc,wq]=WPL(Ta,H2O_mean,P,CO2_mean,wq,wt,wc);
end

end
