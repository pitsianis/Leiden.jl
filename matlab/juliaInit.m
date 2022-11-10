function juliaInit(cwd)

if nargin == 0
  cwd = pwd();
end

setenv('PATH', getenv('PATH')+":/usr/local/bin")

jlcall('', ...
    'project', cwd, ...                        % activate a local Julia Project
    'modules', {'SparseArrays', 'Graphs', 'Leiden'}, ... % load a custom module and some modules from Base Julia
    'threads', 'auto', ...                     % use the default number of Julia threads
    'restart', true ...                        % start a fresh Julia server environment
    )

%    'setup', '/path/to/setup.jl', ... % run a setup script to load some custom Julia code

end
