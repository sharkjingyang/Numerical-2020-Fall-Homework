% Primary goal signal
y_des = zeros(201,1);
y_des(41:90,1) = ones(50,1);
y_des(91:140,1) = -ones(50,1);

t = linspace(0,200,201);
h = zeros(201,1);
for i = 1:201
    h(i) = ht(t(i));
end

% Define matrix
D = zeros(200,201);
for i = 1:200
    D(i,i+1) = 1;
    D(i,i) = -1;
end

H = zeros(201,201);
for i = 1:201
    H(i:201,i) = h(1:202 - i,1);
end


% Solve the problem

% 1.delta = 0, eta = 0.005
cvx_begin
    variable u(201);
    y = H * u;
    minimize (sum_square(y - y_des) / 201 + 0.005 * sum_square(u) / 201 + 0.0 * sum_square(D * u) / 200);
cvx_end

u_1 = u; y_1 = y;

% 2. delta = 0, eta = 0.05
cvx_begin
    variable u(201);
    y = H * u;
    minimize (sum_square(y - y_des) / 201 + 0.05 * sum_square(u) / 201 + 0.0 * sum_square(D * u) / 200);
cvx_end

u_2 = u; y_2 = y;

% 3. delta = 0.3, eta = 0.05
cvx_begin
    variable u(201);
    y = H * u;
    minimize (sum_square(y - y_des) / 201 + 0.05 * sum_square(u) / 201 + 0.3 * sum_square(D * u) / 200);
cvx_end

u_3 = u; y_3 = y;


% Draw figures
subplot(321)
plot(t, u_1);
xlim([0 200]);
ylim([-10 5])
xlabel('t');
ylabel('u(t)');

subplot(322)
plot(t, y_1, t, y_des, '--');
xlim([0 200]);
ylim([-1.2 1.2])
xlabel('t');
ylabel('y(t)');
legend('y','y_{des}');

subplot(323)
plot(t, u_2);
xlim([0 200]);
ylim([-4 4])
xlabel('t');
ylabel('u(t)');

subplot(324)
plot(t, y_2, t, y_des, '--');
xlim([0 200]);
ylim([-1.2 1.2])
xlabel('t');
ylabel('y(t)');
legend('y','y_{des}');

subplot(325)
plot(t, u_3);
xlim([0 200]);
ylim([-4 4])
xlabel('t');
ylabel('u(t)');

subplot(326)
plot(t, y_3, t, y_des, '--');
xlim([0 200]);
ylim([-1.2 1.2])
xlabel('t');
ylabel('y(t)');
legend('y','y_{des}');
