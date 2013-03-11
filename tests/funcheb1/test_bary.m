function pass = test_bary(pref)

% [TODO]: This test is rubbish!

if ( nargin < 1 )
    pref = funcheb1.pref;
end

tol = 20*pref.funcheb.eps;

n = 14;
m = 10;

x = funcheb1.chebpts(n);
f = @(x) sin(x);
y = linspace(-1, 1, m).';
fx = f(x);
fy = f(y);

% second kind formula
pass(1) = norm( funcheb1.bary(y, fx, 2) - fy ) < tol;
pass(2) = norm( funcheb1.bary(y, [fx fx], 2) - [fy fy] ) < tol;

% First kind formula
pass(3) = norm( funcheb1.bary(y, fx, 1) - fy ) < tol;
pass(4) = norm( funcheb1.bary(y, [fx fx], 1) - [fy fy] ) < tol;

end