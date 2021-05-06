% Define the matrix
m = 100; n = 30;
A = 0.6 * randn(m, n);
b = 0.6 * randn(m, 1);
xaxis = linspace(-2,2,81);

% Solve the problem

% 1. norm_1
cvx_begin
    variable x(n)
    minimize(norm(A * x - b, 1))
cvx_end

res = A * x - b;
a_1 = amp(res, xaxis);
y_1 = 15 * abs(xaxis);

% 2. norm_2
cvx_begin
    variable x(n)
    minimize(norm(A * x - b, 2))
cvx_end

res = A * x - b;
a_2 = amp(res, xaxis);
y_2 = 1.5 * xaxis .^2;

% 3. deadzone with a = 0.5
cvx_begin
    variable x(n)
    minimize(dzlinear(A * x - b, 0.5))
cvx_end

res = A * x - b;
a_3 = amp(res, xaxis);
y_3 = 10 * max(0, abs(xaxis) - 0.5);

% 4.log barrier with a = 1
cvx_begin
    variable x(n)
    r = A * x - b;
    minimize(-sum_log(ones(m, 1) - r.^2));
cvx_end

res = A * x - b;
a_4 = amp(res, xaxis);
y_4 = -5 * log(1 - xaxis(22:60).^2);

% Draw figures
subplot(411)
bar(xaxis, a_1);
hold on;
plot(xaxis, y_1);
xlim([-2 2]);
ylim([0 40]);
ylabel('Norm 1');

subplot(412)
bar(xaxis, a_2);
hold on;
plot(xaxis, y_2);
xlim([-2 2]);
ylim([0 12]);
ylabel('Norm 2');

subplot(413)
bar(xaxis, a_3);
hold on;
plot(xaxis, y_3);
xlim([-2 2]);
ylim([0 22]);
ylabel('Deadzone');

subplot(414)
bar(xaxis, a_4);
hold on;
plot(xaxis(22:60), y_4);
hold on;
plot(xaxis, y_2,'--');
xlim([-2 2]);
ylim([0 11]);
xlabel('r');
ylabel('Log barrier');
