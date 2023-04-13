function output=forward_convolution1(weight,bias,input,padding,stride)
%     input=[0,1,2;3,4,5;6,7,8];
%     bias = 0;
%     weight=[0,1;2,3];
%     padding=2;
%     stride=1;
    h=size(input,1);
    w=size(input,2);
    sample_num=size(input,3);
    Kh=size(weight,1);
    Kw=size(weight,2);
    output_h=fix((h-Kh+padding+stride)/stride);
    output_w=fix((w-Kw+padding+stride)/stride);
    output_tunnel=size(weight,3);
    input_padding=zeros(h+padding,w+padding,sample_num);
    for i=1:sample_num
        input_padding(padding/2+1 : padding/2+h,padding...
                /2+1 : padding/2+w,i)=input(:,:,i);
    end
    output=zeros(output_h,output_w,output_tunnel,sample_num);
        for j=1:sample_num
            for z=1:output_tunnel
            k=1;
            l=1;
            o=1;
            p=1;
                while l+Kh-1 <= h+padding
                    while k+Kw-1 <= w+padding
                        sum=0;
                        for m=0:Kw-1
                            for n=0:Kh-1
                                sum=sum+input_padding(l+n,k+m,j)*weight(n+1,m+1,z);
                            end
                        end
                      output(p,o,z,j)=sum + bias;
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
end