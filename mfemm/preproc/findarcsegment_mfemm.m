function id = findarcsegment_mfemm(FemmProblem, loc)
% finds the arc segment nearest a given location
%
% Syntax
%
% [id] = findarcsegment_mfemm(FemmProblem, loc)
%
% 

% Copyright 2014 Richard Crozier
% 
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
% 
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.

    % get the mid points of the subsegments making up the arc segment
    [xm, ym] = arcsegmidpoints_mfemm (FemmProblem);
    
    for indi = 1:size (loc,1)
        
        % find the nearest midpoint to the location for each arc and the distance
        %
        % ipdm returns a structure with fields named 'rowindex', 'columnindex' and 
        % 'distance'
        dists = ones (size(xm,1),1) * nan;
        for indi = 1:size (xm,1)
            result = ipdm(loc, [xm(indi,:)', ym(indi,:)'], ...
                          'Result', 'Structure', ...
                          'Subset', 'NearestNeighbor');
                          
            dists(indi) = result.distance;
        end
        
        % get the indices of the closest arc segment
        [~,id(indi)] = min (dists);
        
        % id is zero based
        id(indi) = id(indi) - 1;
        
    end

end


function [xm, ym] = arcsegmidpoints_mfemm (FemmProblem)
% gets the discretised arc segment points making up each arc segment

    % get all the node locations from the problem
    nodes = getnodecoords_mfemm (FemmProblem);
    
    % get all the arc segment link info, multiple rows of:
    % [ n0, n1, arc length, max segment degrees ] 
    links = getarclinks_mfemm (FemmProblem);
    
    % get the node locations of the arc segments start and end points
    A = nodes(links(:,1)+1,:);
    B = nodes(links(:,2)+1,:);
    
    % get the discretised arc points
    [x, y] = arcpoints(A, B, links(:,3), links(:,4));
    
    % now calculate the midpoints of the subsegments
    xm = [x(:,2:end) + x(:,1:end-1)] ./ 2;
    ym = [y(:,2:end) + y(:,1:end-1)] ./ 2;
    
end
