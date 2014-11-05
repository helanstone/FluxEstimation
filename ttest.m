function [RN_uw,RN_vw,RN_wt,RN_wq,RN_wc]=ttest(data) %based on Xuhui Lee et al. Handbook of micrometeorology 2004
[Ux,Uy,Uz,Ts,Q0,CO2]=datatoread(data);

for i=0:5
Ux1=(Ux((i*3000+1):((i+1)*3000)));
Uy1=(Uy((i*3000+1):((i+1)*3000)));
Uz1=(Uz((i*3000+1):((i+1)*3000)));
t1=(Ts((i*3000+1):((i+1)*3000)));
q1=(Q0((i*3000+1):((i+1)*3000)));
c1=(CO2((i*3000+1):((i+1)*3000)));

%Us(i+1)=sqrt((mean(Ux1)).^2+(mean(Uy1)).^2);
uvar=(Ux1-mean(Ux1));
vvar=(Uy1-mean(Uy1));
wvar=(Uz1-mean(Uz1));

tvar=(t1-mean(t1));
qvar=(q1-mean(q1));
cvar=(c1-mean(c1));


uw5m(i+1)=mean(uvar.*wvar);
vw5m(i+1)=mean(vvar.*wvar);
wt5m(i+1)=mean(wvar.*tvar);
wq5m(i+1)=mean(wvar.*qvar);
wc5m(i+1)=mean(wvar.*cvar);
end
uvar30m=Ux-mean(Ux);
vvar30m=Uy-mean(Uy);
wvar30m=Uz-mean(Uz);
tvar30m=Ts-mean(Ts);
qvar30m=Q0-mean(Q0);
cvar30m=CO2-mean(CO2);

uw30m=mean(uvar30m.*wvar30m);
vw30m=mean(vvar30m.*wvar30m);
wt30m=mean(wvar30m.*tvar30m);
wq30m=mean(wvar30m.*qvar30m);
wc30m=mean(wvar30m.*cvar30m);


RN_uw=abs((mean(uw5m)-uw30m)/uw30m)*100;
RN_vw=abs((mean(vw5m)-vw30m)/vw30m)*100;
RN_wt=abs((mean(wt5m)-wt30m)/wq30m)*100;
RN_wq=abs((mean(wq5m)-wq30m)/wq30m)*100;
RN_wc=abs((mean(wc5m)-wc30m)/wc30m)*100;
end
