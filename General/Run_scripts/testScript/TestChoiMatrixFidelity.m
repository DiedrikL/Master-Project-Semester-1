gate = Gates.GateOfOneTwoParticles.gate;

index = 4;
matrixSize = index^2;
scale = 1/index;



% initialize matrix
ChoiPart = zeros(index, index, matrixSize, matrixSize);

for n = 1:index
    for m = 1:index
        Rho = sparse(m, n, 1, index, index);
        ChoiPart(m,n,:,:) = transpose(kron(gate*Rho*gate', Rho));      
    end
end


% Sums and reduces the parts of the choi matrix
Choi = sum(ChoiPart, [1, 2]);
Choi = squeeze(Choi);
Choi = (Choi.*scale);

ChoiSqrt = sqrtm(Choi);
content = sqrtm(ChoiSqrt*Choi*ChoiSqrt);

testDiff = 1 - abs(trace(content)^2)