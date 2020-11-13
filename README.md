# FT_SERVICES by cbaek

```text
                                     ╭───────╮
                                     │ World │
                                     ╰───┬───╯
                                         │
                           ╭─────────────┷──────────╮
                           │ Load Balancer(MetalLB) │
                           ╰─────────────┬──────────╯
     ┌────────────┬────────────────────┬─┴────────────────────┬───────────┐
     │3000        │5050                │80/443/22             │5000       │21
╭────┷────╮ ╭─────┷─────╮ Redirect ╭───┷───╮ Reverse... ╭─────┷──────╮ ╭──┷───╮
│ Grafana │ │ WordPress ┠──────────│ NginX ├────────────┨ PhpMyAdmin │ │ FTPS │
╰─┯─────┬─╯ ╰───┬────┯──╯          ╰───┬───╯            ╰─────┬─┯────╯ ╰──┬───╯
  │     │       │     ╲                │                      │  ╲   ┌────┘
  │data └─────┐ │      └───────────────┼──────────────────────┼───┴──┼──────┐
  │           │ │                      │                      │      │ data │
  │           │ │                      │                      │     ┌┘      │
┌─┴────────┐  │ │                      │                      │     │ ┌─────┷─┐
│ InfluxDB ┠──┴─┴──────────────────────┴──────────────────────┴─────┴─│ MySQL │
└──────────┘ Metrics                                                  └───────┘
```