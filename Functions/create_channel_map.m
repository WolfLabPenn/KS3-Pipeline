function create_channel_map(map,bad_channels,x,y,name,path_to_save)
chanMap=map(:);
chanMap0ind=chanMap-1;
xcoords=x(:);
ycoords=y(:);
kcoords=ones(length(map),1);
connected=ones(length(map),1);
connected(bad_channels)=0;
save(fullfile(path_to_save,[name,'_channel_map']),'chanMap','chanMap0ind','xcoords','ycoords','kcoords','connected','name');
