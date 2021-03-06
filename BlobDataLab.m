
function [timec,swtemp,timec_new, swtemp_new,Temp_smooth,Temp_std,temp_smooth_new] = BlobDataLab(filename,cutoffval)

%BlobDataLab Summary of this function goes here
%   function to assess all the years of data 
%1a. Use the function "ncdisp" to display information about the data contained in this file
ncdisp(filename);

%1b. Use the function "ncreadatt" to extract the latitude and longitude
%attributes of this dataset
lat=ncreadatt(filename,'/','lat');
lon=ncreadatt(filename, '/','lon');

%1c. Use the function "ncread" to extract the variables "time" and
%"ctdmo_seawater_temperature"
time=ncread(filename,'time');
swtemp=ncread(filename,'ctdmo_seawater_temperature');

% Extension option: Also extract the variable "pressure" (which, due to the
% increasing pressure underwater, tells us about depth - 1 dbar ~ 1 m
% depth). How deep in the water column was this sensor deployed?
pressure=ncread(filename,'ctdmo_seawater_pressure');
p_max=max(pressure);
p_avg=mean(pressure);

% 2. Converting the timestamp from the raw data to a format you can use
% Use the datenum function to convert the "time" variable you extracted
% into a MATLAB numerical timestamp (Hint: you will need to check the units
% of time from the netCDF file.)

time0=datenum('1900-01-01 0:0:0');

timec=time0+(time/86400);

% 2b. Calculate the time resolution of the data (i.e. long from one
% measurement to the next) in minutes. Hint: the "diff" function will be
% helpful here.

resol=diff(time./60);
resol=mean(resol);

% 4a. Use the movmean function to calculate a 1-day (24 hour) moving mean
% to smooth the data. 
minperday = 60*24;
num2smooth = minperday/resol;
Temp_smooth = movmean(swtemp,num2smooth);

% 4b. Use the movstd function to calculate the 1-day moving standard
% deviation of the data.
Temp_std = movstd(swtemp,num2smooth);

%6b. Find the indices of the data points that you are not excluding based
%on the cutoff chosen in 6a.

k = find(Temp_std < cutoffval);

swtemp_new = swtemp(k);

timec_new = timec(k);

temp_smooth_new = movmean(swtemp_new,num2smooth;

end



