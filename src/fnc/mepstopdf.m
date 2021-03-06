function outfname = mepstopdf(infile,command,tidy_up_flag, be_verbous_flag, move_pdf)
outfname = [];

if(nargin>2)
    tuf=tidy_up_flag;
else
    tuf=1;
end;

if(nargin>3)
    vf=be_verbous_flag;
else
    vf=1;
end;

if(nargin>4)
    m_pdf=move_pdf;
else
    m_pdf=1;
end;


%disp(['Processing file ',infile]);
olddir=pwd;
[dname, filename, ext] = fileparts(infile);

global additional_settings;

if(~isempty(command))
    
    if ismac
        global LATEXDIR;
        command = [LATEXDIR command];
    end;
    
    if ~isempty(strfind(command,'epstopdf')) & ~additional_settings.compress_pdf;
        fprintf(1,'Executing epstopdf without compression...');
        command = [command ' --gsopt="-dPDFSETTINGS=/prepress -dAutoFilterColorImages=false -dAutoFilterGrayImages=false -sColorImageFilter=FlateEncode -sGrayImageFilter=FlateEncode -sCompressPages=false -dPreserveHalftoneInfo=true"'];
        fprintf(1,'Done\n');
    end;
        
    s=['!',command,' "',infile,'"'];
    
    if(~isempty(strfind(command,'pdflatex')))
        
        if(isunix)
            % to make it 'quiet', redirect the pdflatex output to log.log
            % file (which will be later on deleted anyway), because
            % pdflatex -quiet somehow doesn't seem to work under linux
            s = [s ' >log.log'];
        end;
        
        if(ispc)
            s=['!',command,' -quiet "',infile,'"']; 
        end;
        
        newfile = [dname delimiter filename '.pdf'];
        fprintf(1,'*** Warning: pdflatex command will now be executed.\n');
        fprintf(1,'*** If Matlab appears to hang, this could be because pdflatex encountered\n');
        fprintf(1,'*** errors during compilation. Press x or q several times to try to rescue\n');
        fprintf(1,'*** the LANS session. Then, check the TeX file output and try to compile it\n');
        fprintf(1,'*** manually to identify the problem. Sorry for inconvenience.\n');
        
    end;
    
    
    try,
        cd(dname);
        eval(s);
        % remove the aux, out and log files, if generated by pdflatex
        if(~isempty(strfind(command, 'pdflatex')) & tuf)
            f=dir('*.aux');
            for ii=1:length(f)
                fname=f(ii).name;
                if(exist(fname)==2)
                    delete(fname);
                end;
            end;
            f=dir('*.log');
            for ii=1:length(f)
                fname=f(ii).name;
                if(exist(fname)==2)
                    delete(fname);
                end;
            end;
            f=dir('*.out');
            for ii=1:length(f)
                fname=f(ii).name;
                if(exist(fname)==2)
                    delete(fname);
                end;
            end;
        end;
        cd(olddir);
        
        % move the pdf file generated by epstopdf to a pdf directory
        if ~isempty(strfind(command,'epstopdf'))
            
            if m_pdf
                pdfdir = fileparts(dname);
                pdfdir = [pdfdir delimiter 'pdf'];
                if ~isdir(pdfdir)
                    mkdir(pdfdir)
                    fprintf(1,'Directory %s did not exist, so it was created.\n', pdfdir);
                end;
            end;
            
            oldfile = [dname delimiter filename '.pdf'];
            if exist(oldfile)==2 & m_pdf
                newfile = [pdfdir delimiter filename '.pdf'];
                movefile(oldfile,newfile);
            else 
                newfile = oldfile;
            end;
            
            % remove the EPS file if it is not requested to be kept
            if ~additional_settings.export_eps
                delete(infile);
                fprintf(1,'%s deleted.\n',infile);
            end;
            
        end;
        
        if vf & exist(newfile)==2
            disp(['PDF output generated in ',newfile]);        
        end;
        
        if exist(newfile)==2
            outfname = newfile;
        end;
        
    catch exception
        fprintf(1,'Error occurred during execution of %s\n',command);
        fprintf(1,'Please verify that LaTeX or at least epstopdf is installed.\n');
    end;
    
end;
