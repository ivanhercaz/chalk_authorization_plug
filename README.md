# ChalkAuthorizationPlug

This is a plug meant to be used with
`ChalkAuthorization` to handle
routing access permissions.

## Installation

This package is [available in
Hex](https://hexdocs.pm/chalk_authorization_plug), and can be installed by
adding `chalk_authorization_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chalk_authorization_plug, "~> 0.1.1"},
    …
  ]
end
```

If you haven't `ChalkAuthorization` already installed, you must add it too in your
list of dependencies:

```elixir
def deps do
  [
    {:chalk_authorization, "~> 0.1.1"},
    {:chalk_authorization_plug, "~> 0.1.1"},
    …
  ]
end
```

## Usage

`ChalkAuthorization` aims to ease the authorization requirements.

- If you already have `ChalkAuthorization` implemented in your application,
you can directly read `ChalkAuthorization.Plug` documentation.
- If you haven't `ChalkAuthorization` implemented, first, checks its
documentation.