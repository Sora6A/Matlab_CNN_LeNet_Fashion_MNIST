function input_reshape=Transfer_to_4D(input,h,w,tunnel)
   sample_num=size(input,1);
   input_reshape=zeros(h,w,tunnel,sample_num);
   for i=1:sample_num
        start=0;
        for j=1:tunnel
            for k=1:h
                input_reshape(k,:,j,i)=input(i,start+1:start+w);
                start=start+w;
            end
        end
    end
end