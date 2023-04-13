function output=CNN_Predict(weight1,weight2,weight3,weight4,weight5,bias1,bias2,bias3,bias4,bias5,input)
%     input=zeros(28,28,1000);
%     weight1=zeros(5,5,6);
%     weight2=zeros(5,5,6,16);
%     weight3=zeros(400,120);
%     weight4=zeros(120,84);
%     weight5=zeros(84,10);
%     bias1=0;
%     bias2=0;
%     bias3=0;
%     bias4=0;
%     bias5=0;
    z1=forward_convolution1(weight1,bias1,input,4,1);
    [a1,~]=Leaky_Relu(z1);
    a2=forward_max_pool(2,2,a1,0,2);
    z3=forward_convolution(weight2,bias2,a2,0,1);
    [a3,~]=Leaky_Relu(z3);
    a4=forward_max_pool(2,2,a3,0,2);
    a4e=expand_4D(a4);
    z5=forward_linear(a4e,weight3,bias3);
    [a5,~]=My_Leaky_Relu(z5);
    z6=forward_linear(a5,weight4,bias4);
    [a6,~]=my_sigmoid(z6);
    z7=forward_linear(a6,weight5,bias5);
    a7=my_softmax(z7);
    output=a7;
    
end