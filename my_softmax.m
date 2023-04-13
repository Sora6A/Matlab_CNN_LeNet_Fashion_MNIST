function output=my_softmax(input)
    length=size(input,2);
    sample_num=size(input,1);
    output=zeros(sample_num,length);
    for i=1:sample_num
        sum=0;
        for j=1:length
            sum=sum+exp(input(i,j));
        end
        for j=1:length
            output(i,j)=exp(input(i,j))/sum;
        end
    end
end