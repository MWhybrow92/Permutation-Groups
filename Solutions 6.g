DerangementsPermGroup := function(G)

    local cc, degree, derangements, x;

    cc :=  ConjugacyClasses(G);
    degree := NrMovedPoints(G);
    derangements := [];

    for x in cc do
        if NrMovedPoints(Representative(x)) = degree then
            Append(derangements, AsList(x));
        fi;
    od;

    return derangements;

end;

SemiregularEltsPermGroup := function(G)

    local derangements, semiregular, x, cycle;

    derangements := DerangementsPermGroup(G);
    semiregular := [];

    for x in derangements do
        cycle := CycleStructurePerm(x);
        if Size(Flat(cycle)) = 1 then
            Add(semiregular, x);
        fi;
    od;

    return semiregular;

end;
