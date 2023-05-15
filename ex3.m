close all;
clear;
clc;

%========= Load Data =========
data33 = load('data33.mat');
X = data33.X;
%========== Plot Data =========
figure()
scatter(X(1,1:100), X(2,1:100), 40, 'blue', 'filled')
hold on;
scatter(X(1,101:end), X(2,101:end), 40, 'red', 'filled')
hold on;
legend("Group 1","Group 2")
%=========== KMeans ==========
K = 2;
iterations = 30;
[C,Z] = KMeans(X, K, iterations);
disp(['KMeans Classification Error:',num2str(classification_error(X,Z)*100),'%'])
%======= Optimum_KMeans =======
X_norm = vecnorm(X,2,1);
X_optimum = [X; X_norm.^2];
K = 2;
iterations = 30;
[C_optimum,Z_optimum] = KMeans(X_optimum, K, iterations);
disp(['Optimum KMeans Classification Error:',num2str(classification_error(X_optimum,Z_optimum)*100),'%'])
%=========== Plots ==========
Plot_points = cell(1,K);
Plot_optimum_points = cell(1,K);
for i=1:size(C,2)
    Group_Points_Index = C{i};
    Group_opt_Points_Index = C_optimum{i};
    Group_Points = X(:, Group_Points_Index);
    Class_optimum_points = X(:,Group_opt_Points_Index);
    Plot_points{i} = Group_Points;
    Plot_optimum_points{i} = Class_optimum_points;
end
%----- KMeans -----
figure()
scatter(X(1,1:100), X(2,1:100), 40, 'blue', 'filled')
hold on;
scatter(X(1,101:end), X(2,101:end), 40, 'red', 'filled')
hold on;
scatter(Plot_points{1}(1,:), Plot_points{1}(2,:), 12, 'cyan', 'filled')
hold on;
scatter(Plot_points{2}(1,:), Plot_points{2}(2,:), 12, 'yellow', 'filled')
title('Initial Points & Predicted KMeans Points')
xlabel('x')
ylabel('y')
legend({'Group 1','Group 2', 'KMeans Group 1', 'KMeans Group 2'},...
    'Location','southwest','NumColumns',2)
%----- Optimum_KMeans -----
figure()
scatter(X(1,1:100), X(2,1:100), 40, 'blue', 'filled')
hold on;
scatter(X(1,101:end), X(2,101:end), 40, 'red', 'filled')
hold on;
scatter(Plot_optimum_points{1}(1,:), Plot_optimum_points{1}(2,:), 12, 'cyan', 'filled')
hold on;
scatter(Plot_optimum_points{2}(1,:), Plot_optimum_points{2}(2,:), 12, 'yellow', 'filled')
title('Initial Points & Predicted Optimum KMeans Points')
xlabel('x')
ylabel('y')
legend({'Group 1','Group 2', 'Optimum KMeans Group 1', 'Optimum KMeans Group 2'},...
    'Location','southwest','NumColumns',2)

%========== Functions ==========
%----- KMeans -----
function [c,y] = KMeans(X, K, iterations)
    sz = size(X);
    Z = zeros(sz(1), K);
    Xt = X';
    for i=1:K
        Z(:,i) = X(:, randi(sz(2)) );
    end
    for k = 1:iterations
        Zt = Z';
        C = cell(1:K);
        for i=1:length(Xt)
            nrm = vecnorm(Zt-Xt(i,:),2,2);
            mikro = min(nrm);
            class_i = find(nrm == mikro);
            C{class_i} = [C{class_i} i];
        end
        % Changing the centers
        for i=1:K
            Xmo = [];
            for j = 1:length(C{i})
                mo = C{i}(j);
                Xmo = [Xmo X(:,mo)];
            end
            Z(:,i) = mean(Xmo,2);
        end
    end
    y = Z;
    c = C;
end
%----- Classification Error -----
function y = classification_error(X,Z)
    sz = size(X);
    Zt = Z';
    Xt = X';
    tot_err = 0;
    for i=1:length(Xt)
        nrm = vecnorm(Zt-Xt(i,:),2,2);
        mikro = min(nrm);
        class_i = find(nrm == mikro);
        if class_i == 1 && i >= 100
            tot_err = tot_err + 1;
        elseif class_i == 2 && i < 100
            tot_err = tot_err + 1;
        end
    end
    y = tot_err/sz(2);
end