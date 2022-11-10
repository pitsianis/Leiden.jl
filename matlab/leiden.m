function [cid] = leiden(A, method, opt)
% LEIDEN - Run Leiden for a specific gamma.
%
% CID = LEIDEN( A ) runs the Leiden algorithm[1], with the clustering
% function modularity, at γ = 1.0.
%
% CID = LEIDEN( A, CLUSTFUNC ) allows you to specify a different
% clustering function; available options are:
%   - 'ngrb': modularity
%   - 'cpm': Constant Potts Model
%   - 'imod': The imod clustering function described in [2]
%
% ## Advanced options
%
% CID = LEIDEN( ..., 'NAME', VALUE, ... ) allows you to modify the
% following optional parameters:
%   - 'gamma': the value of the resolution parameter. Default: 1.0
%   - 'list_seed': the list of random seeds to run
%   - 'n_iter': the number of Leiden iterations with each seed
%
%
% Examples:
%
%    A = sprand(10,10,0.2);
%    cid = leiden(A)
%
%
%
% ## References
%
% [1] V. A. Traag, L. Waltman and N. J. van Eck, [From Louvain to
% Leiden: guaranteeing well-connected
% communities](https://www.nature.com/articles/s41598-019-41695-z/),
% Scientific Reports volume 9, 2019
%
% [2] T. Liu, D. Floros, N. Pitsianis and X. Sun, "[Digraph Clustering
% by the BlueRed Method](https://ieeexplore.ieee.org/document/9622834),"
% 2021 IEEE High Performance Extreme Computing Conference (HPEC), 2021,
% pp. 1-7, doi: 10.1109/HPEC49654.2021.9622834.


% Authors: Dimitris F., Nikos P., Xiaobai S.
% Date: <Nov 10, 2022>

arguments
    A
    method = 'ngrb'
    opt.gamma = 1.0
    opt.gr_function = 0
    opt.list_seed = 0:9
    opt.n_iter = 5
end

args = {A, method}

kwargs = struct( ...
    'gamma',           opt.gamma, ...
    'gr_function', int64(opt.gr_function), ...
    'list_seed',   int64(opt.list_seed), ...
    'n_iter',      int64(opt.n_iter) );

fun_julia = ['(args...; gamma = 1.0, kwargs... ) -> ' ...
  'Leiden.leiden(args...; kwargs..., γ = gamma)' ];


cid = double( jlcall( fun_julia, args, kwargs, 'modules', {'Graphs', 'SparseArrays', 'Leiden'}) );

end
