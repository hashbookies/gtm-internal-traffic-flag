# Internal Traffic Flag

GTM variable template for flagging likely internal or QA traffic using URL and host-based signals.

## Overview

Internal Traffic Flag is a lightweight Google Tag Manager custom variable template for flagging likely internal, QA, staging, or testing traffic using URL query parameters and optional host rules.

This is a client-side helper for identifying likely internal or QA traffic. For robust internal traffic controls, combine it with GA4 filters, server-side logic, or other governance controls where appropriate.

## What it does

- Checks for a configured query parameter such as `notrack`.
- Optionally requires a specific query parameter value.
- Optionally checks the current host against configured host fragments.
- Returns either `internal` or `external`.

## When to use it

- Use it to create GTM exception triggers for QA or staging traffic.
- Use it to populate a reporting dimension for likely internal traffic.
- Use it when teams use URLs such as `https://example.com/?notrack=true` during testing.

## When not to use it

- Do not use it as a complete replacement for IP filters.
- Do not use it as a guarantee that all internal traffic is removed from reporting.
- Do not use it when server-side controls are required for governance.

## Setup

1. In Google Tag Manager, go to **Templates**.
2. Under **Variable Templates**, click **New**.
3. Open the three-dot menu and choose **Import**.
4. Import `template.tpl`.
5. Save the template.
6. Create a new variable using **Internal Traffic Flag**.

## Configuration

### Query Parameter Name

The query parameter used to flag likely internal traffic.

Default:

```text
notrack
```

### Required Query Parameter Value

Optional. If provided, the query parameter must match this value.

Example:

```text
true
```

### Internal Host Matches

Optional comma-separated list of host fragments that should return `internal`.

Example:

```text
staging.example.com,qa.example.com,localhost
```

## Testing examples

URL:

```text
https://example.com/?notrack=true
```

Expected output:

```text
internal
```

Host:

```text
staging.example.com
```

Expected output when `staging.example.com` is configured as a host match:

```text
internal
```

## Limitations

- This is a client-side helper, not an IP-based filter.
- This template does not guarantee exclusion from reporting.
- Users can remove or omit URL query parameters.
- Host matching is based on string fragments configured by the GTM user.

## Maintainer

Created and maintained by Tayo Kolade.

This template is part of a small collection of independent open-source Google Tag Manager utilities for general measurement and reporting use cases.

## Disclaimer

This is an independent open-source utility created for general Google Tag Manager use cases. It is not affiliated with or endorsed by Google or any third-party platform provider.
