Seamless (hopefully) way to use Grit as a service.

In your config/initializer or other startup place do:

Grit::Git.bertrpc(host, port)

From then on Grit calls that use Git will seamlessly use BERT-RPC to make calls to your service running on host:port.
