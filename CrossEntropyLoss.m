function loss=CrossEntropyLoss(label,predict_output)
    loss=0;
    for i=1:size(label,1)
        for j=1:size(label,2)
            loss=loss-label(i,j)*log(predict_output(i,j));
        end
    end
end