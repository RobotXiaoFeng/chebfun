function pass = test_happinessCheck(pref)

% Get preferences:
if ( nargin < 1 )
    pref = funcheb.pref;
end
% Set the tolerance:
tol = 10*pref.funcheb.eps;

%%
% Test on a scalar-valued function:
x = funcheb2.chebpts(33);
f = @(x) sin(x);
g = funcheb2(f(x));
[ishappy, epslevel, tail] = happinessCheck(g, f, pref);
pass(1) = tail == 14;
pass(2) = ishappy && epslevel < tol;

%%
% Test on a vector-valued function:
f = @(x) [sin(x) cos(x) exp(x)];
g = funcheb2(f(x));
[ishappy, epslevel, tail] = happinessCheck(g, f, pref);
pass(3) = tail == 15;
pass(4) = ishappy && epslevel < tol;

%%
n = 32;
m = n/2;
x = funcheb2.chebpts(n+1);
f = @(x) cos((2*n+m)*acos(x));

% This should be happy, as aliasing fools the happiness test:
pref.funcheb.sampletest = 0;
g = funcheb2(f(x));
[ishappy, epslevel, tail] = happinessCheck(g, f, pref);
pass(5) = ( ishappy && tail == 17);

% This should be unhappy, as sampletest fixes things:
pref.funcheb.sampletest = 1;
g = funcheb2(f(x));
[ishappy, epslevel, tail] = happinessCheck(g, f, pref);
pass(6) = ~ishappy && tail == 33;

end
