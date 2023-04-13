function dinput=backward_max_pool(h,w,input,back,padding,stride)
    input_h=size(input,1);
    input_w=size(input,2);
    input_tunnel=size(input,3);
    sample_num=size(input,4);
    output_h=fix((input_h-h+padding+stride)/stride);
    output_w=fix((input_w-w+padding+stride)/stride);
    input_padding=zeros(input_h+padding,input_w+padding,input_tunnel,sample_num);
    dinput_padding=zeros(input_h+padding,input_w+padding,input_tunnel,sample_num);
    for i=1:input_tunnel
        for j=1:sample_num
            input_padding(padding/2+1 : padding/2+input_h,padding...
                /2+1 : padding/2+input_w,i,j)=input(:,:,i,j);
        end
    end
    output=zeros(output_h,output_w,input_tunnel,sample_num);
    dinput=zeros(input_h,input_w,input_tunnel,sample_num);
    for i=1:input_tunnel
        for j=1:sample_num
            k=1;
            l=1;
            o=1;
            p=1;
                while l+h-1 <= input_h+padding
                    while k+w-1 <= input_w+padding
                        sum=input_padding(l,k,i,j);
                        max_h=l;
                        max_w=k;
                        for m=0:w-1
                            for n=0:h-1
                                if sum < input_padding(l+n,k+m,i,j)
                                    sum = input_padding(l+n,k+m,i,j);
                                    max_h=l+n;
                                    max_w=k+m;
                                end
                            end
                        end
                      dinput_padding(max_h,max_w,i,j)=back(p,o,i,j);
                      output(p,o,i,j)=sum;
                      k=k+stride;
                      o=o+1;
                    end
                    k=1;
                    o=1;
                    l=l+stride;
                    p=p+1;
                end
        end
    end
    for i=1:input_tunnel
        for j=1:sample_num
            dinput(:,:,i,j)=dinput_padding(padding/2+1 : padding/2+input_h,padding...
                /2+1 : padding/2+input_w,i,j);
        end
    end
end