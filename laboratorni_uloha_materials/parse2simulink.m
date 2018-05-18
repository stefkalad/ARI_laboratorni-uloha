function[sim_u sim_vo sim_vt sim_h1 sim_h2] = parse2simulink(data)
    sim_u= [data(:,1) data(:,2)];
    sim_vo=[data(:,1) data(:,5)];
    sim_vt=[data(:,1) data(:,6)];
    sim_h1=[data(:,1) data(:,3)];
    sim_h2=[data(:,1) data(:,4)];
    