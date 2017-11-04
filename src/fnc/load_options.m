function [opt1,opt3,opt4]=load_options(handles, flag)

opt1=[my_get(handles.checkbox12,'value'),... % 1 include cell outline in final
    my_get(handles.checkbox13,'value'),...   % 2 zero values outside cells
    my_get(handles.checkbox36,'value'),...   % 3 display histograms
    my_get(handles.checkbox52,'value'),...   % 4 diplay Log10
    my_get(handles.checkbox53,'value'),...   % 5 combine ratios in RGB image
    my_get(handles.checkbox54,'value'),...   % 6 display images    
    my_get(handles.checkbox56,'value'),...   % 7 pixel by pixel
    my_get(handles.checkbox55,'value'),...   % 8 averaged over cells 
    my_get(handles.checkbox57,'value'),...   % 9 plot x-y-z graph
    my_get(handles.checkbox58,'value'),...   % 10 export data as ASCII
    my_get(handles.checkbox59,'value'),...   % 11 export figures as EPS
    my_get(handles.checkbox60,'value'),...   % 12 display ranking 
    my_get(handles.checkbox61,'value'),...   % 13 display depth profiles 
    my_get(handles.checkbox62,'value'),...   % 14 display lateral profiles
    my_get(handles.checkbox64,'value'),...   % 15 include graph title
    my_get(handles.checkbox63,'value')];     % 16 zero values in pixels with low counts

if(flag==1)
    
    opt3=[get(handles.checkbox14,'value'),...
        get(handles.checkbox15,'value'),...
        get(handles.checkbox16,'value'),...
        get(handles.checkbox17,'value'),...
        get(handles.checkbox18,'value'),...
        get(handles.checkbox19,'value'),...
        get(handles.checkbox20,'value'),...
        get(handles.checkbox71,'value')];
    
    opt4=[get(handles.checkbox25,'value'),...
        get(handles.checkbox26,'value'),...
        get(handles.checkbox27,'value'),...
        get(handles.checkbox28,'value'),...
        get(handles.checkbox29,'value'),...
        get(handles.checkbox30,'value'),...
        get(handles.checkbox31,'value'),...
        get(handles.checkbox70,'value')];
                   
else
    
    opt3=[get(handles.checkbox21,'value'),...
        get(handles.checkbox22,'value'),...
        get(handles.checkbox23,'value'),...
        get(handles.checkbox24,'value'),...
        get(handles.checkbox43,'value'),...
        get(handles.checkbox44,'value'),...
        get(handles.checkbox45,'value'),...
        get(handles.checkbox73,'value')];
    
    opt4=[get(handles.checkbox32,'value'),...
        get(handles.checkbox33,'value'),...
        get(handles.checkbox34,'value'),...
        get(handles.checkbox35,'value'),...
        get(handles.checkbox46,'value'),...
        get(handles.checkbox47,'value'),...
        get(handles.checkbox48,'value'),...
        get(handles.checkbox72,'value')];
    
end;