function [weight1,weight2,weight3,weight4,weight5,bias1,bias2,bias3,...
    bias4,bias5,loss,acc]=...
    Train_CNN(train_data_set,label,weight1,weight2,weight3,weight4,...
    weight5,bias1,bias2,bias3,bias4,bias5,lr)
%     [train_data_set,label,~]=load_dataset('fashion-mnist_test.csv','fashion-mnist_test.csv');
% %     sample_num=1000;
%     lr=0.05;
%     train_data_set=train_data_set(:,:,1:20);
%     label=label(1:20,:);
%     weight1=normrnd(0,0.01,[5 5 6]);
%     weight2=normrnd(0,0.01,[5 5 6 16]);
%     weight3=normrnd(0,0.01,[400 120]);
%     weight4=normrnd(0,0.01,[120 84]);
%     weight5=normrnd(0,0.01,[84 10]);
%     bias1=normrnd(0,0.01);
%     bias2=normrnd(0,0.01);
%     bias3=normrnd(0,0.01,[1 120]);
%     bias4=normrnd(0,0.01,[1 84]);
%     bias5=normrnd(0,0.01,[1 10]);

    sample_num=size(train_data_set,3);
    z1=forward_convolution1(weight1,bias1,train_data_set,4,1);
    [a1,dz1_]=Leaky_Relu(z1);
    a2=forward_max_pool(2,2,a1,0,2);
    z3=forward_convolution(weight2,bias2,a2,0,1);
    [a3,dz3_]=Leaky_Relu(z3);
    a4=forward_max_pool(2,2,a3,0,2);
    a4e=expand_4D(a4);
    z5=forward_linear(a4e,weight3,bias3);
    [a5,dz5_]=My_Leaky_Relu(z5);
    z6=forward_linear(a5,weight4,bias4);
    [a6,dz6_]=my_sigmoid(z6);
    z7=forward_linear(a6,weight5,bias5);
    a7=my_softmax(z7);
    loss=CrossEntropyLoss(label,a7);

    Tcount=0;
    for i=1:sample_num
        max=a7(i,1);
        count=1;
        for j=1:10
            if max < a7(i,j)
                max=a7(i,j);
                count=j;
            end
        end
        if label(i,count) == 1
            Tcount=Tcount+1;
        end
    end
    acc=Tcount/sample_num;

    dz7=a7-label;
    da6=dz7*(weight5');
    dz6=da6.*dz6_;
    da5=dz6*(weight4');
    dz5=da5.*dz5_;
    da4e=dz5*(weight3');
    da4=Transfer_to_4D(da4e,5,5,16);
    da3=backward_max_pool(2,2,a3,da4,0,2);
    dz3=da3.*dz3_;
    [dweight2,dbias2,da2]=backward_convolution(weight2,a2,dz3,0,1);
    da1=backward_max_pool(2,2,a1,da2,0,2);
    dz1=da1.*dz1_;
    [dweight1,dbias1,~]=backward_convolution1(weight1,train_data_set,dz1,4,1);

    dbias5=zeros(1,10);
    dbias4=zeros(1,84);
    dbias3=zeros(1,120);
    dweight5=zeros(84,10);
    dweight4=zeros(120,84);
    dweight3=zeros(400,120);
    for i=1:sample_num
        dbias5=dbias5+dz7(i,:);
        for j=1:size(dweight5,2)
            dweight5(:,j)=dweight5(:,j)+dz7(i,j)*a6(i,:)';
        end
        dbias4=dbias4+dz6(i,:);
        for j=1:size(dweight4,2)
            dweight4(:,j)=dweight4(:,j)+dz6(i,j)*a5(i,:)';
        end
        dbias3=dbias3+dz5(i,:);
        for j=1:size(dweight3,2)
            dweight3(:,j)=dweight3(:,j)+dz5(i,j)*a4e(i,:)';
        end
    end
    bias5=bias5-lr*dbias5;
    bias4=bias4-lr*dbias4;
    bias3=bias3-lr*dbias3;
    bias2=bias2-lr*dbias2;
    bias1=bias1-lr*dbias1;
    weight5=weight5-lr*dweight5;
    weight4=weight4-lr*dweight4;
    weight3=weight3-lr*dweight3;
    weight2=weight2-lr*dweight2;
    weight1=weight1-lr*dweight1;
end