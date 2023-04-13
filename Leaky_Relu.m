function [output,d_output]=Leaky_Relu(input)
    input_h=size(input,1);
    input_w=size(input,2);
    input_tunnel=size(input,3);
    sample_num=size(input,4);
    output=zeros(input_h,input_w,input_tunnel,sample_num);
    d_output=zeros(input_h,input_w,input_tunnel,sample_num);
    for i=1:input_h
        for j=1:input_w
            for k=1:input_tunnel
                for l=1:sample_num
                    if input(i,j,k,l) > 0.1*input(i,j,k,l)
                        output(i,j,k,l)=input(i,j,k,l);
                        d_output(i,j,k,l)=1;
                    else
                        output(i,j,k,l)=0.1*input(i,j,k,l);
                        d_output(i,j,k,l)=0.1;
                    end
                end
            end
        end
    end
end