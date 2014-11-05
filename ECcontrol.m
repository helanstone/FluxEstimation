function [RN_uw,RN_vw,RN_wt,RN_wq,RN_wc,dfw,dft,dfq]=ECcontrol(data,ZL,wwb,wt,wq,Ustar,Ts_v,H2O_v)
[Ux,Uy,Uz,Ts,Q0,CO2]=datatoread(data);
[RN_uw,RN_vw,RN_wt,RN_wq,RN_wc]=ttest(data); 
[dfw,dft,dfq]=ITC(ZL,wwb,wt,wq,Ustar,Ts_v,H2O_v);

end
