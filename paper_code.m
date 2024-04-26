close all;
clc;
a=imread('50.pgm');
G=im2double(a);

%����ʵ�ı�ԵGT

b=imread('50GT.pgm');
[m,n]=size(b);
c=b;
for i=2:m-1
    for j=2:n-1
        if b(i-1,j-1)<50&&b(i-1,j)<50&&b(i-1,j+1)<50&&b(i,j-1)<50&&b(i,j)<50&&b(i,j+1)<50&&b(i+1,j-1)<50&&b(i+1,j)<50&&b(i+1,j+1)<50
            c((i-1:i+1),(j-1:j+1))=255*ones(3,3);
        end
    end
end
GT1=1-im2double(c);
GT=GT1;
for i=1:m
    for j=1:n
        if GT1(i,j)>0.9
            GT(i,j)=1;
        end
    end
end

%�����ݶ�
or = featureorient(G, 0, 0.9);
smor = smoothorient(or, 1);

%��ģ����Ե
I=[0.86 0.86 0.86; 0.86 1 0.86; 0.86 0.86 0.86];

[Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo(G,I);
Z_gray=255-im2uint8(Z);
Fuzzy_image=im2double(Z_gray);

%nms����
[im, location] = nonmaxsup(Z, smor, 1.2);
NMS_image=255-im2uint8(im);


%HYS�����õ���Ե���ؿ��Ϊ1
for i=1:25
    for j=i:25
        t1=180+2*i;
        t2=180+2*j;
   Ea=1-hysthresh(NMS_image,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x,y]=find(F==F_max);
tx=180+2*x(1);
ty=180+2*y(1);
HYS_image= hysthresh(NMS_image,tx,ty); %tx=216 ty=220(144)  %tx=222 ty=230(143)
%HYS_image= hysthresh(NMS_image,200,230); 
figure; imshow(G);
figure; imshow(HYS_image);