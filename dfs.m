function []=dfs(original_im,x_coordinate,y_coordinate,sign_x,sign_y,box,i)
%     [x_coordinate y_coordinate]
    global visited;
    global connect_new;
    global loop;
    [m n]=size(original_im);
    loop=loop+1;
%     sum(sum(visited==1))
%     if(i==5)
%       if(sign_y<0)
%         [x_coordinate y_coordinate sign_x sign_y]
%       end
    visited(y_coordinate,x_coordinate)=1;
    connect=find((box(:,1)<=x_coordinate+1 & box(:,1)+box(:,3)>=x_coordinate-1 & box(:,2)<=y_coordinate+1 & box(:,2)+box(:,4)>=y_coordinate-1));
    if(isempty(connect) && loop<400)
        if(x_coordinate+sign_x>0 && x_coordinate+sign_x<=n &&  sign_x~=0 && original_im(y_coordinate,x_coordinate+sign_x)==0 && visited(y_coordinate,x_coordinate+sign_x)==0)
%             visited(y_coordinate,x_coordinate+sign_x)=1;
            if(sum(original_im(y_coordinate:min(y_coordinate+5,m),x_coordinate))>2 && sum(original_im(y_coordinate,max(min(x_coordinate,x_coordinate+sign_x*5),1):min(max(x_coordinate,x_coordinate+sign_x*5),n)))==0)
                visited(y_coordinate:min(y_coordinate+5,m),x_coordinate)=1;
            end
            if(sum(original_im(max(1,y_coordinate-5):y_coordinate,x_coordinate))>2 && sum(original_im(y_coordinate,max(min(x_coordinate,x_coordinate+sign_x*5),1):min(max(x_coordinate,x_coordinate+sign_x*5),n)))==0)
                visited(max(1,y_coordinate-5):y_coordinate,x_coordinate)=1;
            end
            dfs(original_im,x_coordinate+sign_x,y_coordinate,sign_x,sign_y,box,i);
        end
        if(y_coordinate+sign_y>0 && y_coordinate+sign_y<=m && sign_y~=0 && original_im(y_coordinate+sign_y,x_coordinate)==0 && visited(y_coordinate+sign_y,x_coordinate)==0)
%             visited(y_coordinate+sign_y,x_coordinate)=1;
            if(sum(original_im(y_coordinate,x_coordinate:min(x_coordinate+5,n)))>2 && sum(original_im(max(min(y_coordinate,y_coordinate+sign_y*5),1):min(max(y_coordinate,y_coordinate+sign_y*5),m),x_coordinate))==0)
                visited(y_coordinate,x_coordinate:min(x_coordinate+5,n))=1;
            end
            if(sum(original_im(y_coordinate,max(x_coordinate-5,1):x_coordinate))>2 && sum(original_im(max(min(y_coordinate,y_coordinate+sign_y*5),1):min(max(y_coordinate,y_coordinate+sign_y*5),m),x_coordinate))==0)
                visited(y_coordinate,max(x_coordinate-5,1):x_coordinate)=1;
            end
            dfs(original_im,x_coordinate,y_coordinate+sign_y,sign_x,sign_y,box,i);
        end
        if(sign_x==0)
           if(x_coordinate+1<=n && original_im(y_coordinate,x_coordinate+1)==0 && visited(y_coordinate,x_coordinate+1)==0)
%             visited(y_coordinate,x_coordinate+1)=1;
            dfs(original_im,x_coordinate+1,y_coordinate,1,0,box,i);
           end
           if(x_coordinate-1>0 && original_im(y_coordinate,x_coordinate-1)==0 && visited(y_coordinate,x_coordinate-1)==0)
%             visited(y_coordinate,x_coordinate-1)=1;
            dfs(original_im,x_coordinate-1,y_coordinate,-1,0,box,i);
           end
        end
        if(sign_y==0)
           if(y_coordinate+1<=m && original_im(y_coordinate+1,x_coordinate)==0 && visited(y_coordinate+1,x_coordinate)==0)
%             visited(y_coordinate+1,x_coordinate)=1;
            dfs(original_im,x_coordinate,y_coordinate+1,0,1,box,i);
           end
           if(y_coordinate-1>0 && original_im(y_coordinate-1,x_coordinate)==0 && visited(y_coordinate-1,x_coordinate)==0)
%             visited(y_coordinate-1,x_coordinate)==1;
            dfs(original_im,x_coordinate,y_coordinate-1,0,-1,box,i);
           end
        end
    else
        connect_new=[connect_new;connect];
    end
end