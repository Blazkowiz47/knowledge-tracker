# Device Status

Each publisher owns one file:

```text
system/sync/device-status/<node>.yaml
```

Use this shape:

```yaml
version: 1
node: workstation-01
role: publisher
last_success_at:
last_change_at:
last_error_at:
last_error:
source_records_seen:
pending_count: 0
```

Routine successful no-op syncs update this file rather than human logs.
