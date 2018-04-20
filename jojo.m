%clear all; clc; close all;
%load ('./WERKSPEJS/mereni_16_04/vypustprava')
close all
load ('./WERKSPEJS/mereni_16_04/Test_data/complex_test')
vypustleva = ty(500:1500);

plot( vypustleva(:,1) , [vypustleva(:,2), vypustleva(:,3), vypustleva(:,4), vypustleva(:,5), vypustleva(:,6)] )
hold on
plot(h1_lin_sim.time, h1_lin_sim.data)
plot(h2_lin_sim.time, h2_lin_sim.data)



