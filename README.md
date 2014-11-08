#FluxEstimation :octocat:
## Project: For eddy correlation data analysis！
The project included **1. flux calculation** :sparkles:
                     **2. quality control** :sparkles:
 



### Filefolder :file_folder:

File Name | Purpose
---------- | -----------
**main.m** | This file contains a function to obtain the whole result
**fluxcalculation.m** | This file implements the flux calculation.
**ECcontrol.m** | This file contains quality control
**rotaion.m** | This file contains twice rotation correction for eddy correlation data (reference: Kaimal and Finnigan (1994)).
**WPL.m** | This file contains twice rotation for eddy correlation data (reference: Lee et al.(2004)).
**ttest.m** | This file contains stationarity test (reference: Lee et al. (2004)).
**ITC.m** | This file contains ITC test (reference: Kaimal and Finnigan (1994)).
**datatoread.m** | This file reads the matrix data from bat file
**brutsaertstability**| Now this function is not used, but it is important in future (e.g. wind profile studies).
**ECbook2013.pdf**| Book provided by LI-COR
## Filefolder :fortran:

File Name | Purpose
---------- | -----------
**stationaritytest.f** | This file contains stationarity test (reference: Lee et al. 2004)
**fluxcalculation.f** | This file implements the flux calculation.


### Fix the :bug: bug

The provided files *fluxcalculation.m* and *main.m* both have bugs and therefore the provided tests fail. The following changes were made:

File Name | Changes
---------- | -----------
**main.m** |  The corrected code should be : `selectH=input('Please select the observation height:\ (1) 2m; (2) 15m; (3) 30m:  ');`
**fluxcalculation.m** | The bug in the function *fluxcalculation* has been fixed.
**README.md** | The misdescribe in readme.md has been corrected.

### Add new functionalities

File Name | New functionality
---------- | -----------
**ttest.m** | <ul><li>Add new outputs *RN_wt,RN_wq,RN_wc* which return stationarity results for wt, wq and wc.
```matlab
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
```




### Add additional test examples
The code has been tested by 2hr (30min interval) data.

### Update in future

1. Code comments will be added in future.

2. Automatic data-input system will be established.

3. Automatic plot results system will be established.

4. Rotation into the planar fit coordinate will be carried out. 


### Reference
**Lee, Xuhui, W. J. Massman, and Beverly E. Law, eds.** Handbook of micrometeorology: a guide for surface flux measurement and analysis. Vol. 29. Springer, 2006.

**Stull, Roland B.** An introduction to boundary layer meteorology. Vol. 13. Springer, 1988.

**Kaimal, Jagadish Chandran, and John J. Finnigan.** Atmospheric boundary layer flows: their structure and measurement. 1994.


### Summary
In this project, bugs in the origional provided files from Wei (2013) are fixed and several new functionality are added. 

### How to use? :eyes:
If you would like to use this program, one could do in the following way:

import the 30min data and rename it into `data`

### The End

**Found a :bug: bug?** Contact me through :e-mail: _weizw@aori.u-tokyo.ac.jp_. :trollface:
