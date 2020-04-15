### Improved quadgk with singularity detection

Theoretical basis:

Given f, this function searchs for singularities so that when 
using *quadgk*, partitions can be set up to improve the
computational accuracy. The detection of singulaities relies
on a custom function that outputs a vector with the critical 
points where f(x) has singularities.

NOTE: f(x) should be a non-linear function with no constants.
It **should not** be of the kind: f(x) + C.

Roadmap/changelog:
- Proof of concept (`version a01`). **Complete**
  - *Status: custom function implementation needs to be revised.*
- Revised solution for custom function.
- Proof of concept (`version a02`).
