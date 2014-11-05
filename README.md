FluxEstimation :octocat:
## Project: For eddy correlation data analysis！
The project included **1. flux calculation** :sparkles:
                     **2. quality control** :sparkles:
 



### Filefolder :file_folder:

File Name | Purpose
---------- | -----------
**main.m** | This file contains a function to obtain the whole result
**fluxcalculation.m** | This file implements the flux calculation.
**ECcontrol.m** | This file contains quality control
**rotaion.m** | This file contains twice rotation for eddy correlation data
....

### Fix the :bug: bug

The provided files *fluxcalculation.m* and *main.m* both have bugs and therefore the provided tests fail. The following changes were made:

File Name | Changes
---------- | -----------
**fluxcalculation.m** | There is a bug in the function to compute the approximate *Jacobian* matrix `Df_x`. The original code did not divide `f(x+v)-fx` by the step size `dx`. The corrected code should be `Df_x[:,i]=(f(x+v)-fx)/dx`.
**main.m** | The bug is in the function *step* which takes a single step of a Newton method. The return value is wrong. It should be `x-h`

### Add new functionalities

File Name | New functionality
---------- | -----------
**ttest.m** | <ul><li>Add a new function *AnalyticalJacobian* which return an analytical Jacobian Df(x) as a numpy matrix.</li><li>Add one and two dimentional transcendental functions and their analytical Jacobian.</li></ul>
```Python
def AnalyticalJacobian(Df, x):
    """Return an analytical Jacobian Df(x) as a numpy matrix"""
    try:
        n = len(x)
    except TypeError:
        n = 1
    Df_x = N.matrix(N.zeros((n,n)))
    Df_x = Df
    return Df_x
```

File Name | New functionality
---------- | -----------
**newton.py** | <ul><li>Add a condition that **Newton** raises an exception if the method fails to converge after the maximum number of iterations. Modification can be found inside the function `solve` as shown below.</li><li>Add a condition that the approximated root must lie within a radius  *r* of the initial guess x0, or the iteration loop raises an exception. Modification can be found inside the function `solve` as shown below.</li><li>Modify the function `step` so that it can choose either the *ApproximateJacobian* or *AnalyticalJacobian* to compute `Df_x`. Modification can be found inside the function `step` as shown below. </li><li>Alter the `__init__` member function of class **Newton** to include a new optional argument `Df`, which specifies the function to be used for calculating the Jacobian. Modification can be found in the `__init__` member function as shown below. </li></ul>

```Python
def solve(self, x0):
    """Return a root of f(x) = 0, using Newton's method, starting from
    initial guess x0"""
    x = x0
    for i in xrange(self._maxiter):
        fx = self._f(x)
        if N.linalg.norm(fx) < self._tol:
            return x
        x = self.step(x, fx)
        if self._r is not None and N.linalg.norm(x - x0) > self._r:
            raise Exception("The approximated root must lie within a radius r=%s of the initial guess x0" %(self._r))

    if N.linalg.norm(self._f(x)) > self._tol:
        raise Exception("Fails to converge after the maximum number of iterations")
    return x
```

```Python
def step(self, x, fx=None, Df=None):
    """Take a single step of a Newton method, starting from x
    If the argument fx is provided, assumes fx = f(x)"""
    if fx is None:
        fx = self._f(x)
    if Df is None:
            Df_x = F.ApproximateJacobian(self._f, x, self._dx)
    else:
            Df_x = F.AnalyticalJacobian(self._Df, x)
    h = N.linalg.solve(N.matrix(Df_x), N.matrix(fx))
    return x - h
```

```Python
def __init__(self, f, Df=None, tol=1.e-6, maxiter=20, dx=1.e-6, r=None):
    """Return a new object to find roots of f(x) = 0 using Newton's method.
    tol:     tolerance for iteration (iterate until |f(x)| < tol)
    maxiter: maximum number of iterations to perform
    dx:      step size for computing approximate Jacobian
    r:       radius that the approximated root must lie within compared to the initial guess x0"""
    self._f = f
    self._Df = Df
    self._tol = tol
    self._maxiter = maxiter
    self._dx = dx
    self._r = r
```

### Add additional test examples

