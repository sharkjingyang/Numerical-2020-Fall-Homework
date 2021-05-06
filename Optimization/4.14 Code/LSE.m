% Create the original data
t = rand(42, 1) * 20 - 10;
y = 0.5 * t - 5 + randn(42, 1) * 0.5;
t(1) = -9.89;
t(42) = 9.12;
y(1) = 18.76;
y(42) = -16.48;

T = cat(2, t, ones(42, 1));
xaxis = linspace(-15,15,100);
% Use quadratic penalty
cvx_begin
    variable x_1(2);
    minimize (norm(T * x_1 - y));
cvx_end

% Use Huber penalty
cvx_begin
    variable x_2(2);
    minimize(sum(huber(T * x_2 - y)));
cvx_end

% Draw the function figure
u = linspace(-1.5, 1.5, 101);
y_1 = u.^2;
y_2 = hb(u, 1);

% Draw figures
subplot(121)
plot(u, y_1, u, y_2);
xlim([-sqrt(2) sqrt(2)]);
ylim([0 2]);
xlabel('u');
ylabel('\Phi_{hub}(u)');
legend('quadratic','Huber');

subplot(122)
y_q = x_1(1) * xaxis + x_1(2);
y_h = x_2(1) * xaxis + x_2(2);
plot(xaxis, y_q, xaxis, y_h);
hold on;
scatter(t,y,7)
xlim([-12 12]);
ylim([-20 20]);
xlabel('t');
ylabel('f(t)');
legend('quadratic','Huber')