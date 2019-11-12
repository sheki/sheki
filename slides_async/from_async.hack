async function ud_fetch_potato(int user_id) : Result<Potato> {
   if (DARK_MODE)
      ...
   if (LIGHT_MODE)
      ...
   if (DUSK)
    ...
}

function lib_potato_multi_fetch(Container<int> $user_ids) : vec<Result<Potato>> {
  $potatoes = Vec\map($user_ids, ($user_id ==> \HH\Asio\join(ud_fetch_potato($user_id))));
  // add some horseradish
  return $potatoes;
}

OR

function lib_potato_multi_fetch(Container<int> $user_ids) : vec<Result<Potato>> {
  $awaitables = Vec\map($user_ids, ($user_id) ==> ud_fetch_potato($user_id));
  $potatoes = HH\Asio\join($awaitables);
  // add some mustard
  return $potatoes;
}
