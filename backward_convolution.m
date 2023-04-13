function [dweight,dbias,dinput]=backward_convolution(weight,input,back,padding,stride)
    h=size(input,1);
    w=size(input,2);
    input_tunnel=size(input,3);
    sample_num=size(input,4);
    Kh=size(weight,1);
    Kw=size(weight,2);
    output_tunnel=size(weight,4);
    input_padding=zeros(h+padding,w+padding,input_tunnel,sample_num);
    dweight=zeros(Kh,Kw,input_tunnel,output_tunnel);
    dbias=0;
    dinput=zeros(h,w,input_tunnel,sample_num);
    dinput_padding=zeros(h+padding,w+padding,input_tunnel,sample_num);
    for i=1:input_tunnel
        for j=1:sample_num
            input_padding(padding/2+1 : padding/2+h,padding...
                /2+1 : padding/2+w,i,j)=input(:,:,i,j);
        end
    end
    for i=1:input_tunnel
        for j=1:sample_num
            for z=1:output_tunnel
            k=1;
            l=1;
            o=1;
            p=1;
                while l+Kh-1 <= h+padding
                    while k+Kw-1 <= w+padding
                        for m=0:Kw-1
                            for n=0:Kh-1
                                dweight(n+1,m+1,i,z)=dweight(n+1,m+1,i,z)+back(p,o,z,j)*input_padding(l+n,k+m,i,j);
                                dinput_padding(l+n,k+m,i,j)=dinput_padding(l+n,k+m,i,j)+back(p,o,z,j)*weight(n+1,m+1,i,z);
                            end
                        end
                      dbias=dbias+back(p,o,z,j);
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
    for i=1:input_tunnel
        for j=1:sample_num
            dinput(:,:,i,j)=dinput_padding(padding/2+1 : padding/2+h,padding...
                /2+1 : padding/2+w,i,j);
        end
    end
end