function ac=svm_classifier_type_final(tst,trn,TrLabels,TestLabels)

%https://github.com/JaimeIvanCervantes/FaceRecognition/blob/master/src/main.m

% Where : tst is the test image as a column
%         trn is the training images as a columns
%         type is the type of the minimum distance
             
%[a1,b1]=size(tst);
%[a2,b2]=size(trn);
%X=zeros(b1+b2,a1);
%X(1,:)=tst';
%X(2:b1+b2,:)=trn';

model = ovrtrain(TrLabels, trn);
[ac decv] = ovrpredict(TestLabels, tst, model);
fprintf('Accuracy = %g%%\n', ac);


