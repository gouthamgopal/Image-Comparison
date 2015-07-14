clc;
clear all;
close all;

%READING THE IMAGES
url1=input('Enter the URL of the 1st image : ','s');
url2=input('Enter the URL of the 2nd image : ','s');

img1=imread(url1);
img2=imread(url2);



%CONVERTING IMAGE IN TO 2-D
img1=img1(1:size(img1,1),1:size(img1,2));
img2=img2(1:size(img2,1),1:size(img2,2));


%ROTATING THE IMAGE
rotate=0;
flag=0;
for k=1:4
    timg1=img1;
     timg2=img2;
    timg2=imrotate(timg2,rotate);
    
    %RESIZING THE IMAGE
    
    %%ROW
    if size(timg1,1) > size(timg2,1)
        timg1=imresize(timg1,[size(timg2,1) size(timg1,2)]);
    elseif size(timg1,1) < size(timg2,1)
         timg2=imresize(timg2,[size(timg1,1) size(timg2,2)]);
    end

    %%COLUMN
    if size(timg1,2) > size(timg2,2)
        timg1=imresize(timg1,[size(timg1,1) size(timg2,2)]);
    elseif size(timg1,2) < size(timg2,2)
         timg2=imresize(timg2,[size(timg2,1) size(timg1,2)]);
    end
    
    if size(timg1,1)>800
        timg1=imresize(timg1,[800 size(timg1,2)]);
        timg2=imresize(timg2,[800 size(timg1,2)]);
    end
    
    if size(timg1,2)>600
        timg1=imresize(timg1,[size(timg1,1) 600]);
        timg2=imresize(timg2,[size(timg1,1) 600]);
    end
     
    %FINDING THE DIFFERENCE
   
    diff=imabsdiff(timg1,timg2);
   


    %FINDING RMS
    dsum=0;

    for i=1:size(diff,1)
        for j=1:size(diff,2)
           temp=int64(diff(i,j));
           temp=temp*temp;
           dsum=dsum+temp;      
        end
    end

    dsum=double(dsum);
    dsum=dsum/(size(diff,1)*size(diff,2));
    dsum=sqrt(dsum);

    similarity=100-(dsum/255)*100;
    
    
    if k==1
        zero=similarity;
        if zero>90
            break;
        end
    elseif similarity>90
        zero1=similarity;
        flag=1;
        degree=rotate;
        break;
    end
    
    rotate=rotate+90;
end

if flag==0
    fprintf('IMAGES ARE FOUND TO BE %d percent similar',zero);
else
     fprintf('IMAGES ARE FOUND TO BE %d percent similar with %d degree rotation',zero1,rotate);
end   
        
