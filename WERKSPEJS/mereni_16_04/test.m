close all; clc;
load('vypustleva.mat')
v = vypustleva
time = v(:, 1)'
k = find(v == 2.2)