filename_jpl ='jplMURSST41anommday_cb7b_4b2f_bb57.nc';

ncdisp(filename_jpl)

lat=ncread(filename_jpl,'latitude');
lat2 = double(lat);
lon=ncread(filename_jpl,'longitude');
lon2 = double(lon);
time=ncread(filename_jpl,'time');
sstAnom=ncread(filename_jpl,'sstAnom');
OSPlat=50.3777;
OSPlong=-144.5149;
%%

figure (1)
worldmap([20 60],[-179 -100])
contourfm(lat2, lon2, sstAnom(:,:,38)','linecolor','none');
colorbar('eastoutside')
geoshow('landareas.shp','FaceColor','black')
hold on
scatterm(OSPlat,OSPlong,40,'m','filled')

