async function get_raw(string $url): Awaitable<string> {
  return await \HH\Asio\curl_exec($url);
}

<<__EntryPoint>>
function join_main(): void {
  $result = \HH\Asio\join(get_raw("http://www.example.com"));
  \var_dump($result);
}
