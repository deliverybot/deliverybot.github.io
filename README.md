# Deliverybot site

https://deliverybot.dev

The marketing site, docs and blog for [Deliverybot](https://github.com/deliverybot/deliverybot),
built with [Jekyll](https://jekyllrb.com).

## Development

Install Ruby (see `.ruby-version`) and Node.js, then:

    bundle install
    npm ci        # Primer CSS, bundled from assets/primer.scss
    make start    # serve on http://localhost:3000
    make build    # build into _site
    make test     # check the built site for broken links

The `Pages` workflow builds and checks every pull request, and deploys `master`
to GitHub Pages.

## Adding an integration

1. [Add parameters to integrations.yml](_data/integrations.yml).
1. [Add an install page to /docs/integrations](docs/integrations/).

## Search engines and AI assistants

Give every page a `description` in its front matter; it becomes the meta
description and the summary in `/llms.txt`. Docs pages under `docs/` also get a
Markdown copy (`/docs/quickstart.md` for `/docs/quickstart/`) and are bundled
into `/llms-full.txt` by `_plugins/llms.rb`.
