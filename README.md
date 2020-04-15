# IMPROVED QUADGK WITH SINGULARITY DETECTION

Theoretical basis:

Given f, this function searchs for singularities so that when 
using *quadgk*, partitions can be set up to improve the
computational accuracy. The detection of singulaities relies
on a custom function that outputs a vector with the critical 
points where f(x) has singularities.

NOTE: f(x) should be a non-linear function with no constants.
It **should not** be of the kind: f(x) + C.