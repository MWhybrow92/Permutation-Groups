##
## Exercise 1
##

# Let G equal the Mathieu group M_11
G := MathieuGroup(11);

# Find all conjugacy classes of subgroups of G
cc := ConjugacyClassesSubgroups(G);

# Find only conjugacy classes of elementary abelian subgroups of order 4
cc := Filtered( cc, x -> Order(Representative(x)) = 4 );
cc := Filtered( cc, x -> IsElementaryAbelian(Representative(x)) );

# Find only conjugacy classes of subgroups equal to their own subgroups. In fact,
# this isn't necessary in this case - why not?
cc := Filtered( cc, x -> Centralizer(G, Representative(x)) = Representative(x));

# Count the subgroups in these conjugacy class(es)
Display( Sum( List(cc, Size) ) );

##
## Exercise 2
##

# Combine the above steps into a function called <Exercise2>

Exercise2 := function(G)

    # We only need one local variable, cc
    local cc;

    cc := ConjugacyClassesSubgroups(G);

    cc := Filtered( cc, x -> Order(Representative(x)) = 4 );
    cc := Filtered( cc, x -> IsElementaryAbelian(Representative(x)) );
    cc := Filtered( cc, x -> Centralizer(G, Representative(x)) = Representative(x));

    return Sum( List(cc, Size) );

end ;

# You will maybe realise that <ConjugacyClassesSubgroups> takes a long time for
# larger groups. It is more efficient to first use <SylowSubgroup>.

Exercise2_improved := function(G)

    local cc, sylow, reps;

    sylow := SylowSubgroup(G,2);
    cc := ConjugacyClassesSubgroups(sylow);

    reps := List(cc, Representative);
    reps := Filtered(reps, x -> Order(x) = 4);
    reps := Filtered(reps, IsElementaryAbelian);
    reps := Filtered(reps, x -> Centralizer(G, x) = x );

    cc := List(reps, x -> ConjugacyClassSubgroups(G,x));
    cc := DuplicateFreeList(cc);

    return Sum( List(cc, Size) );

end ;

##
## Exercise 3
##

# Write a function that uses the small groups library to run the function
# <Exercise2_improved> for all groups of size 4k.

Exercise3 := function(n)

    local ids, results;

    if not IsInt(n/4) then
        Error("Input must be an integer multiple of 4");
    fi;

    ids := IdsOfAllSmallGroups(n);
    results := List( ids, x -> Exercise2_improved( SmallGroup(x) ) );

    return [ids, results];

end;

# Run this function on as many orders as you want.
for n in [4, 8 .. 96] do
    list := Exercise3( n );
    nonzero := Number(list[2], x -> x <> 0);
    Print( "Of ", Size(list[1]), " groups of order ", n, " there are ", nonzero, " that have such a subgroup \n" );
od;
