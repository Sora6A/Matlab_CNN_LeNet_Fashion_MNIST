function [train_set,train_label,test_set,test_label]=load_dataset(train_file_name,test_file_name)
    train_set = readtable(train_file_name);
    test_set = readtable(test_file_name); 
    train_label=table2array(train_set(:,1));
    test_label=table2array(test_set(:,1));
    train_label_reshape=zeros(length(train_label),10);
    test_label_reshape=zeros(length(test_label),10);
    for i=1:length(train_label)
        j=train_label(i);
        train_label_reshape(i,j+1)=1;
    end
    for i=1:length(test_label)
        j=test_label(i);
        test_label_reshape(i,j+1)=1;
    end
    train_label=train_label_reshape;
    test_label=test_label_reshape;
    train_set=table2array(train_set(:,2:end));
    test_set=table2array(test_set(:,2:end));
    train_set_reshape=zeros(28,28,length(train_set));
    test_set_reshape=zeros(28,28,length(test_set));
    for i=1:length(train_set)
        train_set_reshape(:,:,i)=reshape(train_set(i,:),28,28)';
    end
    for i=1:length(test_set)
        test_set_reshape(:,:,i)=reshape(test_set(i,:),28,28)';
    end
    train_set=train_set_reshape;
    test_set=test_set_reshape;
end