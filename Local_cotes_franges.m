function [res]= Local_cotes_franges ( p )  
  %Bande (1200*2)
  res=zeros(1200,2^(p)-1);
 for i= 1 :2: (2^p)-1
     tmp = Localfrange( i , p );
 
 res (:,i)= tmp (:,1);
 res (: , i+1 ) = tmp ( : , 2);
 end
 
end