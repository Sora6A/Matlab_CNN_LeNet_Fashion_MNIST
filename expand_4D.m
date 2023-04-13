function input_reshape=expand_4D(input)
    input_h=size(input,1);
    input_w=size(input,2);
    input_tunnel=size(input,3);
    sample_num=size(input,4);
    input_reshape=zeros(sample_num,input_h*input_w*input_tunnel);
    for i=1:sample_num
        start=0;
        for j=1:input_tunnel
            for k=1:input_h
                input_reshape(i,start+1:start+input_w)=input(k,:,j,i);
                start=start+input_w;
            end
        end
    end
end