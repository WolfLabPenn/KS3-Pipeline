function [x,y,id]=read_probe(filename,options)

arguments
    filename
    options.plot  (1,1)logical =true;
    options.remap (1,:) double =[];
end

fid = fopen(filename);
raw = fread(fid,inf);
str = char(raw');
fclose(fid);
data = jsondecode(str);

temp=data.probes.contact_ids ;
id=zeros(size(temp));
for i=1:length(temp)
    id(i)=str2double(temp{i});
end

if ~isempty(options.remap)
    remap=options.remap;
else
    remap=1:length(id);
end

coords=data.probes.contact_positions;
coords=coords(remap,:);
x=coords(:,1);
y=coords(:,2);

if options.plot
    temp=data.probes.shank_ids;
    shanks=zeros(size(temp));
    for i=1:length(temp)
        shanks(i)=str2double(temp{i});
    end
    shanks=shanks(remap);

    fill(data.probes.probe_planar_contour(:,1),data.probes.probe_planar_contour(:,2),[0.7294    0.6902    0.6745])
    screen_size = get(0,'screensize');
    set(gcf,'Position', screen_size)
    hold on
    plot(coords(:,1),coords(:,2),'s',Color=[0.3059    0.4745    0.6549],markersize=20,MarkerFaceColor=my_colors('cyan'))
    for i=1:length(coords)
        text(coords(i,1),coords(i,2),num2str(id(i)),"HorizontalAlignment","center","VerticalAlignment","middle");
    end
    u_shanks=unique(shanks);
    for i=1:length(u_shanks)
        x_temp=coords(shanks==u_shanks(i),1);
        y_temp=coords(shanks==u_shanks(i),2);
        x_s=mean(x_temp);
        y_s=max(y_temp);
        text(x_s,y_s*1.1,sprintf('Shank %0.0f',u_shanks(i)),"FontWeight","bold","HorizontalAlignment","center","VerticalAlignment","middle")
    end
    xlabel(['X [',data.probes.si_units,']'])
    ylabel(['Y [',data.probes.si_units,']'])
    title(data.probes.annotations.name)
end