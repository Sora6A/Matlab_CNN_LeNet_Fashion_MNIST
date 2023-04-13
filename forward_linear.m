function output=forward_linear(input,weight,bias)
    sample_num=size(input,1);
    output=zeros(sample_num,size(weight,2));
    for i=1:sample_num
        output(i,:)=input(i,:)*weight+bias;
    end
end