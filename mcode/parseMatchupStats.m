function [matchups, stats] = parseMatchupStats(filename)
% Summary:  Function for parsing NCAA matchup statistics sets and returning
%           arrays containing the data.
% 
% @params
% filename: The name of the file to parse
%
% @returns
% matchups: Team names (team, opponent)
% stats:    Statistics (losses, wins, win probability, num matches)
    
    f = fopen(filename); % Open for read
    
    % Column names
    colNames = strrep(strsplit(strtrim(fgets(f)), ','), '"', '');
    if length(colNames) ~= 7
        error('File not correct format')
    end
   
    % Gather all of the lines 
    data = [];
    while ~feof(f)
        line = strrep(strsplit(strtrim(fgets(f)), ','), '"', '');
        data = [data; line];
    end
    fclose(f); % Close up the file
    
    % Team names in matchups
    matchups = data(:,2:3);
    
    % Statistics corresponding to teams
    stats = str2double(data(:,4:7));
    
    return;
end
