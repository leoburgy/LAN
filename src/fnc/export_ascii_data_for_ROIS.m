function export_ascii_data_for_ROIS(o, fdir, fname, ext, ff)
% export data as an ascii file

% generate output filename and directory
a=convert_string_for_texoutput(fname);
newdir=[fdir,'dat',delimiter];
if ~isdir(newdir)
    fprintf(1,'Directory %s did not exist, so it was created.\n',newdir);
    mkdir(newdir);
end;    

% export the data as ASCII text
fid=fopen([newdir,a,ext],'w');
fprintf(fid,'# %s : %s\n',fdir,fname);    
fprintf(fid,'# i\tXi\tYi\tMEANi\tPoiss_Ei\tPoiss_%cEi\tSIZEi\tPIXELSi\tLWratio\n','%');
if ff=='d'
    fprintf(fid,'%d\t%.2f\t%.2f\t%d\t%.2f\t%.2f\t%.2f\t%d\t%.2f\n',o');
end;
if ff=='f'
    fprintf(fid,'%d\t%.2f\t%.2f\t%.3e\t%.3e\t%.3e\t%.2f\t%d\t%.2f\n',o');
end;
fclose(fid);
fprintf(1,'Data exported as %s\n', [newdir,a,ext]);

% generate also LaTeX source, but only if ext=='.dat'
if ~isempty(findstr(ext,'.dat'))
    newdir=[fdir,'tex',delimiter];
    if ~isdir(newdir)
        fprintf(1,'Directory %s did not exist, so it was created.\n',newdir);
        mkdir(newdir);
    end;
    fid=fopen([newdir,a,'.tex'],'w');
    %fprintf(fid,'\\par\\bigskip\\noindent\\begin{minipage}{\\textwidth}\n');
    fprintf(fid,'%c Generated by Look@NanoSIMS (%s)\n',char(37),datestr(now()));
    fprintf(fid,'\\begin{longtable}{lllllllll}\n');
    [pathdir, fn]=fileparts(fdir(1:end-1));
    fn=regexprep(fn,'_','\\_'); 
    fprintf(fid,'\\multicolumn{9}{l}{%s : %s}\\\\\n\\hline\n',fn,fname);
    fprintf(fid,'i & Xi & Yi & MEANi & PEi$^*$ & P\\%cEi$^*$ & SIZEi & PIXELSi & LWratio\\\\\n\\hline\n','%');
    if ff=='d'
        fprintf(fid,'%d & %.2f & %.2f & %d & %.1f & %.2f & %.2f & %d & %.2f \\\\\n',o');
    end;
    if ff=='f'
        fprintf(fid,'%d & %.2f & %.2f & %.5f & %.5f & %.2f & %.2f & %d & %.2f \\\\\n',o');
    end;
    fprintf(fid,'\\hline\n');
    fprintf(fid,'\\multicolumn{9}{l}{$^*$~Poisson error and percentage error.}\n');
    fprintf(fid,'\\end{longtable}\n');
    fclose(fid);
    fprintf(1,'LaTeX output exported as %s\n', [newdir,a,'.tex']);
end;