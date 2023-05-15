close all;
clear;
clc;

%========= Load Data =========
data32 = load('data32.mat');
stars = data32.stars;
circles = data32.circles;
%========== Plot Data =========
figure(1)
scatter(stars(:,1),stars(:,2),'*')
hold on 
scatter(circles(:,1),circles(:,2),'filled')
legend("Stars","Circles")
xlim([-1.1 1.1])
ylim([-0.05 1.1])
%====== Calculate Errors ======
h = [0.001 0.01 0.1];
l = [0 0.1 1 10];
stars_n = size(stars, 1);
circles_n = size(circles,1);
star_labels = ones([1, stars_n]); % Label Stars as 1
circle_labels = -ones([1, circles_n]); % Label Circles as -1
X = [stars; circles];
Y = [star_labels circle_labels]';

for i=1:size(h,2)

    for j=1:size(l,2)      
        x = reshape(X' , [1, 2, 42]) - X;
        T = [];

        for k=1:2*size(circles,1)
            T = [T K(x(:,:,k),h(i))];
        end
        C = inv( T  + l(j).*eye(stars_n + circles_n) ) * Y;
        a = C(1:stars_n)';
        b = C(circles_n+1:end)';
        
        star_error = Error(stars, stars, circles, a, b, h(i));
        star_error = star_error(2);

        circle_error = Error(circles, stars, circles, a, b, h(i));
        circle_error = circle_error(1);
        
        total_error = (star_error + circle_error)/(stars_n +circles_n);        

        %============= Plot ============
        lin_x = linspace(-1.2, 1.2, 200);
        lin_y = linspace(-0.1, 1.2, 200);
        [x_meshgrid, y_meshgrid] = meshgrid(lin_x, lin_y);

        x = reshape(x_meshgrid', [size(x_meshgrid,1)^2, 1]);
        y = reshape(y_meshgrid', [size(y_meshgrid,1)^2, 1]);

        x = [x y];                
        n = size(x,1);

        T_circ = [];
        x_circ = reshape(x' , [1, 2, n]) - circles;
        T_star = [];
        x_star = reshape(x' , [1, 2, n]) - stars;
    
        for k=1:n
            T_circ = [T_circ K(x_circ(:,:,k),h(i))];
            T_star = [T_star K(x_star(:,:,k),h(i))];
        end
        
        t = sum(a * T_star,1) +  sum(b * T_circ,1);

        t = reshape(t,[length(lin_x),length(lin_y)])';
        t(t>0) = 1;
        t(t<0) = -1;

        if i==1
            figure(2)
            subplot(size(l,2)/2, size(l,2)/2, j)
            contour(x_meshgrid,y_meshgrid,t);
            hold on;
            scatter(stars(:,1), stars(:,2), 40, 'rp', 'filled')
            hold on;
            scatter(circles(:,1), circles(:,2), 40, 'cyan', 'filled')
            title(['For λ = ' num2str(l(j)) ' Error:' num2str(total_error*100) '%']);
            sgtitle(['For h = ' num2str(h(i))]) 
        end
        if i==2
            figure(3)
            subplot(size(l,2)/2, size(l,2)/2, j)
            contour(x_meshgrid,y_meshgrid,t);
            hold on;
            scatter(stars(:,1), stars(:,2), 40, 'rp', 'filled')
            hold on;
            scatter(circles(:,1), circles(:,2), 40, 'cyan', 'filled')
            title(['For λ = ' num2str(l(j)) ' Error:' num2str(total_error*100) '%']);
            sgtitle(['For h = ' num2str(h(i))]) 
        end
        if i==3
            figure(4)
            subplot(size(l,2)/2, size(l,2)/2, j)
            contour(x_meshgrid,y_meshgrid,t);
            hold on;
            scatter(stars(:,1), stars(:,2), 40, 'rp', 'filled')
            hold on;
            scatter(circles(:,1), circles(:,2), 40, 'cyan', 'filled')
            title(['For λ = ' num2str(l(j)) ' Error:' num2str(total_error*100) '%']);
            sgtitle(['For h = ' num2str(h(i))]) 
        end
    end
end

%========== Functions ==========
%----- Kernel Function -----
function y = K(X, h)
    nrm = vecnorm(X,2,2);
    y  = exp((-1/h) * nrm.^2);
end
%----- Error -----
function y = Error(X, stars, circles, a, b, h)
    y = [0 0];
    n = size(X,1);

    T_circ = [];
    x_circ = reshape(X' , [1, 2, 21]) - circles;

    T_star = [];
    x_star = reshape(X' , [1, 2, 21]) - stars;

    for k=1:size(circles,1)
        T_circ = [T_circ K(x_circ(:,:,k),h)];
        T_star = [T_star K(x_star(:,:,k),h)];
    end
    
    t = sum(a * T_star,1) +  sum(b * T_circ,1);

    y(1) = nnz(t>0); %this is when we have erros for circles
    y(2) = nnz(t<0); %this is when we have erros for stars
end