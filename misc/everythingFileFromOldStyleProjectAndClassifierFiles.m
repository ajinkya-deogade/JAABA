function ...
  everythingFileFromOldStyleProjectAndClassifierFiles(...
    everythingFileName, ...
    projectFileName, ...
    classifierFileName, ...
    gtExpDirNames)

% load the project params
try
  projectParams=load(projectFileName,'-mat');
catch excp
  if isequal(excp.identifier,'MATLAB:load:notBinaryFile')
    message=sprintf('Project file %s is not a binary .mat file', ...
                    fileNameRelFromAbs(projectFileName));
    throw(MException(excp.identifier,message));
  else
    rethrow(excp);
  end
end

% load the classifier params and (normal) labels
if isempty(classifierFileName)
  classifierParams=struct([]);
else
  try
    classifierParams=load(classifierFileName,'-mat');
  catch excp
    if isequal(excp.identifier,'MATLAB:load:notBinaryFile')
      message=sprintf('Classifier file %s is not a binary .mat file', ...
                      fileNameRelFromAbs(classifierFileName));
      throw(MException(excp.identifier,message));
    else
      rethrow(excp);
    end
  end
end

% load the gt labels
gtLabelFileNameLocal=projectParams.file.gt_labelfilename;
gtLabels=struct([]);
for i=1:length(gtExpDirNames)
  gtExpDirName=gtExpDirNames{i};
  gtLabelFilePathName=fullfile(gtExpDirName,gtLabelFileNameLocal);
  try
    gtLabelsThis=load(gtLabelFilePathName,'-mat');
  catch excp
    if isequal(excp.identifier,'MATLAB:load:notBinaryFile')
      message=sprintf('GT label file %s is not a binary .mat file', ...
                      fileNameRelFromAbs(gtLabelFilePathName));
      throw(MException(excp.identifier,message));
    else
      rethrow(excp);
    end
  end  % try/catch    
  if i==1 ,
    gtLabels=gtLabelsThis;
  else
    gtLabels(i)=gtLabelsThis;
  end
end

% convert to everything params
everythingParams= ...
  everythingFromOldStyleProjectAndClassifier(projectParams, ...
                                             classifierParams, ...
                                             gtExpDirNames, ...
                                             gtLabels);  %#ok
                                           
% save to a file                                           
save(everythingFileName,'-struct','everythingParams');  

end                                    

