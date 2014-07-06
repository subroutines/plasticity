function [] = savetipdir(AMX,varargin)

% if loadsave=1 load; 
% if loadsave=2 save;
bdir='BradsModel';
thisfile='savetipdir';
fdata=AMX{3};
loadsave=1;

if numel(varargin) > 0
	loadsave=varargin{1};
	%ATs = varargin{2};
	ATs = evalin('base', 'ATs');
	Ax = evalin('base', 'Ax');
end


	% Save current directory
	pw = what;
	cpath = pw.path;
	%pd = dir;
	%fileparts()

	% Get full path to this file (savetipdir) or to thisfile.m
	wfiname = which(thisfile);
	% Save just the path without the file name
	wthisfile = regexprep(wfiname, '(\w*\.m$)', '','once');
	w1 = what(wthisfile);
	
	% Simultaniously Save current path and switch path
	pathNow = cd(w1.path);
	
	% Load/Save data file
	if loadsave==1
	fd = which(fdata);
	load(fd);
	end
	if loadsave==2
		save(fdata, 'ATs','Ax')
	end
	

	% Change path back to currently open folder
	cd(pathNow)

end