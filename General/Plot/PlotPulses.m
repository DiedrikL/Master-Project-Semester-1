time = TimeOptions;

T = time.Tpulse/2;
N = time.Tsize;

Smooth = Hamiltonians.SmoothHamiltonian(Time = time);
Const = Hamiltonians.ConstantHamiltonian(Time = time);

smoothTime = Smooth.TimeVector;
constTime = Const.TimeVector;
midT = Smooth.Period/2;


smoothPulse = @(s,t) 1./(exp(s.*(abs(t-midT)-abs(T)))+1);
constPulse = @(t) 1;
sinPulse = @(t) sin(t);

% sVect = [1:1:5, 20];
sVect = [1, 2, 4, 8, 14, 30];

S = size(sVect,2);

% Initialize vectors
resSmooth = zeros(S,N);

for n = 1:S
    resSmooth(n,:) = smoothPulse(sVect(n),smoothTime);
end

resConst = zeros(1,N+4);
tmpSin = sinPulse(constTime);

for n = 1:N
    resConst(n+2) = constPulse(n);
end

% resConst = [0,tmpConst,0];
resSin = [0, 0, tmpSin, 0, 0];

figTime = [-T, -1e-10,constTime, 2*T + 1e-10, 3*T];

Tstart = midT - T;
Tend = midT + T;
translateTime = [0, Tstart-1e-10, constTime+Tstart, Tend+1e-10, Smooth.Period];

figure
plot(smoothTime,resSmooth)
legendCell = cell(1,S);
for n = 1:S
      legendCell{n} = num2str(sVect(n),'Scale=%-d');
end
legend(legendCell)

fig1 = figure;
plot(smoothTime,resSmooth)
hold on
plot(translateTime, resConst)
legendCell{S+1} = 'Constant';
legend(legendCell)
fontsize(fig1, scale=2)


fig2 = figure;
subplot(1,2,1)
plot(figTime, resConst)
title("Constant pulse")

subplot(1,2,2)
plot(figTime, resSin)
title("Sinus pulse")

fontsize(fig2, scale=2)

