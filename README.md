# dockerized-erigon

Enable remote access to ports: 8545, 8546, 30303.

```bash
docker-compose up -d
```

## Pruning

New flag `--prune` replaces `--storage-mode`.

**`--prune` is an INVERSION of `--storage-mode`**

Examples:

* `--storage-mode=h` => "keep history";
* `--prune=h` means "PRUNE history".
* if you using `--storage-mode=ht` the equivalent is `--prune=rc`

New flag docs:

* `h` - prune history (ChangeSets, HistoryIndices - used by historical state access)
* `r` - prune receipts (Receipts, Logs, LogTopicIndex, LogAddressIndex - used by `eth_getLogs` and similar RPC methods)
* `t` - prune transaction by it's hash index
* `c` - prune call traces (used by `trace_*` methods)

By default, `--prune` deletes data older than 90K blocks from the tip of the chain (aka, for if tip block is no. 12'000'000, only the data between 11'910'000-12'000'000 will be kept).

Thus could be overridden by `--prune.<mode>.older` flags.
E.g. `--prune.h.older=1000000` keeps the last 1'000'000 historical entries.

`--prune=` (empty list) means no pruning (full archive mode).
