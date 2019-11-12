async function f(): Awaitable<int> {
  return 2;
}

$x = foo();         // $x will be an Awaitable<int>
$x = await foo();   // $x will be an int
