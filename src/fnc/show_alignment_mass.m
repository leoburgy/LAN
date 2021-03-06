function handles = show_alignment_mass(handles)

p1 = load_masses_parameters(handles);
k=identifyMass(p1.mass,p1.alignment_mass);

% view the alignment mass and select which images should be deselected
% switch k,
%     case 2, images=str2num(get(handles.edit13,'string'));
%     case 3, images=str2num(get(handles.edit14,'string'));
%     case 4, images=str2num(get(handles.edit15,'string'));
%     case 5, images=str2num(get(handles.edit16,'string'));
%     case 6, images=str2num(get(handles.edit17,'string'));
%     case 7, images=str2num(get(handles.edit18,'string'));
%     case 8, images=str2num(get(handles.edit75,'string'));
%     otherwise, 
      images=str2num(get(handles.edit12,'string'));
% end;
all_images=[1:size(handles.p.im{1},3)];
if(isempty(images))
    images=all_images;
end;
ind = setdiff(all_images,images);
deselected=zeros(size(all_images));
deselected(ind)=ones(size(ind));

% open GUI for selecting the images and alignment region
a=show_stack_win(handles.p.im{k},deselected);

if ~handles.p.planes_aligned

    % update vectors of images that will be used in accumulation
    ind=find(a.deselected==1);
    images=setdiff(all_images,ind);

    % if images = all_images, set images to [], which is the default if all
    % images are to be accumulated
    if(isempty(setdiff(all_images,images)))
        images=[];
    end;

    % update the images in the GUI
    handles = fillinfo_selected_images(images, handles);

    % update special region for alignment
    xlim=a.region_x;
    ylim=a.region_y;
    set(handles.edit44,'string',['[',num2str(ceil(xlim(1))),':',num2str(floor(xlim(2))),']']);
    set(handles.edit45,'string',['[',num2str(ceil(ylim(1))),':',num2str(floor(ylim(2))),']']);

else
    fprintf(1,'Alignment region and images NOT updated as the masses have been already aligned!\n');
end;
