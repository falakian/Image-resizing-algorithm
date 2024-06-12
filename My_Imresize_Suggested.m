function resized_image =  My_Imresize_Suggested(Input_Image)

    % Initial image size
    [rows, cols, in_channel] = size(Input_Image);

   % Calculate the dimensions of the new image
    new_rows = round(rows * 2);
    new_cols = round(cols * 2);

    % Allocating memory for the new image
    resized_image = double(zeros(new_rows, new_cols, in_channel));
    resized_edge = false(new_rows, new_cols, in_channel);
   
    %  Calculation of the edge of the input image
    if(in_channel == 3)
        edge_image = cat(3,edge(Input_Image(:,:,1) ,"canny"),edge(Input_Image(:,:,2) ,"canny"),edge(Input_Image(:,:,3) ,"canny"));
    else
        edge_image = edge(Input_Image ,"canny");
    end
  

    % first part: placing the main pixels of the image
    for i =1:rows
        for j =1:cols
            for k =1:in_channel
            resized_image((i*2 - 1) , (j*2 - 1) , k) = (Input_Image(i , j , k));
            resized_edge((i*2 - 1) , (j*2 - 1) , k) = (edge_image(i , j , k));
            end
        end
    end

    % The second part: calculating the amount of even pixels of the image
    for i = 2:2:new_rows
        for j = 2:2:new_cols

            i_floor = (i - 1);
            j_floor = (j - 1);
            
            i_ceil = min(i + 1, new_rows - 1);
            j_ceil = min(j + 1, new_cols - 1);

            for k=1:in_channel
                
                % Calculate four pixel neighbors
                a = resized_image(i_floor, j_floor , k);
                b = resized_image(i_floor, j_ceil , k);
                c = resized_image(i_ceil, j_floor , k);
                d = resized_image(i_ceil, j_ceil, k);
                
                e_a = resized_edge(i_floor, j_floor , k);
                e_b = resized_edge(i_floor, j_ceil , k);
                e_c = resized_edge(i_ceil, j_floor , k);
                e_d = resized_edge(i_ceil, j_ceil, k);
                
                sum_e = e_a + e_b + e_c + e_d;

                if(sum_e == 4 || sum_e == 0 || sum_e == 2)
                    resized_image(i , j , k) = ((a + b + c + d)/4);
                    resized_edge(i , j , k) = e_a;
                else
                    if(e_a == e_d)
                        resized_image(i , j , k) = ((a + d)/2);
                        temp = (e_a +  e_d) / 2;
                    else
                        resized_image(i , j , k) = ((b + c)/2);
                        temp = (e_b +  e_c) / 2;
                    end
                    resized_edge(i , j , k) = temp; 
                 end
            end
        end
    end

    % Third part: Calculation of remaining pixels
    for i = 1:2:new_rows
        for j = 2:2:new_cols
            
            i_left = i;
            j_left = (j - 1);

            i_right = i;
            j_right = min(j + 1, new_cols - 1);

            i_up = max(i-1 , 2);
            j_up = j;

            i_down =min(i + 1, new_rows);
            j_down = j;

            for k=1:in_channel
                
                % Calculate four pixel neighbors
                a = resized_image(i_left, j_left , k);
                b = resized_image(i_up, j_up , k);
                c = resized_image(i_right, j_right , k);
                d = resized_image(i_down, j_down, k);
                
                e_a = resized_edge(i_left, j_left , k);
                e_b = resized_edge(i_up, j_up , k);
                e_c = resized_edge(i_right, j_right , k);
                e_d = resized_edge(i_down, j_down, k);
                
                sum_e = e_a + e_b + e_c + e_d;

                if(sum_e == 4 || sum_e == 0 || sum_e == 2)
                    resized_image(i , j , k) = ((a + b + c + d)/4);
                    resized_edge(i , j , k) = e_a;

                else
                    if(e_a == e_c)
                        resized_image(i , j , k) = ((a + c)/2);
                        temp = (e_a +  e_c) / 2;
                    else
                        resized_image(i , j , k) = ((b + d)/2);
                        temp = (e_b +  e_d) / 2;
                    end
                    resized_edge(i , j , k) = temp;
                end
            end
        end
    end


    for i = 2:2:new_rows
        for j = 1:2:new_cols

            i_left = i;
            j_left = max((j - 1) , 2);

            i_right = i;
            j_right = min(j + 1, new_cols);

            i_up = i-1 ;
            j_up = j;

            i_down = min(i + 1, new_rows - 1);
            j_down = j;

            for k=1:in_channel
                
                % Calculate four pixel neighbors
                a = resized_image(i_left, j_left , k);
                b = resized_image(i_up, j_up , k);
                c = resized_image(i_right, j_right , k);
                d = resized_image(i_down, j_down, k);
                
                e_a = resized_edge(i_left, j_left , k);
                e_b = resized_edge(i_up, j_up , k);
                e_c = resized_edge(i_right, j_right , k);
                e_d = resized_edge(i_down, j_down, k);
                
                sum_e = e_a + e_b + e_c + e_d;

                if(sum_e == 4 || sum_e == 0 || sum_e == 2)
                    resized_image(i , j , k) = ((a + b + c + d)/4);
                    resized_edge(i , j , k) = e_a;

                else
                    if(e_a == e_c)
                        resized_image(i , j , k) = ((a + c)/2);
                        temp = (e_a +  e_c) / 2;
                    else
                        resized_image(i , j , k) = ((b + d)/2);
                        temp = (e_b +  e_d) / 2;
                    end
                    resized_edge(i , j , k) = temp;
             
                end
            end
        end
    end
    resized_image = uint8(resized_image);
end