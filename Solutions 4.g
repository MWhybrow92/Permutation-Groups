ONanScottIntransitiveCase := function(n)

    local max, k;

    max := [];

    for k in [2 .. Int(n/2)] do
        Add(max, DirectProduct(SymmetricGroup(k), SymmetricGroup(n -k)));
    od;

    return Filtered(max, G -> IntermediateGroup(SymmetricGroup(n), G) = fail);

end;

ONanScottImprimitiveCase := function(n)

    local div, max, k;

    div := Filtered(DivisorsInt(n), i -> not i in [1, n]);

    max  := [];

    for k in div do
        Add(max, WreathProductImprimitiveAction(SymmetricGroup(k), SymmetricGroup(n/k)));
    od;

    return Filtered(max, G -> IntermediateGroup(SymmetricGroup(n), G) = fail);

end;
