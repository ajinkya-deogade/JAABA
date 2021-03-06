function scoreFeatures= ...
  replaceScoreFeatureClassifierFileNames(scoreFeatures, ...
                                         scoreFeatureMatFileNames, ...
                                         scoreFeatureJabFileNames)

% scoreFeatures a 1xn structure array with fields:
%   classifierfile: the name of the classifier file
%   ts: the classifier time stamp
%   scorefilename: the name of the score file generated by the classifier
% if an element's classifierfile field matches an element of
% scoreFeatureMatFileNames, it is replaced (in the output) with the corresponding 
% element of scoreFeatureJabFileNames

classifierFileNames={scoreFeatures.classifierfile};
n=length(scoreFeatures);
for i=1:n
  j=whichstr(classifierFileNames{i},scoreFeatureMatFileNames);
  if ~isempty(j)
    scoreFeatures(i).classifierfile=scoreFeatureJabFileNames{j};
  end
end

end
