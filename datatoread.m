function [Ux,Uy,Uz,Ts,H2O,CO2,T,P]=datatoread(data)
TIMESTAMP	 =	data	( :,	1	);
RECORD	 =	data	( :,	2	);
Ux	 =	data	( :,	3	);
Uy	 =	data	( :,	4	);
Uz	 =	data	( :,	5	);
Ts	 =	data	( :,	6	);
diag_sonic	 =	data	( :,	7	); %unknown
CO2	 =	data	( :,	8	)/44; %mg/m3 to mmol/m3 co2 data
H2O	 =	data	( :,	9	)*1000/18;%g/m3 to mmol/m3 h2O data
diag_irga	 =	data	( :,	10	); %unknown
T	 =	data	( :,	11	); % C  temperature
P	 =	data	( :,	12	)*10; % hp  pressure
CO2_sig_strgth	 =	data	( :,	13	); %unknown
H2O_sig_strgth	 =	data	( :,	14	); %unknown
end
