function [output,d_output]=my_sigmoid(input)
    length=size(input,2);
    sample_num=size(input,1);
    output=zeros(sample_num,length);
    d_output=zeros(sample_num,length);
    for i=1:sample_num
        for j=1:length
            output(i,j)=sigmoid(input(i,j));
            d_output(i,j)=d_sigmoid(input(i,j));
        end
    end
end

function output=d_sigmoid(input)
    output=sigmoid(input)*(1-sigmoid(input));
end
function output=sigmoid(input)
    output=1/(1+exp(-1*input));
end