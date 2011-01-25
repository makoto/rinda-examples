% jijixi.azito.com/cgi-bin/diary/index.rb?date=20070108
ThreeByTreeList = [[1,2,3],[4,5,6],[7,8,9]].
TwoByTreeList = [[1,2],[4,5],[7,8]].
RandomList = [[1,2,3],[4],[7,8]].

case ThreeByTreeList of
  [[_,_,_],[_,_,_],[_,_,_]] -> 
    io:fwrite('three dimensional ~n');
  _ ->
    io:fwrite('no match~n')
end.

case TwoByTreeList of
  [[_,_,_],[_,_,_],[_,_,_]] -> 
    io:fwrite('three dimensional ~n');
  _ ->
    io:fwrite('no match~n')
end.

case RandomList of
  [[_,_,_],[_,_,_],[_,_,_]] -> 
    io:fwrite('three dimensional ~n');
  _ ->
    io:fwrite('no match~n')
end.