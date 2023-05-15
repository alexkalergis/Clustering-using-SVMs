close all;
clear;
clc;

N = 1000;
samples = 4*N;
X = rand(1,N);
xaxis = linspace(-2,3,samples);
X = xaxis' - X;
h = [0.0001 0.001 0.01 0.1];

for i = 1:length(h)
    f = mean(K(X,h(i)),2);
    subplot(2,2,i)
    plot(xaxis,f)
    hold on
    syms x
    fplot(rectangularPulse(0,1,x))
    txt = sprintf("h = %g",h(i));
    title(txt)
end

function GaussianKernel = K(X,h)
    GaussianKernel = ( 1/sqrt(2*pi*h) )*( exp( -1/(2*h)*X.^2 ) );
end