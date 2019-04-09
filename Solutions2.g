## Exercise 4

LengthsOfTransitiveActions := function(G)

    local cc;

    # Find representatives of the conjugacy classes of subgroups of G
    cc := ConjugacyClassesSubgroups(G);
    cc := List(cc, Representative);

    # Calculate the index of each subgroup in G, this gives the orbit lengths
    return List(cc, H -> IndexNC(G,H));

end;

## Exercise 5

InducedActionsOnBlocks := function(G)

    local B;

    # Find representatives of all block systems of G
    B := AllBlocks(G);

    # Use these to calculate the full block system
    B := List(B, b -> Orbit(G, Set(b), OnSets));

    # Return the groups induced by the actions on the block systems
    return List(B, b -> Action(G, b, OnSets));

end;
