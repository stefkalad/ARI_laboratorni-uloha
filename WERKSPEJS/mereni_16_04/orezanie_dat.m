close all
load ('prepust_P_L')
vypustleva = vypustleva(500:1000,:)
vypustleva(:,1) = vypustleva(:,1) - 99.2
plot( vypustleva(:,1) , [vypustleva(:,2), vypustleva(:,3), vypustleva(:,4), vypustleva(:,5), vypustleva(:,6)] )
save('prepust_P_L_orezana')