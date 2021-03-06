function [teams, stats] = parseTeamStats(filename)
% Summary:  Function for parsing NCAA team statistics sets and returning
%           arrays containing the data.
% 
% @params
% filename: The name of the file to parse
%
% @returns
% teams:  Team names (team)
% stats:  Statistics (total score, total opponent score,
%                     mean score, mean opponent score,
%                     score variance, opponent score variance, 
%                     losses, wins, win probability, num matches)
    
    f = fopen(filename); % Open for read
    
    % Column names
    colNames = strrep(strsplit(strtrim(fgets(f)), ','), '"', '');
    if length(colNames) ~= 12
        error('File not correct format')
    end
   
    % Gather all of the lines 
    data = [];
    while ~feof(f)
        line = strrep(strsplit(strtrim(fgets(f)), ','), '"', '');
        data = [data; line];
    end
    fclose(f); % Close up the file
    
    % Team names
    teams = data(:,2);
    
    % Statistics corresponding to teams
    stats = str2double(data(:,3:12));
    
    return;
end
