function  [qq,tt,wwb,q,U,WD,u_star,wt,wq,wc,Ta,P]=fluxcalculation(data,K)
[Ux,Uy,Uz,Ts,H2O,CO2,T,Pre]=datatoread(data);
U_umean=nanmean(Ux);
U_ymean=nanmean(Uy);
U_zmean=nanmean(Uz);
Ts_mean=nanmean(Ts);
CO2_mean=nanmean(CO2);
H2O_mean=nanmean(H2O);
Ta=nanmean(T);
P=nanmean(Pre);

uu=mean((Ux-U_umean).*(Ux-U_umean));
vv=mean((Uy-U_ymean).*(Uy-U_ymean));
ww=mean((Uz-U_zmean).*(Uz-U_zmean));
tt=mean((Ts-Ts_mean).*(Ts-Ts_mean));
cc=mean((CO2-CO2_mean).*(CO2-CO2_mean));
qq=mean((H2O-H2O_mean).*(H2O-H2O_mean));

uv=mean((Ux-U_umean).*(Uy-U_ymean));
uw=mean((Ux-U_umean).*(Uz-U_zmean));
ut=mean((Ux-U_umean).*(Ts-Ts_mean));
uc=mean((Ux-U_umean).*(CO2-CO2_mean));
uq=mean((Ux-U_umean).*(H2O-H2O_mean));


vw=mean((Uy-U_ymean).*(Uz-U_zmean));
vt=mean((Uy-U_ymean).*(Ts-Ts_mean));
vc=mean((Uy-U_ymean).*(CO2-CO2_mean));
vq=mean((Uy-U_ymean).*(H2O-H2O_mean));

wt=mean((Uz-U_zmean).*(Ts-Ts_mean));
wc=mean((Uz-U_zmean).*(CO2-CO2_mean));
wq=mean((Uz-U_zmean).*(H2O-H2O_mean))*0.018;
u_star = (uw.^2 + vw.^2) .^(1./4)   ;  %m/s friction velocity
q = H2O_mean * 18 * 10.^(-6) ;  %! [kg/m3];

WD=atan2(U_ymean, U_umean)*180/ pi ;   %Wind angle! should be confirmed!!                                
U=sqrt(U_ymean.^2+U_umean.^2);  

i=find(WD<0);                                                             
WD(i)=WD(i)+360;
j=find(WD>360);
WD(j)=WD(j)-360;
if K==1
   wwb=ww;
return;
elseif K==2
[wwb,u_star,wt,wq,wc]=rotation(U_umean,U_ymean,U_zmean,uu,vv,ww,uv,uw,vw,ut,vt,uc,vc,uq,vq,wt,wc,wq,U);
elseif K==3
[wwb,u_star,wt,wq,wc]=rotation(U_umean,U_ymean,U_zmean,uu,vv,ww,uv,uw,vw,ut,vt,uc,vc,uq,vq,wt,wc,wq,U);
[wc,wq]=WPL(Ta,H2O_mean,P,CO2_mean,wq,wt,wc);
end

end
