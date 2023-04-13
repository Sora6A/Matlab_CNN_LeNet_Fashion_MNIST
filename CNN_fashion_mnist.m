disp('Loading dataset......');
[train_set,train_label,test_set,test_label]=...
    load_dataset('fashion-mnist_train.csv','fashion-mnist_test.csv');
disp('Loading dataset complete!');
disp('Start trainning......');

sample_num=size(train_set,3);
batch_size=256;
epoch=30;
lr=0.001;

weight1=normrnd(0,0.1,[5 5 6]);
weight2=normrnd(0,0.1,[5 5 6 16]);
weight3=normrnd(0,0.1,[400 120]);
weight4=normrnd(0,0.1,[120 84]);
weight5=normrnd(0,0.1,[84 10]);
bias1=normrnd(0,0.01);
bias2=normrnd(0,0.01);
bias3=normrnd(0,0.01,[1 120]);
bias4=normrnd(0,0.01,[1 84]);
bias5=normrnd(0,0.01,[1 10]);

for i=1:epoch
    vector=randperm(sample_num);
    A=zeros(28,28,sample_num);
    B=zeros(sample_num,10);
    for k=1:sample_num
        A(:,:,k)=train_set(:,:,vector(k));
        B(k,:)=train_label(vector(k),:);
    end
    train_set=A;
    train_label=B;
    for j=1:fix(sample_num/batch_size)
        lr_=lr*((epoch-i)/epoch);
        [weight1,weight2,weight3,weight4,weight5,bias1,bias2,bias3,...
        bias4,bias5,loss,acc]=...
        Train_CNN(train_set(:,:,(j-1)*batch_size+1:j*batch_size),...
        train_label((j-1)*batch_size+1:j*batch_size,:),weight1,weight2,weight3,weight4,...
        weight5,bias1,bias2,bias3,bias4,bias5,lr_);
        disp(['epoch:',num2str(i),'/',num2str(epoch),'  batch:',...
            num2str(j),'/',num2str(fix(sample_num/batch_size)),...
            '  loss:',num2str(loss),'  accuracy:',num2str(acc)]);
    end
end
disp('Train complete!');

predict_label=zeros(size(test_label,1),10);
output=CNN_Predict(weight1,weight2,weight3,weight4,weight5,...
    bias1,bias2,bias3,bias4,bias5,test_set);
Tcount=0;
for i=1:size(test_set,3)
    max_=output(i,1);
    count=1;
        for j=1:10
            if max_ < output(i,j)
                max_=output(i,j);
                count=j;
            end
        end
        if test_label(i,count) == 1
            Tcount=Tcount+1;
        end
end
for i=1:size(test_set,3)
    [val,idx]=max(output(i,:));
    predict_label(i,idx)=1;
end
acc=Tcount/size(test_set,3);
disp(['Testset accuracy=',num2str(acc)]);
