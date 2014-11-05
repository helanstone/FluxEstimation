function [wwb,u_star,wt,wq,wc]=rotation(Ux_a,Uy_a,Uz_a,Ux_v,Uy_v,Uz_v,Ux_Uy,Ux_Uz,Uy_Uz,Ux_Ts,Uy_Ts,Ux_CO2,Uy_CO2,Ux_H2O,Uy_H2O,Uz_Ts,Uz_CO2,Uz_H2O,U)

dth=atan2(Uy_a,Ux_a);                  
sa = sin(dth);                           
ca = cos(dth);                           
ua = Ux_a.*ca + Uy_a.*sa;                
va =-1*(Ux_a.*sa )+ Uy_a.*ca;            
wa = Uz_a;                               
uua = Ux_v.*(ca.^2)+Uy_v.*(sa.^2)+2*Ux_Uy.*(sa.*ca);    
vva = Ux_v.*(sa.^2)+Uy_v.*(ca.^2)-2*Ux_Uy.*(sa.*ca);    
wwa = Uz_v;                                            
uva = (Uy_v-Ux_v).*(sa.*ca) + Ux_Uy.*(ca.^2-sa.^2);     
uwa = Ux_Uz.*ca + Uy_Uz.*sa;                            
vwa = -1*(Ux_Uz.*sa) + Uy_Uz.*ca;                       
ut = Ux_Ts.*ca + Uy_Ts.*sa;                             
uc = Ux_CO2.*ca + Uy_CO2.*sa;         
uq = Ux_H2O.*ca + Uy_H2O.*sa;         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLOW INCLINATION CORRECTION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fth =atan2(Uz_a,U);                                   
sb = sin(fth);                                          
cb = cos(fth);                                         
ub = ua.*cb + wa.*sb;                                   
vb = va;                                                
wb = -ua.*sb + wa.*cb;                                  
uub = uua.*(cb.^2) + wwa.*(sb.^2) + 2*uwa.*(sb.*cb);    
vvb = vva;                                              
wwb = uua.*(sb.^2) + wwa.*(cb.^2) - 2*uwa.*sb.*cb;     
uvb = uva.*cb + vwa.*sb;                                
uwb = (wwa-uua).*sb.*cb + uwa.*(cb.^2-sb.^2);                        
vwb = -uva.*sb + vwa.*cb;                               
wt = -ut.*sb +Uz_Ts.*cb;                                
wc = -uc.*sb + Uz_CO2.*cb;                              
wq = -uq.*sb + Uz_H2O.*cb;   
%wq =  Uz_H2O.*cb;   
u_star=(abs(uwb)).^0.5;
return
end
