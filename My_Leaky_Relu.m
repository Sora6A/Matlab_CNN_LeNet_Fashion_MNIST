function [output,d_output]=My_Leaky_Relu(input)
    input_length=size(input,2);
    sample_num=size(input,1);
    output=zeros(sample_num,input_length);
    d_output=zeros(sample_num,input_length);
    for i=1:sample_num
        for j=1:input_length
            if input(i,j) > 0.1*input(i,j)
                output(i,j)=input(i,j);
                d_output(i,j)=1;
            else
                output(i,j)=0.1*input(i,j);
                d_output(i,j)=0.1;
            end
        end
    end
end