File Name | Test Examples
---------- | -----------
**testFunctions.py** | <ul><li>**testApproxJacobianAccuracy1D**: Test the accuracy of the approximated Jacobian matrix for a one dimentional linear function.</li><li>**testApproxJacobianAccuracy3D**: Same as above, but for three dimentional.</li><li>**testAnalyJacobian1D**: Test the analytical Jacobian matrix for a one dimentional linear function.</li><li>**testAnalyJacobian3D**: Same as above, but for three dimentional.</li><li>**testAnalyJacobianAccuracy3D**: Compare the analytical Jacobian and approximated Jacobian for a three dimentional linear function to test that the new added analytical Jacobian is accurate.</li><li>**testTranscendental1D**: Compare the analytical Jacobian and approximated Jacobian for a one dimentional transcendental function. Functions are pre-defined in `funtions.py`. </li><li>**testTranscendental2D**:Same as above, but for two dimentional case. </li></ul>
**testNewton.py** | <ul><li>**testUseAnalytical**: Test that the analytic Jacobian is actually the one used by the root finder. Note that the step size in this function is very big (`dx=100`), which means the approximated Jacobian is not correct. Therefore, if the root found by Newton is accurate, it means analytic Jacobian is used in the member function of the class.</li>:pencil2:<li>**testAnalyLinear1D**: Test Newton using the analytical Jacobian for one dimentional linear function.</li><li>**testRadiusLinear1D**: Add a test to raise an exception if the approximated root lies outside a radius r of the initial guess x0.</li>:pencil2:<li>**testConvergence**: Newton raises an exception if the method fails to converge after the maximum number of iterations. </li>:pencil2:<li>**testSingleStep**: Add a single step of the Newton method performs as it should.</li>:pencil2:<li>**testLinearMul**: Test Newton using approximated Jacobian for two dimentional linear function.</li><li>**testAnalyLinearMul**: Same as above, but using analytical Jacobian.</li>:pencil2:<li>**testQuadratic1D**: Test Newton using approximated Jacobian for one dimentional quadratic function.</li><li>**testAnalyQuadratic1D_01**: Same as above, but using analytical Jacobian. The quadratic function is defined through the lambda function.</li><li>**testAnalyQuadratic1D_02**: Same as above. But the quadratic function is defined using the `Polynomial` class.</li>:pencil2:<li>**testQuadratic2D**: Test Newton using approximated Jacobian for two dimentional quadratic function. Multiple roots are searched and compared with the true values.</li><li>**testAnalyQuadratic2D**: Same as above, but using analytical Jacobian.</li>:pencil2:<li>**testCubic1D**: Test Newton using approximated Jacobian for one dimentional cubic function.</li><li>**testAnalyCubic1D**: Same as above, but using analytical Jacobian.</li>:pencil2:<li>**testSin**: Test Newton using approximated Jacobian for one dimentional Sine function.</li><li>**testAnalySin**: Same as above, but using analytical Jacobian.</li><li>**testRadiusSin**: Add a test to raise an exception if the approximated root lies outside a radius r of the initial guess x0.</li></ul>

### Summary
In this assignment, bugs in the origional provided files are fixed and several new functionality are added. Two new optional arguments `Df` and `r` are added in the `__init__` member function, which specifies whether to use the analytical Jacobian or add a specified range for the root (otherwise will raise an exception). If these arguments are not specified, then Newton will just use the default parameters. Besides, the updated Newton can also test the convergence. If the method fails to converge after the specified number of iterations, it will also raise an exception error. In order to make sure that these functionality are added correctly, several tests are designed. These tests could be found in *testFunctions.py* and *testNewton.py*.

### How to use? :eyes:
If you would like to use this Newton solver, one could do in the following way:

```Python
import newton
solver = newton.Newton(f, df, tol, maxiter, dx, r)
x = solver.solve(x0);
```
where:
```
f:       function
df:      analytical Jacobian matrix (if not specified, approximated Jacobian is applied)
tol:     tolerance for iteration (iterate until |f(x)| < tol)
maxiter: maximum number of iterations to perform
dx:      step size for computing approximate Jacobian
r:       radius that the approximated root must lie within compared to the initial guess x0
```

### The End

**Found a :bug: bug?** Contact me through :e-mail: _weizw@aori.u-tokyo.ac.jp_. :trollface:
