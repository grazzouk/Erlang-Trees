-module(erlangTrees).
-export([tdepth/1, leaves/1, flatten/1, idx/2]).

-type value() :: integer().
-type tree() :: leaf
 | {node,value(),tree(),tree()}. 

%Function that measures the depth of the longest branch of a tree.
-spec tdepth(tree()) -> integer().
tdepth(leaf) -> 0;
tdepth({node, _, T1, T2})-> 
	case tdepth(T1) > tdepth(T2) of
		true -> 1 + tdepth(T1);
		false -> 1 + tdepth(T2)
		end.

%Counts the leaves in a tree.
-spec leaves(tree()) -> integer().
leaves(leaf) -> 1;
leaves({node, _, T1, T2}) -> 
	leaves(T1) + leaves(T2).

%Flattens the tree into a list from the leaf furthest left to the leaf furthest right.
-spec flatten(tree()) -> [value()].
flatten(leaf) -> [];
flatten({node, V, T1, T2}) -> 
	A = [V] ++ flatten(T2),
	flatten(T1) ++ A.

%Finds the Nth element of a tree by flattening it and finding the Nth element of the created list.
-spec idx(tree(), integer()) -> value().
idx({node, V, T1, T2}, N) -> 
	find( N, flatten({node, V, T1, T2})).

find(0, [X|_]) -> X;
find(_, []) -> none_found;
find(N, [_|Xs]) -> find(N-1, Xs).
	




	