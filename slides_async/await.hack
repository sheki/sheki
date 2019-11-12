function lib_potato_multi_fetch(Container<user_t> $user) : Awaitable<vec<Result<Potato>>> {
  $potatoes = Vec\map($users, ($user ==> ud_fetch_potato($user['id'])));
  return $potatoes;
}

PREFER

async function lib_potato_multi_fetch(Container<user_t> $user) : Awaitable<vec<Result<Potato>>> {
  $potatoes = await Vec\map($users, ($user ==> ud_fetch_potato($user['id'])));
  return $potatoes;
}
