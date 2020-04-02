
function [timec,swtemp,timec_new, swtemp_new,Temp_smooth,Temp_std] = BlobDataLab(year)
%BlobDataLab Summary of this function goes here
%   function to assess all the years of data 

filename =['deployment000(year)_GP03FLMB.nc']

ncdisp(filename);

lat=ncreadatt(filename,'/','lat');
lon=ncreadatt(filename, '/','lon');

time=ncread(filename,'time');
swtemp=ncread(filename,'ctdmo_seawater_temperature');

time0=datenum('1900-01-01 0:0:0');
timec=time0+(time/86400);

resol=diff(time/60);

Temp_smooth = movmean(swtemp,1440/resol);

k = find(Temp_std < 1.2);

swtemp_new = swtemp(k);
timec_new = timec(k);



end
