lindbladSolution = ...
  [0.519454622371311 + 0.000000000000010i -0.049356818983445 - 0.497177455306254i;
 -0.049356818983437 + 0.497177455306253i  0.480545377628576 - 0.000000000000010i]

hamiltSolution = ...
  [  0.658492353633659 + 0.747231740181606i -0.063374074573569 - 0.063374074573611i;
  0.063374074573597 - 0.063374074573582i  0.658492353633700 - 0.747231740181636i]
% hamiltSolution = lindbladSolution
% hamiltSolution = Gates.Hadamard.gate


% targetChoi = kron(lindbladSolution, Rho)
lindbladRootMatrix = sqrtm(lindbladSolution)
hamiltRootMatrix = sqrtm(hamiltSolution)
sqrtm(hamiltRootMatrix)

lContent = sqrtm(lindbladRootMatrix*lindbladSolution*lindbladRootMatrix)
lResult = 1 - trace(lContent)^2
% lNormResult = norm(trace(lindbladSolution-lindbladSolution))

hContent = sqrtm(hamiltRootMatrix*hamiltSolution*hamiltRootMatrix)
% testResult = norm(hamiltSolution -(hamiltRootMatrix*hamiltRootMatrix))
index = 2;
Diff = 1-(abs(trace(hamiltSolution'*hamiltSolution))^2 +index)/(index^2 +index)

hResult = 1-trace(hContent)^2
% hNormResult = norm(hamiltSolution-hamiltSolution)