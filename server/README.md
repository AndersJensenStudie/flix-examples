# Server
A simple server for static HTML-pages, written entirely in Flix

# TODO
- [x] Better read-parser. Should read until it sees /r/n/r/n and not just 4096 bytes.
- [ ] Better read-parser. Should read until it sees /r/n/r/n and not just the first line.
- [ ] Is `Connection: close\r\n` a correct choice? 
- [ ] Which headers in requests should be looked at, and which are irrelevant?
- [partially] Effectful rewrite. Should just use serve and then chose to run it with/out routes with a handler