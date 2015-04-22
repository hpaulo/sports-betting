function f = objectiveFunc(x,winProbs,expectations,variances,bettingPools,theta,deterministic,markovitz,numMatches)

bettingPools = bettingPools;


theta = theta;
%probability of a team winning over another team, deterministic
winProbs = winProbs;

%expected value of a team winning over another team and the variance
expectations = expectations;
variances = variances;
f = 0; 

if deterministic == true

    for i = 1:numMatches
        returnEq1 = (-1)*winProbs(i,1)*(x(2*i-1)+bettingPools(i,1)+x(2*i)+bettingPools(i,2))*...
                        (x(2*i-1)/(x(2*i-1)+bettingPools(i,1)));
        returnEq2 = (-1)*winProbs(i,2)*(x(2*i-1)+bettingPools(i,1)+x(2*i)+bettingPools(i,2))*...
                        (x(2*i)/(x(2*i)+bettingPools(i,2)));             
        f = f +returnEq1 + returnEq2;
    end
            
elseif markovitz == true;
    %equation is of the form --> min -E(z)+theta*sqrt(z)
    %seems to only ever select one team to place whole bet on
    for i = 1:numMatches
        returnEq1 = (-1)*expectations(i,1)*(x(2*i-1)+bettingPools(i,1)+x(2*i)+bettingPools(i,2))*...
                        (x(2*i-1)/(x(2*i-1)+bettingPools(i,1)));
        returnEq2 = (-1)*expectations(i,2)*(x(2*i-1)+bettingPools(i,1)+x(2*i)+bettingPools(i,2))*...
                        (x(2*i)/(x(2*i)+bettingPools(i,2)));
                    
        penalty = theta*sqrt((variances(i,1)*(returnEq1)^2)+...
                             (variances(i,2)*(returnEq2)^2)-...
                             2*(returnEq1*returnEq2*(sqrt(variances(i,1)))*(sqrt(variances(i,2)))));
                         
        f = f + returnEq1 + returnEq2 + penalty;
    end
        
end