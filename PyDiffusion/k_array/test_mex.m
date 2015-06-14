% IMPORTANT! DO NOT USE clear all IF U DONT WANT MATLAB TO CRASH!
clc; close all;
thisFolder = fileparts(which('test_mex.m'));
addpath(thisFolder); cd(thisFolder);


%% This must be executed to run advance_one_step from the Matlab IDE
if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end


%% LOAD SERIALIZED MESH AND SAVED VARIABLE VALS

load('serialized_mesh_res_96.mat');

k = double([2.0; 1.0]);
xyz_loc = double([0 0 50; 0 0 50]);
face_indices = int64([12419; 12419]);

sp1 = sprintf('\r %s : %s \r','k',class(k));                                    % double
sp2 = sprintf('\r %s : %s \r','initial_point',class(initial_point));            % double [0 0 50]
sp3 = sprintf('\r %s : %s \r','xyz_loc',class(xyz_loc));                        % double [0 0 50]
sp4 = sprintf('\r %s : %s \r','initial_face_index',class(initial_face_index));  % int64  12419
sp5 = sprintf('\r %s : %s \r','face_indices',class(face_indices));              % int64  12419
sp6 = sprintf('\r %s : %s \r','all_vertices',class(all_vertices));              % double
sp7 = sprintf('\r %s : %s \r','triangles',class(triangles));                    % int64
sp8 = sprintf('\r %s : %s \r','face_local_bases',class(face_local_bases));      % double
sp9 = sprintf('\r %s : %s \r','neighbor_faces',class(neighbor_faces));          % int64
disp([sp1 sp2 sp3 sp4 sp5 sp6 sp7 sp8 sp9])
clear sp1 sp2 sp3 sp4 sp5 sp6 sp7 sp8 sp9


%% --- MEXICAN PYTHON LOOP advance_one_step.mexmaci64

for nn = 1:20
[xyz_loc, face_indices] = advance_one_step(...
    xyz_loc, face_indices, k, initial_point, initial_face_index, ...
    all_vertices, triangles, face_local_bases, neighbor_faces);

sp1 = sprintf('\r xyz_loc : % 5.5g % 5.5g % 5.5g \n',xyz_loc(:));
sp2 = sprintf('face_indices : % 5.5g \n',face_indices);

disp(sp1); disp(sp2);

pause(.1)
end


%{
clear sp1 sp2

disp(['[xyz_loc, face_indices] = advance_one_step(xyz_loc,face_indices,',...
      'k, initial_point, initial_face_index, all_vertices,',...
      'triangles, face_local_bases, neighbor_faces)'])


disp(inmem); clear mex; clear all; exit;
[xyz_loc, face_indices] = advance_one_step(...
    xyz_loc, face_indices, k, initial_point, initial_face_index, ...
    all_vertices, triangles, face_local_bases, neighbor_faces)

% clc;
% [M,X,C] = inmem('-completenames'); disp(C); disp(X);
% clear functions; clear classes; clear import;
%}

